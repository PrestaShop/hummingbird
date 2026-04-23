{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{extends file='page.tpl'}

{block name='container_class'}container container--limited-sm{/block}

{block name='page_title'}
  {l s='Forgot your password?' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  {if count($successes)}
    <div class="alert alert-success" role="alert" tabindex="0">
      <ul class="mb-0">
        {foreach $successes as $success}
          <li>{$success}</li>
        {/foreach}
      </ul>
    </div>
  {/if}
{/block}

{block name='page_footer'}
  <hr>

  <div class="buttons-wrapper">
    {assign var="back_to_login_url" value=$urls.pages.authentication}
    {if isset($smarty.get.back) && $smarty.get.back !== ''}
      {if $back_to_login_url|strpos:'?' !== false}
        {assign var="back_to_login_url" value="`$back_to_login_url`&back=`$smarty.get.back|escape:'url'`"}
      {else}
        {assign var="back_to_login_url" value="`$back_to_login_url`?back=`$smarty.get.back|escape:'url'`"}
      {/if}
    {/if}
    <a id="back-to-login" href="{$back_to_login_url}" class="btn btn-basic">
      <i class="material-icons rtl-flip" aria-hidden="true">&#xE5C4;</i>
      <span>{l s='Back to login' d='Shop.Theme.Actions'}</span>
    </a>
  </div>
{/block}
