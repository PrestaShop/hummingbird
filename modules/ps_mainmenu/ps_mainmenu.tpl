{* PrestaShop license placeholder *}
{function name="generateLinks" links=[] class="menu-item" parent=null}
{* GENERATE LINKS *}
  {if $parent.depth === 1}
    {foreach from=$links item=link}
      {if $link.depth === 3 && $link.children|count}
      <div class="{$class|escape:'htmlall':'UTF-8'}__group--child">
      {elseif $link.depth === 3 && !$link.children|count}
      <div class="{$class|escape:'htmlall':'UTF-8'}__group--nochild">
      {/if}

        <a
          class="{$class|escape:'htmlall':'UTF-8'} {if $link.depth === 3}{$class|escape:'htmlall':'UTF-8'}__group-main-item{/if}"
          href="{$link.url|escape:'htmlall':'UTF-8'}"
          data-depth="{$link.depth|escape:'htmlall':'UTF-8'}"
          {if $link.open_in_new_window}target="_blank"{/if}
        >
          {$link.label|escape:'htmlall':'UTF-8'}
        </a>
        {call name=generateLinks links=$link.children parent=$parent}

      {if ($link.depth === 3 && $link.children|count) || ($link.depth === 3 && !$link.children|count)}
      </div>
      {/if}
    {/foreach}
  {/if}
{/function}

{* GENERATE SUBMENU *}
{function name="desktopSubMenu" nodes=[] depth=0 parent=null}
  {if $nodes|count}
    {if $depth === 1}
      <div class="js-sub-menu submenu">
        <div class="container">
          <div class="submenu__row row gx-5">
    {/if}

    {if $depth === 1 }
      <div class="submenu__left col-sm-3">
        {foreach from=$nodes item=node}
          <a
            class="submenu__left-item {if $node.children|count}has-child{/if}"
            href="{$node.url|escape:'htmlall':'UTF-8'}"
            data-depth="{$node.depth|escape:'htmlall':'UTF-8'}"
            {if $node.children|count}data-open-tab="submenu_{$node.label|lower|classname|escape:'htmlall':'UTF-8'}_{$node.depth|escape:'htmlall':'UTF-8'}_{$node.page_identifier}"{/if}
            {if $node.open_in_new_window}target="_blank"{/if}
          >
            {$node.label|escape:'htmlall':'UTF-8'}
          </a>
        {/foreach}
      </div>
    {/if}

    {if $depth === 1 }
      <div class="submenu__right col-sm-9">
        {foreach from=$nodes item=node}
          <div class="submenu__right-items" id="submenu_{$node.label|lower|classname|escape:'htmlall':'UTF-8'}_{$node.depth|escape:'htmlall':'UTF-8'}_{$node.page_identifier}">
            {generateLinks links=$node.children parent=$parent}
          </div>
        {/foreach}
      </div>
    {/if}

    {foreach from=$nodes item=node}
      {if $node.children|count}
        {desktopSubMenu nodes=$node.children depth=$node.depth parent=$node}
      {/if}
    {/foreach}

    {if $depth === 1}
          </div>
        </div>
      </div>
    {/if}
  {/if}
{/function}

{* GENERATE FIRST LEVEL *}
{function name="desktopFirstLevel" itemsFirstLevel=[]}
  {if $itemsFirstLevel|count}
    <ul id="top-menu" class="main-menu__tree" data-depth="0">
      {foreach from=$itemsFirstLevel item=menuItem}
        <li class="type-{$menuItem.type|escape:'htmlall':'UTF-8'} {if $menuItem.current} current{/if} main-menu__tree__item" id="{$menuItem.page_identifier|escape:'htmlall':'UTF-8'}">
          <a
            class="main-menu__tree__link{if $menuItem.children|count} dropdown-toggle{/if}"
            href="{$menuItem.url|escape:'htmlall':'UTF-8'}"
            data-depth="0"
            {if $menuItem.open_in_new_window}target="_blank"{/if}
          >
            {$menuItem.label|escape:'htmlall':'UTF-8'}
          </a>

          {desktopSubMenu nodes=$menuItem.children depth=$menuItem.depth parent=$menuItem}
        </li>
      {/foreach}
    </ul>
  {/if}
{/function}

{* GENERATE DESKTOP MENU *}
{function name="desktopMenu" nodes=[] depth=0 parent=null}
  {desktopFirstLevel itemsFirstLevel=$nodes}
{/function}

{* GENERATE MOBILE MENU *}
{function name="mobileMenu" nodes=[] depth=0 parent=null}
  {$children = []}
  {if $nodes|count}
    <nav
      class="menu menu--mobile{if $depth === 0} menu--current js-menu-current{else} menu--child js-menu-child{/if}"
      {if $depth === 0}id="menu-mobile"{else}data-parent-title="{$parent.label|escape:'htmlall':'UTF-8'}"{/if}
      {if $depth > 1}data-back-title="{$backTitle|escape:'htmlall':'UTF-8'}" data-id="{$expandId|escape:'htmlall':'UTF-8'}"{/if}
      data-depth="{$depth|escape:'htmlall':'UTF-8'}"
    >
      <ul class="menu__list">
        {if $depth >= 1}
          <li class="main-menu__title h5">{$parent.label|escape:'htmlall':'UTF-8'}</li>
        {/if}
        {foreach from=$nodes item=node}
          <li
            class="type-{$node.type|escape:'htmlall':'UTF-8'} {if $node.current} current{/if} {if $node.children|count} menu--childrens{/if}"
            id="{$node.page_identifier|escape:'htmlall':'UTF-8'}"
          >
            <a
              class="{if $depth>= 0}menu__link{/if}"
              href="{$node.url|escape:'htmlall':'UTF-8'}"
              data-depth="{$depth|escape:'htmlall':'UTF-8'}"
              {if $node.open_in_new_window}target="_blank"{/if}
            >
            {$node.label|escape:'htmlall':'UTF-8'}
            </a>
            {if $node.children|count}
              {* Cannot use page identifier as we can have the same page several times *}
              {assign var=_expand_id value=10|mt_rand:100000}
              <button class="main-menu__toggle-child btn btn-link btn-tertiary-icon js-menu-open-child" data-target="{$_expand_id|escape:'htmlall':'UTF-8'}">
                <span data-target="#top_sub_menu_{$_expand_id|escape:'htmlall':'UTF-8'}">
                  <i class="material-icons rtl-flip">chevron_right</i>
                </span>
              </button>
            {/if}
          </li>
          {if $node.children|count}
            {$node.parent = $node}
            {$node.expandId = $_expand_id}
            {$children[] = $node}
          {/if}
        {/foreach}
      </ul>
    </nav>
    {foreach from=$children item=child}
      {mobileMenu
        nodes=$child.children
        depth=$child.children[0].depth
        parent=$child backTitle=$child.parent.label
        expandId=$child.expandId
      }
    {/foreach}
  {/if}
{/function}

<div class="main-menu col-xl col-auto">
  {* DESKTOP MENU *}
  <div class="d-none d-xl-block position-static js-menu-desktop menu-desktop">
    {desktopMenu nodes=$menu.children}
  </div>

  {* MOBILE MENU *}
  <div class="mobile-toggle d-xl-none">
    <a
      class="menu-toggle btn btn-link btn-tertiary-icon"
      href="#"
      role="button"
      data-bs-toggle="offcanvas"
      data-bs-target="#mobileMenu"
      aria-controls="mobileMenu"
    >
      <span class="material-icons">menu</span>
    </a>
  </div>
</div>

<div
  class="main-menu__offcanvas offcanvas offcanvas-start js-menu-canvas"
  tabindex="-1"
  id="mobileMenu"
  aria-labelledby="mobileMenuLabel"
>
  <div class="offcanvas-header">
    <div class="main-menu__back-button">
      <button class="btn btn-link btn-sm d-none js-back-button" type="button">
        <span class="material-icons rtl-flip">chevron_left</span>
        <span class="js-menu-back-title">{l s='All' d='Shop.Theme.Global'}</span>
      </button>
    </div>
    <button type="button" class="btn-close btn btn-tertiary text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>

  <div class="main-menu__mobile">
    {mobileMenu nodes=$menu.children}
  </div>

  <div class="main-menu__additionnals offcanvas-body d-flex flex-wrap align-items-center gap-3">
    <div class="main-menu__selects d-flex gap-2 me-auto">
      <div id="_mobile_ps_currencyselector" class="col-auto"></div>
      <div id="_mobile_ps_languageselector" class="col-auto"></div>
    </div>
    <div id="_mobile_ps_contactinfo"></div>
  </div>
</div>
