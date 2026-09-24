#!/usr/bin/env node
/**
 * The theme's class names are BEM and they say what they are, so a test has no
 * business guessing at them. This reads the real ones out of the theme and
 * prints them, so a suite is written against classes that exist rather than
 * against a hopeful `[class*="price"]`.
 *
 * It reads the templates, which is where a class actually reaches the browser,
 * and the stylesheets, which is where the block is defined. A class present in
 * both is a real, styled hook. A class only in a template is still real. A
 * class only in the stylesheet is dead weight, or is applied from JavaScript,
 * and is reported separately because it is the one a test should not lean on.
 *
 * Usage, from the theme checkout:
 *
 *   node docs/qa/bem-inventory.mjs                     the whole inventory
 *   node docs/qa/bem-inventory.mjs price               blocks matching "price"
 *   node docs/qa/bem-inventory.mjs --block product     one block in full
 *   node docs/qa/bem-inventory.mjs --json              machine readable
 *
 * Why this exists: during a QA pass the selectors that were guessed rather than
 * read (the pager, the footer collapses, the cart line, the price) each produced
 * a failure that looked like a theme defect and was not. Every one of them was a
 * class sitting in these files all along.
 */

import { readFileSync, readdirSync, statSync } from 'node:fs';
import { join, extname, relative } from 'node:path';

const ROOT = process.cwd();
const TEMPLATE_DIRS = ['templates', 'modules'];
const STYLE_DIRS = ['src/scss'];

// Bootstrap and vendor classes are not the theme's own vocabulary; a test that
// leans on them is testing Bootstrap. They are kept out of the inventory.
const VENDOR = /^(btn|col|row|d|m[tbslrxy]?|p[tbslrxy]?|g[xy]?|text|bg|border|justify|align|flex|order|offset|position|top|bottom|start|end|w|h|mw|mh|rounded|shadow|float|overflow|visually|sr|fs|fw|lh|opacity|z|vstack|hstack|ratio|container|navbar|nav|dropdown|modal|offcanvas|carousel|accordion|collapse|badge|alert|card|form|input|is|has|active|show|fade|disabled|selected|sticky|fixed|clearfix|close|spinner|placeholder|table|list|breadcrumb|pagination|page|tooltip|popover|toast|progress|material|icon|fa|rtl)(-|$)/;

function walk(dir, exts, out = []) {
  let entries;
  try { entries = readdirSync(join(ROOT, dir)); } catch { return out; }
  for (const e of entries) {
    const rel = join(dir, e);
    let st;
    try { st = statSync(join(ROOT, rel)); } catch { continue; }
    if (st.isDirectory()) walk(rel, exts, out);
    else if (exts.includes(extname(e))) out.push(rel);
  }
  return out;
}

/** block, block__element, block--modifier, block__element--modifier */
function parseBem(cls) {
  const m = /^([a-z][a-z0-9-]*?)(?:__([a-z0-9-]+))?(?:--([a-z0-9-]+))?$/.exec(cls);
  if (!m) return null;
  return { block: m[1], element: m[2] || null, modifier: m[3] || null };
}

const inventory = new Map(); // block -> { elements, modifiers, templates, styles }

function note(cls, kind, file) {
  const bem = parseBem(cls);
  if (!bem || VENDOR.test(cls)) return;
  // A bare one-word class with no element and no modifier is usually a state
  // or a vendor leftover; keep it only when it is also a real BEM block.
  if (!inventory.has(bem.block)) {
    inventory.set(bem.block, { elements: new Map(), modifiers: new Set(), templates: new Set(), styles: new Set() });
  }
  const b = inventory.get(bem.block);
  if (kind === 'template') b.templates.add(file); else b.styles.add(file);
  if (bem.element) {
    if (!b.elements.has(bem.element)) b.elements.set(bem.element, { modifiers: new Set(), inTemplate: false, inStyle: false });
    const el = b.elements.get(bem.element);
    if (kind === 'template') el.inTemplate = true; else el.inStyle = true;
    if (bem.modifier) el.modifiers.add(bem.modifier);
  } else if (bem.modifier) {
    b.modifiers.add(bem.modifier);
  }
}

// --- templates: class="..." and Smarty {$componentName}__thing patterns
for (const dir of TEMPLATE_DIRS) {
  for (const f of walk(dir, ['.tpl'])) {
    const src = readFileSync(join(ROOT, f), 'utf8');
    // The theme sets {$componentName = 'subcategory'} then writes
    // class="{$componentName}__link", so resolve that before reading classes.
    const comp = /\{\$componentName\s*=\s*'([a-z0-9-]+)'\}/i.exec(src);
    const resolved = comp ? src.replaceAll('{$componentName}', comp[1]) : src;
    for (const m of resolved.matchAll(/class="([^"]+)"/g)) {
      for (const cls of m[1].split(/\s+/)) {
        if (cls && !cls.includes('{') && !cls.includes('$')) note(cls, 'template', f);
      }
    }
  }
}

// --- stylesheets: selectors, including BEM nesting written as &__thing
for (const dir of STYLE_DIRS) {
  for (const f of walk(dir, ['.scss', '.css'])) {
    let src = readFileSync(join(ROOT, f), 'utf8');
    // The theme names its block once, as `$component-name: cart-summary-product;`
    // and then writes `.#{$component-name}` and `&__element`. Resolve that first
    // or every element in 82 of these files reads as unstyled.
    const cn = /\$component-name\s*:\s*([a-z0-9-]+)\s*;/i.exec(src);
    if (cn) src = src.replaceAll('#{$component-name}', cn[1]);
    const stack = [];
    for (const raw of src.split('\n')) {
      const line = raw.trim();
      if (!line || line.startsWith('//') || line.startsWith('/*')) continue;
      const open = line.endsWith('{');
      if (open) {
        const sel = line.slice(0, -1).trim();
        const parent = stack[stack.length - 1] || '';
        let resolvedSel = sel;
        if (sel.startsWith('&')) resolvedSel = parent + sel.slice(1);
        stack.push(resolvedSel.startsWith('.') ? resolvedSel.split(/[\s,:>]/)[0] : parent);
        for (const m of resolvedSel.matchAll(/\.([a-z][a-z0-9_-]*)/g)) note(m[1], 'style', f);
      } else if (line.startsWith('}')) {
        stack.pop();
      }
    }
  }
}

// ------------------------------------------------------------------- output

const args = process.argv.slice(2);
const asJson = args.includes('--json');
const blockFlag = args.indexOf('--block');
const onlyBlock = blockFlag >= 0 ? args[blockFlag + 1] : null;
const query = args.find((a) => !a.startsWith('--') && a !== onlyBlock);

let blocks = [...inventory.entries()]
  .filter(([name, b]) => b.elements.size > 0 || b.modifiers.size > 0)  // real BEM only
  .sort(([a], [b]) => a.localeCompare(b));

if (onlyBlock) blocks = blocks.filter(([n]) => n === onlyBlock);
else if (query) {
  const q = query.toLowerCase();
  blocks = blocks.filter(([n, b]) =>
    n.includes(q) || [...b.elements.keys()].some((e) => e.includes(q)));
}

if (asJson) {
  const out = {};
  for (const [name, b] of blocks) {
    out[name] = {
      elements: Object.fromEntries([...b.elements].map(([e, v]) => [e, {
        selector: `.${name}__${e}`,
        modifiers: [...v.modifiers],
        rendered: v.inTemplate,
        styled: v.inStyle,
      }])),
      modifiers: [...b.modifiers],
      templates: [...b.templates],
    };
  }
  console.log(JSON.stringify(out, null, 2));
  process.exit(0);
}

if (!blocks.length) {
  console.log(query || onlyBlock ? `nothing matches "${query || onlyBlock}"` : 'no BEM blocks found');
  process.exit(1);
}

for (const [name, b] of blocks) {
  const where = [...b.templates].slice(0, 3).map((f) => relative('.', f));
  console.log(`\n.${name}`);
  if (b.modifiers.size) console.log(`  modifiers: ${[...b.modifiers].map((m) => `--${m}`).join(' ')}`);
  if (where.length) console.log(`  rendered by: ${where.join(', ')}${b.templates.size > 3 ? ` (+${b.templates.size - 3})` : ''}`);
  for (const [el, v] of [...b.elements].sort()) {
    // A class that is styled but never rendered is the one a test must not use.
    const flag = v.inTemplate ? (v.inStyle ? '' : '   (rendered, not styled)') : '   (styled, never rendered — do not test on this)';
    const mods = v.modifiers.size ? `  [${[...v.modifiers].map((m) => `--${m}`).join(' ')}]` : '';
    console.log(`    .${name}__${el}${mods}${flag}`);
  }
}

console.log(`\n${blocks.length} block(s).`);
