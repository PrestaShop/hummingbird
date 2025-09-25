{* PrestaShop license placeholder *}

{* GENERATE DESKTOP FIRST LEVEL *}
{function name="desktopFirstLevel" itemsFirstLevel=[]}
  {if $itemsFirstLevel|count}
    <ul class="navbar-nav me-auto mb-2 mb-lg-0" id="top-menu" data-depth="0">
      {foreach from=$itemsFirstLevel item=menuItem}
        <li class="nav-item {if $menuItem.children|count}dropdown{/if} type-{$menuItem.type}{if $menuItem.current} active{/if}" data-id="{$menuItem.page_identifier}">
          <a
            class="nav-link {if $menuItem.children|count}dropdown-toggle{/if}"
            href="{$menuItem.url}"
            {if $menuItem.children|count}
              id="dropdown-{$menuItem.page_identifier}"
              role="button"
              data-bs-toggle="dropdown"
              aria-expanded="false"
            {/if}
            {if $menuItem.open_in_new_window}target="_blank"{/if}
          >
            {$menuItem.label}
          </a>

          {if $menuItem.children|count}
            <ul class="dropdown-menu" aria-labelledby="dropdown-{$menuItem.page_identifier}">
              {foreach from=$menuItem.children item=subnode}
                <li>
                  <a
                    class="dropdown-item"
                    href="{$subnode.url}"
                    {if $subnode.open_in_new_window}target="_blank"{/if}
                  >
                    {$subnode.label}
                  </a>
                </li>
              {/foreach}
            </ul>
          {/if}
        </li>
      {/foreach}
    </ul>
  {/if}
{/function}

{* GENERATE DESKTOP MENU *}
{function name="desktopMenu" nodes=[] depth=0 parent=null}
  {desktopFirstLevel itemsFirstLevel=$nodes}
{/function}

<nav class="ps-mainmenu navbar navbar-expand-xl">
  <div class="container-fluid">

    {* Mobile toggle (visible only on mobile) *}
    <button
      class="navbar-toggler"
      type="button"
      data-bs-toggle="offcanvas"
      data-bs-target="#mobileMenu"
      aria-controls="mobileMenu"
      aria-label="{l s='Toggle navigation' d='Shop.Theme.Global'}"
    >
      <span class="navbar-toggler-icon"></span>
    </button>

    {* Desktop menu *}
    <div class="collapse navbar-collapse js-menu-desktop">
      {desktopMenu nodes=$menu.children}
    </div>

  </div>
</nav>

{include file="module:ps_mainmenu/views/templates/front/ps_mainmenu_mobile.tpl" nodes=$menu.children}
