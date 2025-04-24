{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file=$layout}

{block name='notifications'}
{/block}

{block name='breadcrumb'}
{/block}

{block name='content_columns'}
  {include file='checkout/checkout-navigation.tpl'}

  {block name='checkout_notifications'}
    {include file='_partials/notifications.tpl'}
  {/block}

  <div class="columns-container container">
    <div id="center-column" class="center-column page page--full-width">
      <div class="checkout-grid row">
        <div class="checkout-grid__content col-lg-8">
          <div class="tab-content">
            {block name='checkout_process'}
              {render file='checkout/checkout-process.tpl' ui=$checkout_process}
            {/block}
          </div>
        </div>

        <div class="checkout-grid__aside col-lg-4">
          <div class="checkout__summary-accordion accordion">
            <div class="checkout__summary-accordion-item accordion-item">
              <div class="checkout__summary-accordion-header accordion-header">
                <button class="accordion-button" type="button" data-bs-target="#js-checkout-summary" data-bs-toggle="collapse" aria-expanded="true">
                  {l s='Order summary' d='Shop.Theme.Checkout'}
                </button>
              </div>

              {block name='cart_summary'}
                <div class="checkout__summary-accordion-wrapper cart-summary js-checkout-summary">
                  {include file='checkout/_partials/cart-summary.tpl' cart=$cart}
                </div>
              {/block}
            </div>
          </div>

          {hook h='displayReassurance'}
        </div>
      </div>
    </div>
  </div>

  {include file='checkout/_partials/modal-terms.tpl'}
{/block}
