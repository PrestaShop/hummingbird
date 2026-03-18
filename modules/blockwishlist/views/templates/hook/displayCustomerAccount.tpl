{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

<a
  class="account-menu__link {if $urls.current_url === $url} account-menu__link--active{/if}"
  id="wishlist_link"
  href="{$url}"
  {if $urls.current_url === $url}aria-current="page"{/if}
>
  <i class="account-menu__icon material-icons" aria-hidden="true">&#xE87D;</i>
  {$wishlistsTitlePage}
</a>
