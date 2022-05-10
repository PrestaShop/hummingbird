{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="card border-1 mb-3">
  <div class="card-body">
    <h4 class="h4">{l s='Payment information' d='Shop.Theme.Checkout'}</h4>
    <h6 class="card-subtitle mb-3 text-muted">{l s='Pay by Cash on Delivery' d='Modules.Cashondelivery.Shop'}</h6>
    <p class="mb-0">
      {l s='You have chosen the cash on delivery method.' d='Modules.Cashondelivery.Shop'}<br>
      {l s='Your order will be sent very soon.' d='Modules.Cashondelivery.Shop'}
    </p>
  </div>
  <div class="card-footer p-3 border-1">
    {l s='For any questions or for further information, please contact our' d='Modules.Cashondelivery.Shop'}
    <a class="alert-link" href="{$contact_url}">{l s='customer support' d='Modules.Cashondelivery.Shop'}</a>.
  </div>
</div>
