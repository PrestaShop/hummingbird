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

{assign
  var=iconsMap
  value=[
    "cart" => "shopping_cart"
  ]
  scope="global"
}


{** SVG SPRITE **}

<svg class="d-none">
  <defs>
    <g id="shopping_cart">
      <path
        d="M280-80q-33 0-56.5-23.5T200-160q0-33 23.5-56.5T280-240q33 0 56.5 23.5T360-160q0 33-23.5 56.5T280-80Zm400 0q-33 0-56.5-23.5T600-160q0-33 23.5-56.5T680-240q33 0 56.5 23.5T760-160q0 33-23.5 56.5T680-80ZM208-800h590q23 0 35 20.5t1 41.5L692-482q-11 20-29.5 31T622-440H324l-44 80h480v80H280q-45 0-68-39.5t-2-78.5l54-98-144-304H40v-80h130l38 80Z"/>
    </g>
  </defs>
</svg>


{**
 * @param string iconName
 * @param array extraAttributes
 * @return string
 * @example
 * {renderIcon name='cart' extraAttributes=['class' => 'my-extra-class']}
 *}
{function renderThemeIcon iconName="" extraAttributes=[]}
    {if $iconName && !empty($iconsMap[$iconName])}

      <span
        class="material-icons {if !empty($extraAttributes['class'])}{$extraAttributes['class']}{/if}"
        {foreach $extraAttributes as $key => $value}
          {if $key != 'class'}
            {$key}="{$value}"
          {/if}
        {/foreach}
      >
        {$iconsMap[$iconName]}
      </span>
    {/if}
{/function}

{assign
  var=iconsMapSvg
  value=[
    "cart" => [
      "name" => "shopping_cart",
      "viewbox" => "0 -960 960 960"
    ]
  ]
  scope="global"
}


{** DIFFERENT NAME ONLY FOR POC TO DISPLAY POSIBILITES **}
{function renderThemeIconSvg iconName="" extraAttributes=[]}
  {if $iconName && !empty($iconsMapSvg[$iconName])}
    {$icon = $iconsMapSvg[$iconName]}

    <svg
      class="svg-icon {if !empty($extraAttributes['class'])}{$extraAttributes['class']}{/if}"
      {foreach $extraAttributes as $key => $value}
        {if $key != 'class'}
          {$key}="{$value}"
        {/if}
      {/foreach}
      {if !empty($icon.viewbox)}
        viewBox="{$icon.viewbox}"
      {/if}
    >
      <use xlink:href="#{$icon.name}"></use>
    </svg>
  {/if}
{/function}

{assign
  var=externalSvgFileUrl
  value="`$urls.theme_assets`resources/icons-sprite.svg"
  scope="global"
}

{*
  External svg file can be preloaded just like fonts
  but be aware if you are using cdn you won't be able to use it
  due to security reasons
  You should find better way to build this url forexample inside module
*}

<link rel="preload" as="image" href="{$externalSvgFileUrl}" />

{assign
  var=iconsMapSvgExternal
  value=[
    "cart" => [
      "name" => "shopping_cart",
      "viewbox" => "0 -960 960 960"
    ]
  ]
  scope="global"
}

{** DIFFERENT NAME ONLY FOR POC TO DISPLAY POSIBILITES **}
{function renderThemeIconSvgExternal iconName="" extraAttributes=[]}
  {if $iconName && !empty($iconsMapSvgExternal[$iconName])}
    {$icon = $iconsMapSvgExternal[$iconName]}

    <svg
      class="svg-icon {if !empty($extraAttributes['class'])}{$extraAttributes['class']}{/if}"
      {foreach $extraAttributes as $key => $value}
          {if $key != 'class' && $value}
              {$key}="{$value}"
          {/if}
      {/foreach}
      {if !empty($icon.viewbox)}
        viewBox="{$icon.viewbox}"
      {/if}
    >
      <use xlink:href="{$externalSvgFileUrl}#{$icon.name}"></use>
    </svg>
  {/if}
{/function}

