{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="card card-body bg-light mb-3 order-confirmation__payment">
  <h2 class="h4">{l s='Payment information' d='Shop.Theme.Checkout'}</h2>
	{if $status == 'ok'}
		<p>
			{l s='You have chosen payment by check.' d='Modules.Cashondelivery.Shop'}<br/>
			{l s='Your check must include following details:' d='Modules.Checkpayment.Shop'}
		</p>

    <div class="row mt-2">
      <div class="col-md-6 fw-bold mb-2 mb-md-0">
				{l s='Payment amount.' d='Modules.Checkpayment.Shop'}
      </div>
      <div class="col-md-6">
				{$total_to_pay}
      </div>
    </div>
    <hr/>
    <div class="row">
      <div class="col-md-6 fw-bold mb-2 mb-md-0">
				{l s='Payable to the order of' d='Modules.Checkpayment.Shop'}
      </div>
      <div class="col-md-6">
				{if $checkName}{$checkName}{else}___________{/if}
      </div>
    </div>
    <hr/>
    <div class="row mb-4">
      <div class="col-md-6 fw-bold mb-2 mb-md-0">
				{l s='Mail to' d='Modules.Checkpayment.Shop'}
      </div>
      <div class="col-md-6">
				{if $checkAddress}{$checkAddress nofilter}{else}___________{/if}
      </div>
    </div>


		<p>
			{if !isset($reference)}
				{l s='Do not forget to insert your order number #%d.' sprintf=[$id_order] d='Modules.Checkpayment.Shop'}<br/>
			{else}
				{l s='Do not forget to insert your order reference %s.' sprintf=[$reference] d='Modules.Checkpayment.Shop'}<br/>
			{/if}
			{l s='An email has been sent to you with this information.' d='Modules.Checkpayment.Shop'}<br/>
			{l s='Your order will be sent as soon as we receive your payment.' d='Modules.Checkpayment.Shop'}
		</p>

		<p class="mb-0">
			{l s='For any questions or for further information, please contact our' d='Modules.Checkpayment.Shop'}
			<a href="{$link->getPageLink('contact', true)|escape:'html'}">{l s='customer service department.' d='Modules.Checkpayment.Shop'}</a>.
		</p>
	{else}
		<p class="warning mb-0">
			{l s='We have noticed that there is a problem with your order. If you think this is an error, you can contact our' d='Modules.Checkpayment.Shop'}
			<a href="{$link->getPageLink('contact', true)|escape:'html'}">{l s='customer service department.' d='Modules.Checkpayment.Shop'}</a>.
		</p>
	{/if}
</div>
