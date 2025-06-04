{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
 {block name='account_transformation_form'}
  <h3>{l s='Save time on your next order, sign up now' d='Shop.Theme.Checkout'}</h3>

  <div class="rich-text">
    <ul>
      <li>{l s='Personalized and secure access' d='Shop.Theme.Customeraccount'}</li>
      <li>{l s='Fast and easy checkout' d='Shop.Theme.Customeraccount'}</li>
      <li>{l s='Easier merchandise return' d='Shop.Theme.Customeraccount'}</li>
    </ul>
  </div>

  <form method="post">
    <input type="hidden" name="submitTransformGuestToCustomer" value="1">

    <div class="mb-3">
      <label class="form-label" for="field-email">
        {l s='Set your password:' d='Shop.Forms.Labels'}
      </label>

      <input type="password" class="form-control" data-validate="isPasswd" required name="password" value="" autocomplete="new-password">
    </div>

    <div class="buttons-wrapper buttons-wrapper--end">
      <button class="btn btn-primary" type="submit">{l s='Create account' d='Shop.Theme.Actions'}</button>
    </div>
  </form>
{/block}
