/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
import defaultContent from './default.html';
import minContent from './min.html';
import maxContent from './max.html';
import loadingContent from './loading.html';
import rtlContent from './rtl.html';

export default {
  title: 'Theme/JavaScript/Components/QuantitySelector',
  parameters: {
    docs: {
      autodocs: false,
    }
  }
};

const withSource = (content, story) => ({
  docs: {
    source: {code: content},
    description: {story},
  },
});

export const Default = () => defaultContent;
Default.parameters = withSource(defaultContent, `
<h1>Quantity selector</h1>

<p>Rendered by <code>templates/components/qty-input.tpl</code>, driven by <code>src/js/components/quantity-selector</code>.
Listeners are delegated to the document: selectors injected by Ajax (cart refresh, quickview, product list) need no init call.</p>

<h2>data-ps-* contract</h2>
<ul>
  <li><code>data-ps-component="quantity-selector"</code> on the root</li>
  <li><code>data-ps-context</code>: <code>product</code> (emits <code>updateProduct</code>), <code>quickview</code> and <code>listing</code> (value only, the form carries it), <code>cart</code> (Ajax update of the line)</li>
  <li><code>data-ps-state</code>: <code>idle</code> | <code>loading</code></li>
  <li><code>data-ps-data</code>: cart only, JSON with <code>updateUrl</code>, <code>idProduct</code>, <code>idProductAttribute</code>, <code>idCustomization</code></li>
  <li><code>data-ps-ref="quantity-input"</code>, <code>data-ps-action="quantity-decrement|quantity-increment"</code>, <code>data-ps-ref="quantity-status"</code> (live region)</li>
</ul>

<h2>Behaviour</h2>
<p>Buttons, arrow keys and typing change the value within <code>min</code>/<code>max</code>. The value is confirmed 500 ms after the last change, or right away on Enter / change.
Buttons at a bound get <code>aria-disabled="true"</code> and stay focusable.
Each confirmed change dispatches a bubbling <code>quantity:changed</code> CustomEvent with <code>{root, context, value, previous}</code>.</p>
`);

export const AtMinimum = () => minContent;
AtMinimum.parameters = withSource(minContent, '<p>Minimal quantity of 3: decrement is disabled.</p>');

export const AtMaximum = () => maxContent;
AtMaximum.parameters = withSource(maxContent, '<p>Cart line limited by the stock (<code>max</code>): increment is disabled.</p>');

export const Loading = () => loadingContent;
Loading.parameters = withSource(loadingContent, '<p>While a cart update is pending: <code>data-ps-state="loading"</code>, read-only input, both buttons disabled.</p>');

export const RightToLeft = () => rtlContent;
RightToLeft.parameters = withSource(rtlContent, '<p>In an RTL page the group keeps <code>dir="ltr"</code>: decrement stays on the left, increment on the right.</p>');
