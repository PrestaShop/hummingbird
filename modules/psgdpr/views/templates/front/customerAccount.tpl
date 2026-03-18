{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

<a
  class="account-menu__link {if $urls.current_url === $front_controller} account-menu__link--active{/if}"
  id="psgdpr_link"
  href="{$front_controller}"
  {if $urls.current_url === $front_controller}aria-current="page"{/if}
>
  <i class="account-menu__icon material-icons" aria-hidden="true">&#xE853;</i>
  {l s='GDPR - Personal data' d='Modules.Psgdpr.Shop'}
</a>
