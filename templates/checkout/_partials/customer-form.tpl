{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends "customer/_partials/customer-form.tpl"}

{block "form_field"}
  {if $field.name === 'password' and $guest_allowed}
    <div class="mb-3">
      <div class="form-check">
        <input class="js-password-form__check form-check-input" id="password-form__check" type="checkbox" name="password-form__check">
        <label class="form-check-label" for="password-form__check">
          <span class="fw-bold">{l s='Create an account' d='Shop.Theme.Checkout'}</span> <small class="fw-normal">{l s='(optional)' d='Shop.Theme.Checkout'}</small>
          <br />
          <span class="text-muted fst-italic">{l s='And save time on your next order!' d='Shop.Theme.Checkout'}</span>
        </label>
      </div>
      <div class="js-password-form__input-wrapper d-none mt-3">
        {$smarty.block.parent}
      </div>
    </div>
  {else}
    {$smarty.block.parent}
  {/if}
{/block}

{block "form_buttons"}
    <button
      class="continue btn btn-primary"
      name="continue"
      data-link-action="register-new-customer"
      type="submit"
      value="1"
   >
        {l s='Continue' d='Shop.Theme.Actions'}
    </button>
{/block}
