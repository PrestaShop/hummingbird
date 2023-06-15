{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='my_account_links'}
  <a href="{$urls.pages.my_account}" class="account-link" data-role="back-to-your-account">
    <i class="material-icons" aria-hidden="true">&#xE5CB;</i>
    <span>{l s='Back to your account' d='Shop.Theme.Customeraccount'}</span>
  </a>
  <a href="{$urls.pages.index}" class="account-link" data-role="home">
    <i class="material-icons" aria-hidden="true">&#xE88A;</i>
    <span>{l s='Home' d='Shop.Theme.Global'}</span>
  </a>
{/block}
