{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{function renderLogo}
  <a class="navbar-brand d-block" href="{$urls.pages.index}">
    <img
      class="logo img-fluid"
      src="{$shop.logo_details.src}"
      alt="{$shop.name}"
      width="{$shop.logo_details.width}"
      height="{$shop.logo_details.height}"
    >
  </a>
{/function}

{function renderIcon iconGroup="material-icons" iconName="" ariaHidden="true" ariaLabel="" extraAttributes=[]}
  {if isset($iconsMap) && !empty($iconsMap[$iconGroup]) && $iconName && !empty($iconsMap[$iconGroup][$iconName])}
    <i
      class="{$iconGroup}{if !empty($extraAttributes['class'])} {$extraAttributes['class']}{/if}"
      aria-hidden="{$ariaHidden}"
      {if !$ariaHidden && !empty($ariaLabel)}
        aria-label="{$ariaLabel}"
      {/if}
      {foreach $extraAttributes as $key => $value}
        {if $key != 'class'}
          {$key}="{$value}"
        {/if}
      {/foreach}
    >
      {$iconsMap[$iconGroup][$iconName]}
    </i>
  {/if}
{/function}
