{* PrestaShop license placeholder *}

{* ================================================
   FUNCTION: categoryInfos
   Displays infos for a category node
   ================================================= *}
{function name="categoryInfos" node=[] seed=1}
  <div class="ps-mainmenu__category-infos" data-type="{$node.type|default:''}" data-depth="{$node.depth|default:''}">
    <a class="ps-mainmenu__category-infos__link" href="{$node.url}" aria-label="go to {$node.label} page">
      <div class="ps-mainmenu__category-infos__header">
        <img class="ps-mainmenu__category-infos__thumbnail" src="https://picsum.photos/60?random={$seed}" alt="category thumbnail">
        <h4 class="ps-mainmenu__category-infos__title">
          {$node.label}
          <span class="material-icons ps-mainmenu__category-infos__link-icon">&#xe157;</span>
        </h4>
      </div>
    </a>
    <hr>
    <ul class="ps-mainmenu__category-infos__details">
      {foreach from=$node key=key item=value}
        {if is_array($value)}
          {* <li>
            <strong>{$key}</strong> :
            <pre style="max-width: 300px; max-height: 100px; overflow:auto"><code class="text-danger">{$value|var_dump}</code></pre>
          </li> *}
        {else}
        <li>
          <strong>{$key}</strong> :
          {if $value === false}
            false
          {else if $value === true}
            true
          {else}
            {$value}
          {/if}
        </li>
        {/if}
      {/foreach}
    </ul>
  </div>
{/function}


{* =======================================================
   FUNCTION: desktopSubMenu
   Recursive submenu with Bootstrap tabs navigation
   ======================================================= *}
{function name="desktopSubMenu" nodes=[] parent=null depth=1}
  {if $nodes|count}
    <div
      class="submenu level-{$depth} {if $depth === 1}d-none{/if}"
      id="submenu-{$parent.page_identifier}"
      aria-labelledby="submenu-button-{$parent.page_identifier}"
      role="group"
    >

      {* LEFT COLUMN: vertical nav-pills *}
      {if $nodes[0] != $parent}
        <div
          class="nav flex-column nav-pills"
          id="nav-pills-{$parent.page_identifier}-tab"
          role="tablist"
          aria-orientation="vertical"
        >
          {call name=categoryInfos node=$parent seed=$depth}

          {foreach from=$nodes item=node name=tabs}
            <button
              class="nav-link {if $smarty.foreach.tabs.first}active{/if}"
              id="nav-pills-{$node.page_identifier}-tab"
              data-bs-toggle="pill"
              data-bs-target="#nav-pills-{$node.page_identifier}"
              type="button"
              role="tab"
              aria-controls="nav-pills-{$node.page_identifier}"
              aria-selected="{if $smarty.foreach.tabs.first}true{else}false{/if}"
            >
              {$node.label}
              <span class="material-icons">&#xe5cc;</span>
            </button>
          {/foreach}
        </div>
      {/if}

      {* RIGHT COLUMN: tab content for each pill *}
      <div class="tab-content {if $nodes[0] == $parent}parent{/if}" id="nav-pills-{$parent.page_identifier}-content">
        {foreach from=$nodes item=node name=subcontent}
          <div
            class="tab-pane fade{if $smarty.foreach.subcontent.first} show active{/if}"
            id="nav-pills-{$node.page_identifier}"
            role="tabpanel"
            aria-labelledby="nav-pills-{$node.page_identifier}-tab"
            tabindex="0"
          >
            {if $node.children|count}
              {* SUBLEVEL: recursive tabbed submenu *}
              {call name=desktopSubMenu nodes=$node.children parent=$node depth=$depth+1}
            {else}
              {call name=categoryInfos node=$node seed=$depth + $smarty.foreach.subcontent.index + 1}
            {/if}
          </div>
        {/foreach}
      </div>
    </div>
  {/if}
{/function}

{* ===================================================
   FUNCTION: desktopFirstLevel
   First level (top menu bar)
   =================================================== *}
{function name="desktopFirstLevel" itemsFirstLevel=[]}
  {if $itemsFirstLevel|count}
    <ul class="ps-mainmenu__tree" id="top-menu" role="menubar">
      {foreach from=$itemsFirstLevel item=menuItem}
        <li
          class="ps-mainmenu__tree__item type-{$menuItem.type} {if $menuItem.current} current{/if}"
          data-id="{$menuItem.page_identifier}"
          role="none"
        >
          <a
            class="ps-mainmenu__tree__link"
            id="submenu-trigger-{$menuItem.page_identifier}"
            href="{$menuItem.url}"
            role="menuitem"
            {if $menuItem.open_in_new_window}target="_blank"{/if}
            {if $menuItem.current}aria-current="page"{/if}
          >
            {$menuItem.label}
          </a>

          <button
            class="btn btn-link ps-mainmenu__toggle-dropdown"
            id="submenu-button-{$menuItem.page_identifier}"
            type="button"
            aria-label="{l s='Toggle submenu for %label%' sprintf=['%label%' => $menuItem.label] d='Shop.Theme.Global'}"
            aria-haspopup="menu"
            aria-expanded="false"
            aria-controls="submenu-{$menuItem.page_identifier}"
          >
            <span class="material-icons ps-mainmenu_dropdown">&#xE5CF;</span>
          </button>
        </li>
      {/foreach}
    </ul>

    {* Recursive rendering of submenus *}
    <div class="submenu__level-container">
    {foreach from=$itemsFirstLevel item=menuItem}
      {if $menuItem.children|count}
        {desktopSubMenu nodes=$menuItem.children parent=$menuItem depth=1}
      {else}
        {desktopSubMenu nodes=[$menuItem] parent=$menuItem  depth=1}
      {/if}
    {/foreach}
    </div>
  {/if}
{/function}


{* ===================================================
   FUNCTION: desktopMenu
   =================================================== *}
{function name="desktopMenu" nodes=[]}
  {desktopFirstLevel itemsFirstLevel=$nodes}
{/function}


{* ===================================================
   FUNCTION: mobileMenu
   =================================================== *}
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
              {assign var=_expand_id value=10|mt_rand:100000}
              <button class="menu__toggle-child btn btn-link js-menu-open-child" data-target="{$_expand_id}">
                <i class="material-icons rtl-flip">&#xE5CC;</i>
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
        parent=$child
        backTitle=$child.parent.label
        expandId=$child.expandId
      }
    {/foreach}
  {/if}
{/function}


{* ===================================================
   DESKTOP AND MOBILE MENU ENTRY
   =================================================== *}
<nav class="ps-mainmenu ps-mainmenu--desktop col-xl col-auto" aria-label="{l s='Main menu' d='Shop.Theme.Global'}">
  <div class="ps-mainmenu__desktop d-none d-xl-block position-static js-menu-desktop">
    {desktopMenu nodes=$menu.children}
  </div>

  {* Mobile toggle button *}
  <div class="ps-mainmenu__mobile-toggle">
    <a
      class="menu-toggle btn btn-link"
      href="#"
      role="button"
      data-bs-toggle="offcanvas"
      data-bs-target="#mobileMenu"
      aria-controls="mobileMenu"
    >
      <span class="material-icons">&#xE5D2;</span>
    </a>
  </div>
</nav>

<div
  class="ps-mainmenu ps-mainmenu--mobile offcanvas offcanvas-start js-menu-canvas"
  tabindex="-1"
  id="mobileMenu"
  aria-labelledby="mobileMenuLabel"
>
  <div class="offcanvas-header">
    <div class="ps-mainmenu__back-button">
      <button class="btn btn-link btn-sm d-none js-back-button" type="button">
        <span class="material-icons rtl-flip">&#xE5CB;</span>
        <span class="js-menu-back-title">{l s='All' d='Shop.Theme.Global'}</span>
      </button>
    </div>
    <button type="button" class="btn-close btn text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
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
