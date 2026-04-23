{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{block name='login_form'}
  {block name='login_form_errors'}
    {include file='_partials/form-errors.tpl' errors=$errors['']}
  {/block}

  <form id="login-form" action="{block name='login_form_actionurl'}{$action}{/block}" method="post" data-ps-action="form-validation">
    {block name='login_form_fields'}
      {foreach from=$formFields item="field"}
        {block name='form_field'}
          {form_field field=$field}
        {/block}
      {/foreach}
    {/block}

    {block name='login_form_footer'}
      <input type="hidden" name="submitLogin" value="1" tabindex="-1">
      {if isset($smarty.get.back) && $smarty.get.back !== ''}
        <input type="hidden" name="back" value="{$smarty.get.back|escape:'htmlall':'UTF-8'}">
      {/if}

      <div class="buttons-wrapper buttons-wrapper--split buttons-wrapper--invert-mobile">
        {assign var="password_url" value=$urls.pages.password}
        {if isset($smarty.get.back) && $smarty.get.back !== ''}
          {if $password_url|strpos:'?' !== false}
            {assign var="password_url" value="`$password_url`&back=`$smarty.get.back|escape:'url'`"}
          {else}
            {assign var="password_url" value="`$password_url`?back=`$smarty.get.back|escape:'url'`"}
          {/if}
        {/if}
        <a class="btn btn-basic" href="{$password_url}" rel="nofollow">
          {l s='Forgot your password?' d='Shop.Theme.Customeraccount'}
        </a>

        {block name='form_buttons'}
          <button id="submit-login" class="btn btn-primary" data-link-action="sign-in" type="submit" data-ps-action="form-validation-submit">
            {l s='Sign in' d='Shop.Theme.Actions'}
          </button>
        {/block}
      </div>
    {/block}
  </form>
{/block}
