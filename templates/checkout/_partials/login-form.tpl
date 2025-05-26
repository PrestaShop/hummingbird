{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='customer/_partials/login-form.tpl'}

{block name='form_buttons'}
  <button
    class="btn btn-primary"
    name="continue"
    data-link-action="sign-in"
    type="submit"
    value="1"
  >
    {l s='Continue' d='Shop.Theme.Actions'}
    <i class="material-icons rtl-flip" aria-hidden="true">&#xE5C8;</i>
  </button>
{/block}
