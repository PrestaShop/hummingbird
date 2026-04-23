{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{extends file='page.tpl'}

{block name='container_class'}container container--limited-md{/block}

{block name='page_title'}
  {l s='Create an account' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  {block name='register_form_container'}
    {$hook_create_account_top nofilter}
    <section class="register-form">
      {render file='customer/_partials/customer-form.tpl' ui=$register_form mode='register'}
      <hr>
      {assign var="login_url" value=$urls.pages.authentication}
      {if isset($smarty.get.back) && $smarty.get.back !== ''}
        {if $login_url|strpos:'?' !== false}
          {assign var="login_url" value="`$login_url`&back=`$smarty.get.back|escape:'url'`"}
        {else}
          {assign var="login_url" value="`$login_url`?back=`$smarty.get.back|escape:'url'`"}
        {/if}
      {/if}
      <p class="register-form__login-prompt">{l s='Already have an account?' d='Shop.Theme.Customeraccount'} <a href="{$login_url}">{l s='Sign in' d='Shop.Theme.Customeraccount'}</a></p>
    </section>
  {/block}
{/block}
