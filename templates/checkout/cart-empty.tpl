{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='checkout/cart.tpl'}

{block name='continue_shopping' append}
  <a class="cart__continue-shopping btn btn-outline-primary" href="{$urls.pages.index}">
    <i class="material-icons rtl-flip" aria-hidden="true">&#xE5C4;</i>
    {l s='Continue shopping' d='Shop.Theme.Actions'}
  </a>
{/block}

{block name='cart_actions'}
  <div class="cart-summary__actions checkout">
    <div class="d-grid">
      <button type="button" class="btn btn-primary disabled" disabled>{l s='Checkout' d='Shop.Theme.Actions'}</button>
    </div>
  </div>
{/block}

{block name='continue_shopping'}{/block}
{block name='cart_voucher'}{/block}
{block name='display_reassurance'}{/block}
