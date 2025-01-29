{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='page.tpl'}

{block name='container_class'}container container--limited-sm{/block}

{block name='page_title'}
  {l s='Reset your password' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <form action="{$urls.pages.password}" method="post" class="form-validation" novalidate>
    {if count($errors)}
      <div class="alert alert-danger" role="alert">
        <ul>
          {foreach $errors as $error}
            <li>{$error}</li>
          {/foreach}
        </ul>
      </div>
    {/if}

    <section class="form-fields renew-password">
      <div class="mb-3">
        {l
          s='Email address: %email%'
          d='Shop.Theme.Customeraccount'
          sprintf=['%email%' => stripslashes($customer_email)]
        }
      </div>
      <div class="mb-3">
        <label class="form-label">{l s='New password' d='Shop.Forms.Labels'}</label>
        <div class="input-group password-field js-parent-focus">
          <input class="form-control js-child-focus js-visible-password" type="password" data-validate="isPasswd" name="passwd" value="" autocomplete="new-password">
          <button
            class="btn btn-primary"
            type="button"
            data-action="show-password"
            data-text-show="{l s='Show Password' d='Shop.Theme.Actions'}"
            data-text-hide="{l s='Hide Password' d='Shop.Theme.Actions'}"
            aria-label="{l s='Show Password' d='Shop.Theme.Actions'}"
            aria-expanded="false"
          >
            <i class="material-icons">visibility</i>
          </button>
        </div>
      </div>
      <div class="mb-3">
        <label class="form-label">{l s='Confirmation' d='Shop.Forms.Labels'}</label>
        <div class="input-group password-field js-parent-focus">
        <input class="form-control js-child-focus js-visible-password" type="password" data-validate="isPasswd" name="confirmation" value="" autocomplete="new-password">
          <button
            class="btn btn-primary"
            type="button"
            data-action="show-password"
            data-text-show="{l s='Show Password' d='Shop.Theme.Actions'}"
            data-text-hide="{l s='Hide Password' d='Shop.Theme.Actions'}"
            aria-label="{l s='Show Password' d='Shop.Theme.Actions'}"
            aria-expanded="false"
          >
            <i class="material-icons">visibility</i>
          </button>
        </div>
      </div>

      <input type="hidden" name="token" id="token" value="{$customer_token}">
      <input type="hidden" name="id_customer" id="id_customer" value="{$id_customer}">
      <input type="hidden" name="reset_token" id="reset_token" value="{$reset_token}">

      <button class="btn btn-primary" type="submit" name="submit">
        {l s='Change Password' d='Shop.Theme.Actions'}
      </button>
    </section>
  </form>
{/block}

{block name='page_footer'}
  <hr>

  <a id="back-to-login" href="{$urls.pages.authentication}" class="btn btn-unstyle btn-with-icon">
    <i class="material-icons rtl-flip" aria-hidden="true">&#xE5CB;</i>
    <span>{l s='Back to login' d='Shop.Theme.Actions'}</span>
  </a>
{/block}
