{* PrestaShop license placeholder *}

{* ================================================
   FUNCTION: categoryInfos
   Displays structured infos for a category node
   ================================================= *}
{function name="categoryInfos" node=[]}
  <div class="ps-mainmenu__category-infos" data-type="{$node.type|default:''}" data-depth="{$node.depth|default:''}">
    <h4 class="ps-mainmenu__category-infos__title">
      {$node.label|default:'(no label)'}
      {if $node.current|default:false}
        <span class="ps-mainmenu__category-infos__current">(active)</span>
      {/if}
    </h4>

    <ul class="ps-mainmenu__category-infos__details">
      {foreach from=$node key=key item=value}
        {if is_array($value)}
          <li>
            <strong>{$key}</strong> :
            {if $value|@count == 0}
              <em>empty</em>
            {elseif $key == 'image_urls'}
              <ul>
                {foreach from=$value item=imageUrl}
                  <li><img src="{$imageUrl}" alt="Image of {$node.label}" width="80" /></li>
                {/foreach}
              </ul>
            {elseif $key == 'children'}
              <ul class="ps-mainmenu__category-infos__children">
                {foreach from=$value item=child}
                  <li>{call name=categoryInfos node=$child}</li>
                {/foreach}
              </ul>
            {else}
              <pre><code>{$value|@json_encode:JSON_PRETTY_PRINT}</code></pre>
            {/if}
          </li>
        {else if $key == 'url'}
          <li><strong>{$key}</strong> : <a href="{$value}">{$value}</a></li>
        {else}
          <li><strong>{$key}</strong> : {$value}</li>
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
      class="submenu submenu__level-container level-{$depth} {if $depth === 1 }d-none{/if}"
      id="submenu-{$parent.page_identifier}"
      aria-labelledby="submenu-button-{$parent.page_identifier}"
      role="group"
    >

      {* LEFT COLUMN: vertical nav-pills *}
      <div
        class="nav flex-column nav-pills"
        id="v-pills-{$parent.page_identifier}-tab"
        role="tablist"
        aria-orientation="vertical"
      >
        {foreach from=$nodes item=node name=tabs}
          <button
            class="nav-link {if $smarty.foreach.tabs.first}active{/if}"
            id="v-pills-{$node.page_identifier}-tab"
            data-bs-toggle="pill"
            data-bs-target="#v-pills-{$node.page_identifier}"
            type="button"
            role="tab"
            aria-controls="v-pills-{$node.page_identifier}"
            aria-selected="{if $smarty.foreach.tabs.first}true{else}false{/if}"
          >
            {$node.label}
          </button>
        {/foreach}
      </div>

      {* RIGHT COLUMN: tab content for each pill *}
      <div class="tab-content" id="v-pills-{$parent.page_identifier}-content">
        {foreach from=$nodes item=node name=subcontent}
          <div
            class="tab-pane{if $smarty.foreach.subcontent.first} show active{/if}"
            id="v-pills-{$node.page_identifier}"
            role="tabpanel"
            aria-labelledby="v-pills-{$node.page_identifier}-tab"
            tabindex="0"
          >

            {if $node.children|count}

              {* SUBLEVEL: recursive tabbed submenu *}
              <div
                class="nav flex-column nav-pills"
                id="v-pills-{$node.page_identifier}-sub-tab"
                role="tablist"
                aria-orientation="vertical"
              >
                {foreach from=$node.children item=subnode name=subtabs}
                  <button
                    class="nav-link {if $smarty.foreach.subtabs.first}active{/if}"
                    id="v-pills-{$subnode.page_identifier}-tab"
                    data-bs-toggle="pill"
                    data-bs-target="#v-pills-{$subnode.page_identifier}"
                    type="button"
                    role="tab"
                    aria-controls="v-pills-{$subnode.page_identifier}"
                    aria-selected="{if $smarty.foreach.subtabs.first}true{else}false{/if}"
                  >
                    {$subnode.label}
                  </button>
                {/foreach}
              </div>

              <div class="tab-content" id="v-pills-{$node.page_identifier}-sub-content">
                {foreach from=$node.children item=subnode name=subcontent2}
                  <div
                    class="tab-pane {if $smarty.foreach.subcontent2.first}show active{/if}"
                    id="v-pills-{$subnode.page_identifier}"
                    role="tabpanel"
                    aria-labelledby="v-pills-{$subnode.page_identifier}-tab"
                  >
                    {if $subnode.children|count}
                      {desktopSubMenu nodes=$subnode.children parent=$subnode depth=$depth+1}
                    {else}
                      {call name=categoryInfos node=$subnode}
                    {/if}
                  </div>
                {/foreach}
              </div>

            {else}
              {call name=categoryInfos node=$node}
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
   - Link stays a real <a>
   - Button is the submenu toggle
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
          {* Link keeps its native behavior *}
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

          {* Button explicitly controls submenu open/close *}
          {if $menuItem.children|count}
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
          {/if}
        </li>
      {/foreach}
    </ul>

    {* Recursive rendering of submenus *}
    {foreach from=$itemsFirstLevel item=menuItem}
      {if $menuItem.children|count}
        {desktopSubMenu nodes=$menuItem.children parent=$menuItem depth=1}
      {/if}
    {/foreach}
  {/if}
{/function}


{* ===================================================
   FUNCTION: desktopMenu (entry point)
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
