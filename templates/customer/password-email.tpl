{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='page.tpl'}

{block name='container_class'}container container--limited-sm{/block}

{block name='page_title'}
  {l s='Forgot your password?' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <form action="{$urls.pages.password}" class="forgotten-password form-validation" method="post" novalidate>
    {if count($errors)}
      <div class="alert alert-danger" role="alert">
        <ul>
          {foreach $errors as $error}
            <li>{$error}</li>
          {/foreach}
        </ul>
      </div>
    {/if}
    <header>
      <p class="send-renew-password-link">{l s='Please enter the email address you used to register. You will receive a temporary link to reset your password.' d='Shop.Theme.Customeraccount'}</p>
    </header>
    <section class="form-fields">
      <div class="mb-3">
        <label class="form-label required">{l s='Email address' d='Shop.Forms.Labels'}</label>
        <input type="email" name="email" id="email" value="{if isset($smarty.post.email)}{stripslashes($smarty.post.email)}{/if}" class="form-control" autocomplete="email" required>
      </div>
      <button id="send-reset-link" class="form-control-submit btn btn-primary" name="submit" type="submit">
        {l s='Send reset link' d='Shop.Theme.Actions'}
      </button>
    </section>
  </form>
{/block}

{block name='page_footer'}
  <hr>

  <a id="back-to-login" href="{$urls.pages.my_account}" class="btn btn-unstyle btn-with-icon">
    <i class="material-icons rtl-flip" aria-hidden="true">&#xE5CB;</i>
    <span>{l s='Back to login' d='Shop.Theme.Actions'}</span>
  </a>
{/block}
