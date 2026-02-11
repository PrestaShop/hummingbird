{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Return details' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  {block name='order_return_infos'}
    <div id="order-return-infos" class="card">
      <div class="card-block">
        <p>
          <strong>{l
            s='%number% on %date%'
            d='Shop.Theme.Customeraccount'
            sprintf=['%number%' => $return.return_number, '%date%' => $return.return_date]}
          </strong>
        </p>

        <p>{l s='We have logged your return request.' d='Shop.Theme.Customeraccount'}</p>

        <hr class="my-4">

        <h2 class="h3">{l s='List of items to be returned:' d='Shop.Theme.Customeraccount'}</h2>

        <div class="grid-table grid-table--collapse" role="table" aria-label="{l s='Return details' d='Shop.Theme.Customeraccount'}">
          <div class="grid-table__inner grid-table__inner--2" role="rowgroup">
            <div class="grid-table__header" role="row">
              <span class="grid-table__cell" role="columnheader">{l s='Product' d='Shop.Theme.Catalog'}</span>
              <span class="grid-table__cell grid-table__cell--right" role="columnheader">{l s='Quantity' d='Shop.Theme.Checkout'}</span>
            </div>

            {foreach from=$products item=product}
              <div class="grid-table__row" role="row">
                <span class="grid-table__cell" role="cell" data-ps-label="{l s='Product' d='Shop.Theme.Catalog'}">
                  <span class="grid-table__cell-group grid-table__cell-group--sm">
                    <strong>{$product.product_name}</strong>

                    {if $product.product_reference}
                      <small class="text-secondary">
                        {l s='Reference: %reference%' sprintf=['%reference%' => $product.product_reference] d='Shop.Theme.Catalog'}
                      </small>
                    {/if}

                    {if $product.customizations}
                      {foreach from=$product.customizations item="customization"}
                        <span id="product_customization_modal_wrapper_{$customization.id_customization}">
                          {include file='catalog/_partials/customization-modal.tpl' customization=$customization}
                        </span>

                        <span class="customization">
                          <a class="btn btn-sm btn-link p-0" href="#" data-bs-toggle="modal"
                            data-bs-target="#product-customizations-modal-{$customization.id_customization}">
                            <i class="material-icons">&#xE8F4;</i>
                            {l s='Product customization' d='Shop.Theme.Catalog'}
                          </a>
                        </span>
                      {/foreach}
                    {/if}
                  </span>
                </span>

                <span class="grid-table__cell grid-table__cell--right" role="cell" data-ps-label="{l s='Quantity' d='Shop.Theme.Checkout'}">
                  {$product.product_quantity}
                </span>
              </div>
            {/foreach}
          </div>
        </div>

        <hr class="my-4">

        <p>
          {l
            s='Your package must be returned to us within %number% days of receiving your order.'
            d='Shop.Theme.Customeraccount'
            sprintf=[
              '%number%' => $configuration.number_of_days_for_return
            ]
          }
        </p>

        <p>
          {* [1][/1] is for a HTML tag. *}
          {l
            s='The current status of your merchandise return is: [1] %status% [/1]'
            d='Shop.Theme.Customeraccount'
            sprintf=[
              '[1]' => '<strong>',
              '[/1]' => '</strong>',
              '%status%' => $return.state_name
            ]
          }
        </p>
      </div>
    </div>
  {/block}

  {if $return.state == 2}
    <hr class="my-4">

    <section class="order-return-reminder">
      <h3>{l s='Reminder' d='Shop.Theme.Customeraccount'}</h3>

      <p class="alert alert-info" role="alert">
        {l
          s='All merchandise must be returned in its original packaging and in its original state.'
          d='Shop.Theme.Customeraccount'
        }
      </p>

      <p>
        {* [1][/1] is for a HTML tag. *}
        {l
          s='Please print out the [1]returns form[/1] and include it with your package.'
          d='Shop.Theme.Customeraccount'
          sprintf=[
            '[1]' => '<a href="'|cat:$return.print_url|cat:'">',
            '[/1]' => '</a>'
          ]
        }
        
        {* [1][/1] is for a HTML tag. *}
        {l
          s='Please check the [1]returns form[/1] for the correct address.'
          d='Shop.Theme.Customeraccount'
          sprintf=[
            '[1]' => '<a href="'|cat:$return.print_url|cat:'">',
            '[/1]' => '</a>'
          ]
        }
      </p>

      <p>
        {l
          s='When we receive your package, we will notify you by email. We will then begin processing order reimbursement.'
          d='Shop.Theme.Customeraccount'
        }
        <a href="{$urls.pages.contact}">
          {l
            s='Please let us know if you have any questions.'
            d='Shop.Theme.Customeraccount'
          }
        </a>
        {l
          s='If the conditions of return listed above are not respected, we reserve the right to refuse your package and/or reimbursement.'
          d='Shop.Theme.Customeraccount'
        }
      </p>
    </section>
  {/if}
{/block}
