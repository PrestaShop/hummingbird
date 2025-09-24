{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div id="ps_cashondelivery-displayOrderConfirmation" class="card border-1 mb-3">
  <div class="card-body">
    <p class="h2">{l s='Payment information' d='Shop.Theme.Checkout'}</p>

    <p class="h3 card-subtitle text-secondary mb-3">{l s='Pay by Cash on Delivery' d='Modules.Cashondelivery.Shop'}</p>

    <p class="mb-0">
      {l s='Your order on %s is complete.' sprintf=[$shop_name] d='Modules.Cashondelivery.Shop'}<br aria-hidden="true">
      {l s='You have chosen the cash on delivery method.' d='Modules.Cashondelivery.Shop'}<br aria-hidden="true">
      {l s='Your order will be sent very soon.' d='Modules.Cashondelivery.Shop'}
    </p>
  </div>

  <div class="card-footer p-3 border-1">
    {l s='For any questions or for further information, please contact our' d='Modules.Cashondelivery.Shop'}
    <a href="{$contact_url}" rel="nofollow">{l s='customer support' d='Modules.Cashondelivery.Shop'}</a>.
  </div>
</div>
