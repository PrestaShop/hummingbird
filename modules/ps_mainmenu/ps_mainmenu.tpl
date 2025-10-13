{* PrestaShop license placeholder *}
{function name="generateLinks" links=[] class="menu-item" parent=null}
{* GENERATE LINKS *}
  {if $parent.depth === 1}
    {foreach from=$links item=link}
      {if $link.depth === 3 && $link.children|count}
        <ul class="{$class}__group--child">
      {elseif $link.depth === 3 && !$link.children|count}
        <ul class="{$class}__group--nochild">
      {/if}
      <li>
        <a
          class="{$class} {if $link.depth === 3}{$class}__group-main-item{/if}"
          href="{$link.url}"
          data-depth="{$link.depth}"
          {if $link.open_in_new_window}target="_blank"{/if}
        >
          {$link.label}
        </a>
      </li>
      
      {call name=generateLinks links=$link.children parent=$parent}

      {if ($link.depth === 3 && $link.children|count) || ($link.depth === 3 && !$link.children|count)}
        </ul>
      {/if}
    {/foreach}
  {/if}
{/function}

{* GENERATE SUBMENU *}
{function name="desktopSubMenu" nodes=[] depth=0 parent=null}
  {if $nodes|count}
    {if $depth === 1}
      <div class="js-sub-menu submenu" role="menu" aria-label="{l s='%s submenu' sprintf=[$parent.label] d='Shop.Theme.Menu'}" id="submenu-{$parent.page_identifier}" data-ps-ref="desktop-submenu">
        <div class="container">
          <div class="submenu__row row gx-5">
    {/if}

    {if $depth === 1 }
      <div class="submenu__left col-sm-3" role="tablist" aria-label="{l s='%s submenu tabs' sprintf=[$parent.label] d='Shop.Theme.Menu'}" data-ps-ref="desktop-submenu-left">
        {foreach from=$nodes item=node}
          <a
            class="submenu__left-item"
            href="{$node.url}"
            data-depth="{$node.depth}"
            aria-selected="{if $smarty.foreach.node.first}true{else}false{/if}"
            tabindex="{if $smarty.foreach.node.first}0{else}-1{/if}"
            data-ps-ref="desktop-submenu-left-item"
            data-ps-has-child="{if $node.children|count}true{else}false{/if}"
            {if $node.children|count}
            role="tab"
            id="tab_{$node.label|lower|classname}_{$node.depth}_{$node.page_identifier}"
            data-open-tab="submenu_{$node.label|lower|classname}_{$node.depth}_{$node.page_identifier}"
            aria-controls="submenu_{$node.label|lower|classname}_{$node.depth}_{$node.page_identifier}"
            {/if}
            {if $node.open_in_new_window}target="_blank" rel="noopener noreferrer"{/if}
          >
            {$node.label}
          </a>
        {/foreach}
      </div>
    {/if}

    {if $depth === 1 }
      <div class="submenu__right col-sm-9" data-ps-ref="desktop-submenu-right">
        {foreach from=$nodes item=node}
          <div 
            class="submenu__right-items" 
            role="tabpanel"
            aria-hidden="{if $smarty.foreach.node.first}false{else}true{/if}"
            data-ps-ref="desktop-submenu-right-items"
            {if $node.children|count}
              id="submenu_{$node.label|lower|classname}_{$node.depth}_{$node.page_identifier}"
              aria-labelledby="tab_{$node.label|lower|classname}_{$node.depth}_{$node.page_identifier}"
            {/if}
          >
            {generateLinks links=$node.children parent=$parent}
          </div>
        {/foreach}
      </div>
    {/if}

    {foreach from=$nodes item=node}
      {if $node.children|count}
        {desktopSubMenu nodes=$node.children depth=$node.depth parent=$node}
      {/if}
    {/foreach}

    {if $depth === 1}
          </div>
        </div>
      </div>
    {/if}
  {/if}
{/function}

{* GENERATE DESKTOP FIRST LEVEL *}
{function name="desktopFirstLevel" itemsFirstLevel=[]}
  {if $itemsFirstLevel|count}
    <ul class="ps-mainmenu__tree" id="top-menu" data-ps-ref="desktop-menu-tree">
      {foreach from=$itemsFirstLevel item=menuItem}
        <li class="ps-mainmenu__tree-item type-{$menuItem.type} {if $menuItem.current} current{/if}" data-id="{$menuItem.page_identifier}" data-ps-ref="desktop-menu-item">
          <div class="ps-mainmenu__tree-item-wrapper">
            <a
              class="ps-mainmenu__tree-link"
              href="{$menuItem.url}"
              data-depth="1"
              data-ps-ref="desktop-menu-link"
              {if $menuItem.current}aria-current="page"{/if}
              {if $menuItem.open_in_new_window}target="_blank" rel="noopener noreferrer"{/if}
            >
              {$menuItem.label}
            </a>
            {if $menuItem.children|count}
              <button
                class="ps-mainmenu__tree-dropdown-toggle dropdown-toggle"
                type="button"
                aria-haspopup="menu"
                aria-expanded="false"
                aria-controls="submenu-{$menuItem.page_identifier}"
                aria-label="{l s='Open %s submenu' sprintf=[$menuItem.label] d='Shop.Theme.Menu'}"
                data-ps-ref="desktop-menu-dropdown-toggle"
              ></button>
            {/if}
          </div>

          {desktopSubMenu nodes=$menuItem.children depth=$menuItem.depth parent=$menuItem}
        </li>
      {/foreach}
    </ul>
  {/if}
{/function}

{* GENERATE DESKTOP MENU *}
{function name="desktopMenu" nodes=[] depth=0 parent=null}
  {desktopFirstLevel itemsFirstLevel=$nodes}
{/function}

{* GENERATE MOBILE MENU *}
{function name="mobileMenu" nodes=[] depth=0 parent=null}
  {$children = []}
  {if $nodes|count}
    <nav
      class="menu menu--mobile{if $depth === 0} menu--current js-menu-current{else} menu--child js-menu-child{/if}"
      {if $depth === 0}id="menu-mobile"{else}data-parent-title="{$parent.label}"{/if}
      {if $depth > 1}data-back-title="{$backTitle}" data-id="{$expandId}"{/if}
      data-depth="{$depth}"
    >
      <ul class="menu__list">
        {if $depth >= 1}
          <li class="menu__title">{$parent.label}</li>
        {/if}
        {foreach from=$nodes item=node}
          <li
            class="type-{$node.type} {if $node.current} current{/if} {if $node.children|count} menu--childrens{/if}"
            id="{$node.page_identifier}"
          >
            <a
              class="{if $depth>= 0}menu__link{/if}"
              href="{$node.url}"
              data-depth="{$depth}"
              {if $node.open_in_new_window}target="_blank"{/if}
            >
            {$node.label}
            </a>
            {if $node.children|count}
              {* Cannot use page identifier as we can have the same page several times *}
              {assign var=_expand_id value=10|mt_rand:100000}
              <button class="menu__toggle-child btn btn-link js-menu-open-child" data-target="{$_expand_id}">
                <i class="material-icons rtl-flip" aria-hidden="true">&#xE5CC;</i>
              </button>
            {/if}
          </li>
          {if $node.children|count}
            {$node.parent = $node}
            {$node.expandId = $_expand_id}
            {$children[] = $node}
          {/if}
        {/foreach}
      </ul>
    </nav>
    {foreach from=$children item=child}
      {mobileMenu
        nodes=$child.children
        depth=$child.children[0].depth
        parent=$child backTitle=$child.parent.label
        expandId=$child.expandId
      }
    {/foreach}
  {/if}
{/function}

<div class="ps-mainmenu ps-mainmenu--desktop col-xl col-auto">
  {* DESKTOP MENU *}
  <nav class="ps-mainmenu__desktop d-none d-xl-block position-static js-menu-desktop" data-ps-ref="desktop-menu-container" aria-label="{l s='Main navigation' d='Shop.Theme.Menu'}">
    {desktopMenu nodes=$menu.children}
  </nav>

  {* MOBILE MENU *}
  <div class="ps-mainmenu__mobile-toggle">
    <button
      class="menu-toggle btn btn-link"
      data-bs-toggle="offcanvas"
      data-bs-target="#mobileMenu"
      aria-controls="mobileMenu"
      aria-label="{l s='Open mobile menu' d='Shop.Theme.Menu'}"
    >
      <span class="material-icons" aria-hidden="true">&#xE5D2;</span>
    </button>
  </div>
</div>

<div
  class="ps-mainmenu ps-mainmenu--mobile offcanvas offcanvas-start js-menu-canvas"
  tabindex="-1"
  id="mobileMenu"
  aria-labelledby="mobileMenuLabel"
>
  <div class="offcanvas-header">
    <div class="ps-mainmenu__back-button">
      <button class="btn btn-link btn-sm d-none js-back-button" type="button" aria-label="{l s='Go back to main menu' d='Shop.Theme.Menu'}">
        <span class="material-icons rtl-flip" aria-hidden="true">&#xE5CB;</span>
        <span class="js-menu-back-title">{l s='All' d='Shop.Theme.Global'}</span>
      </button>
    </div>
    <button type="button" class="btn-close btn text-reset" data-bs-dismiss="offcanvas" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
  </div>

  <div class="ps-mainmenu__mobile">
    {mobileMenu nodes=$menu.children}
  </div>

  <div class="ps-mainmenu__additionnals offcanvas-body d-flex flex-wrap align-items-center gap-3">
    <div class="ps-mainmenu__selects d-flex gap-2 me-auto">
      <div id="_mobile_ps_currencyselector" class="col-auto"></div>
      <div id="_mobile_ps_languageselector" class="col-auto"></div>
    </div>
    <div id="_mobile_ps_contactinfo"></div>
  </div>
</div>
