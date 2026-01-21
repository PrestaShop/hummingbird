{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='My alerts' d='Modules.Emailalerts.Shop'}
{/block}

{block name='page_content'}
  <p>{l s='Manage your mail alerts to stay informed about product availability and updates.' d='Modules.Emailalerts.Shop'}</p>

  {if $mailAlerts}
    <ul class="ps-emailalerts__product-list" data-ps-ref="emailalerts-product-list">
      {foreach from=$mailAlerts item=mailAlert}
        {include 'module:ps_emailalerts/views/templates/front/mailalerts-account-line.tpl' mailAlert=$mailAlert}
      {/foreach}
    </ul>

    <div class="alert alert-info d-none" role="alert" data-ps-ref="emailalerts-account-no-alerts">{l s='You do not have any mail alerts.' d='Modules.Emailalerts.Shop'}</div>
  {else}
    <div class="alert alert-info" role="alert" data-ps-ref="emailalerts-account-no-alerts">{l s='You do not have any mail alerts.' d='Modules.Emailalerts.Shop'}</div>
  {/if}
{/block}
