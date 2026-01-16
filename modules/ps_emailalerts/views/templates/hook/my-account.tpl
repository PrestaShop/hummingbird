{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<a
  class="account-menu__link{if $urls.current_url === $link->getModuleLink(ps_emailalerts, 'account')} account-menu__link--active{/if}"
  id="emailalerts_link"
  href="{$link->getModuleLink(ps_emailalerts, 'account')}"
  {if $urls.current_url === $link->getModuleLink(ps_emailalerts, 'account')}aria-current="page"{/if}
>
  <i class="account-menu__icon material-icons" aria-hidden="true">&#xE151;</i>
  {l s='My alerts' d='Shop.Theme.Catalog'}
</a>
