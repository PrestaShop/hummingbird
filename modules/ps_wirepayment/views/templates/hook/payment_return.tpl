{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="card border-1 mb-3">
  <div class="card-body">
    <p class="h4">{l s='Payment information' d='Shop.Theme.Checkout'}</p>
    <p class="h6 card-subtitle mb-3 text-muted">{l s='Pay by Bank Wire' d='Modules.Wirepayment.Shop'}</p>
    {if $status === 'ok'}
      <p>
        {l s='You have chosen payment by bank transfer.' d='Modules.Wirepayment.Shop'}<br/>
        {l s='Please send us a bank transfer with following details:' d='Modules.Wirepayment.Shop'}
      </p>

      <div class="row mt-2">
        <div class="col-md-6 fw-bold mb-2 mb-md-0">
          {l s='Amount' d='Modules.Wirepayment.Shop'}
        </div>
        <div class="col-md-6">
          {$total}
        </div>
      </div>
      <hr/>
      <div class="row">
        <div class="col-md-6 fw-bold mb-2 mb-md-0">
          {l s='Name of account owner' d='Modules.Wirepayment.Shop'}
        </div>
        <div class="col-md-6">
          {$bankwireOwner}
        </div>
      </div>
      <hr/>
      <div class="row">
        <div class="col-md-6 fw-bold mb-2 mb-md-0">
          {l s='Please include these details' d='Modules.Wirepayment.Shop'}
        </div>
        <div class="col-md-6">
          {$bankwireDetails nofilter}
        </div>
      </div>
      <hr/>
      <div class="row mb-4">
        <div class="col-md-6 fw-bold mb-2 mb-md-0">
          {l s='Bank name' d='Modules.Wirepayment.Shop'}
        </div>
        <div class="col-md-6">
        {$bankwireAddress nofilter}
        </div>
      </div>
      <hr>
      <p class="mb-0">
        {l s='Please specify your order reference %s in the bankwire description.' sprintf=[$reference] d='Modules.Wirepayment.Shop'}<br/>
        {l s='We\'ve also sent you this information by e-mail.' d='Modules.Wirepayment.Shop'}<br/>
        {l s='Your order will be sent as soon as we receive payment.' d='Modules.Wirepayment.Shop'}
      </p>
    {else}
      <div class="alert alert-warning mt-3 mb-0" role="alert">
        {l
          s='We noticed a problem with your order. If you think this is an error, feel free to contact our [1]expert customer support team[/1].'
          d='Modules.Wirepayment.Shop' sprintf=['[1]' => "<a class='alert-link' href='{$contact_url}'>", '[/1]' => '</a>']
        }
      </div>
    {/if}
  </div>
  {if $status === 'ok'}
    <div class="card-footer p-3 border-1">
      {l
        s='If you have questions, comments or concerns, please contact our [1]expert customer support team[/1].' 
        d='Modules.Wirepayment.Shop' sprintf=['[1]' => "<a class='alert-link' href='{$contact_url}'>", '[/1]' => '</a>']
      }
    </div>
  {/if}
</div>
