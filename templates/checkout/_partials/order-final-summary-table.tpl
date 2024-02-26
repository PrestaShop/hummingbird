{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='checkout/_partials/order-confirmation-table.tpl'}

{block name='order-items-table-head'}
  <div id="order-items">
    <p class="card-title h3">
      {if $products_count == 1}
        {l s='%product_count% item in your cart' sprintf=['%product_count%' => $products_count] d='Shop.Theme.Checkout'}
      {else}
        {l s='%products_count% items in your cart' sprintf=['%products_count%' => $products_count] d='Shop.Theme.Checkout'}
      {/if}

      <a href="{url entity=cart params=['action' => 'show']}"><span class="step-edit"><i class="material-icons edit" aria-hidden="true">mode_edit</i> {l s='edit' d='Shop.Theme.Actions'}</span></a>
    </p>
  </div>
{/block}

{block name='order-confirmation-classes'} bg-light p-4 rounded{/block}
