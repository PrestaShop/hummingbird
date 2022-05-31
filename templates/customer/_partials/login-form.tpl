{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='login_form'}

  {block name='login_form_errors'}
    {include file='_partials/form-errors.tpl' errors=$errors['']}
  {/block}

  <form id="login-form" class="form-validation" action="{block name='login_form_actionurl'}{$action}{/block}" method="post" novalidate>

    {block name='login_form_fields'}
      {foreach from=$formFields item="field"}
        {block name='form_field'}
          {form_field field=$field}
        {/block}
      {/foreach}
    {/block}

    {block name='login_form_footer'}
      <input type="hidden" name="submitLogin" value="1">
      {block name='form_buttons'}
        <div class="d-grid mb-2">
          <button id="submit-login" class="btn btn-primary" data-link-action="sign-in" type="submit" class="form-control-submit">
            {l s='Sign in' d='Shop.Theme.Actions'}
          </button>
        </div>
      {/block}
    {/block}

    <div class="login__forgot-password text-end mb-4">
      <a href="{$urls.pages.password}" rel="nofollow">
        {l s='Forgot your password?' d='Shop.Theme.Customeraccount'}
      </a>
    </div>

  </form>
{/block}
