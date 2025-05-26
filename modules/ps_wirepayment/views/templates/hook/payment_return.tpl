{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="card border-1 mb-3">
  <div class="card-body">
    <p class="h2">{l s='Payment information' d='Shop.Theme.Checkout'}</p>

    <p class="h3 card-subtitle text-secondary mb-3">{l s='Pay by Bank Wire' d='Modules.Wirepayment.Shop'}</p>

    {if $status === 'ok'}
      <p>
        {l s='You have chosen payment by bank transfer.' d='Modules.Wirepayment.Shop'}<br/>
        {l s='Please send us a bank transfer with following details:' d='Modules.Wirepayment.Shop'}
      </p>

      <dl class="dl-list mb-3">
        <dt>{l s='Amount' d='Modules.Wirepayment.Shop'}</dt>
        <dd>{$total}</dd>
        <dt>{l s='Name of account owner' d='Modules.Wirepayment.Shop'}</dt>
        <dd>{$bankwireOwner}</dd>
        <dt>{l s='Please include these details' d='Modules.Wirepayment.Shop'}</dt>
        <dd>{$bankwireDetails nofilter}</dd>
        <dt>{l s='Bank name' d='Modules.Wirepayment.Shop'}</dt>
        <dd>{$bankwireAddress nofilter}</dd>
      </dl>

      <p class="mb-0">
        {l s='Please specify your order reference %s in the bankwire description.' sprintf=[$reference] d='Modules.Wirepayment.Shop'}<br/>
        {l s='We\'ve also sent you this information by e-mail.' d='Modules.Wirepayment.Shop'}<br/>
        {l s='Your order will be sent as soon as we receive payment.' d='Modules.Wirepayment.Shop'}
      </p>
    {else}
      <div class="alert alert-warning mb-0" role="alert">
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
        d='Modules.Wirepayment.Shop' sprintf=['[1]' => "<a href='{$contact_url}'>", '[/1]' => '</a>']
      }
    </div>
  {/if}
</div>
