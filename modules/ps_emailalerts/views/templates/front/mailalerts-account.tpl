{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='My alerts' d='Modules.Emailalerts.Shop'}
{/block}

{block name='page_content'}
  {if $mailAlerts}
    <ul class="row">
      {foreach from=$mailAlerts item=mailAlert}
        <li class="col-sm-6 col-md-3">{include 'module:ps_emailalerts/views/templates/front/mailalerts-account-line.tpl' mailAlert=$mailAlert}</li>
      {/foreach}
    </ul>
  {else}
    <div class="alert alert-info" role="alert" data-alert="info">{l s='No mail alerts yet.' d='Modules.Emailalerts.Shop'}</div>
  {/if}
{/block}
