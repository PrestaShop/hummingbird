{* PrestaShop license placeholder *}

{* GENERATE LINKS FOR SUBMENU CHILDREN
{function name="generateLinks" links=[] class="menu-item" parent=null}
  {foreach from=$links item=link}
    <div class="{$class} {if $link.children|count}has-child{/if}">
      <a
        class="{$class}__link"
        href="{$link.url}"
        data-depth="{$link.depth}"
        {if $link.open_in_new_window}target="_blank"{/if}
      >
        {$link.label}
      </a>

      {if $link.children|count}
        {generateLinks links=$link.children class=$class parent=$link}
      {/if}
    </div>
  {/foreach}
{/function} *}

{* RECURSIVE DESKTOP SUBMENU FUNCTION *}
{function name="desktopSubMenu" nodes=[] parent=null depth=1}
  {if $nodes|count}
    {if $depth === 1}
      {* First level submenu container *}
      <div
        class="submenu submenu__level-container level-{$depth} d-none"
        id="submenu-{$parent.page_identifier}"
        data-depth="{$depth}"
        aria-hidden="true"
        aria-labelledby="submenu-trigger-{$parent.page_identifier}"
        role="group"
      >
        <div class="container">
          <ul
            class="submenu__level level-{$depth} submenu__row"
            data-depth="{$depth}"
            role="menu"
          >
            {foreach from=$nodes item=node}
              <li
                class="submenu__item-wrapper{if $node.children|count} has-child{/if}"
                data-depth="{$depth}"
                role="none"
              >
                <div class="submenu__link-wrapper">
                  <a
                    class="submenu__link {if $node.children|count} has-child{/if}"
                    id="submenu-trigger-{$node.page_identifier}"
                    href="{$node.url}"
                    data-depth="{$depth}"
                    {if $node.open_in_new_window}target="_blank"{/if}
                    role="menuitem"
                    {if $node.current}aria-current="page"{/if}
                  >
                    {$node.label}
                  </a>

                  {if $node.children|count}
                    <button
                      class="btn btn-link ps-mainmenu__toggle-dropdown"
                      id="submenu-button-{$node.page_identifier}"
                      type="button"
                      aria-label="{l s='Display submenu %label%' sprintf=['%label%' => $node.label] d='Shop.Theme.Global'}"
                      aria-haspopup="menu"
                      aria-expanded="false"
                      aria-controls="submenu-{$node.page_identifier}"
                    >
                      <span class="material-icons ps-mainmenu_dropdown ps-mainmenu_dropdown-down">&#xE5CF;</span>
                    </button>
                  {/if}
                </div>
              </li>

              {if $node.children|count}
                <div
                  class="submenu__level-container level-{$depth + 1} d-none"
                  id="submenu-{$node.page_identifier}"
                  data-depth="{$depth + 1}"
                  aria-hidden="true"
                  aria-labelledby="submenu-button-{$node.page_identifier}"
                  role="group"
                >
                  {desktopSubMenu nodes=$node.children parent=$node depth=$depth+1}
                </div>
              {/if}
            {/foreach}
          </ul>
        </div>
      </div>
    {else}
      {* Nested submenus *}
      <ul
        class="nested-submenu submenu__level level-{$depth} d-none"
        data-depth="{$depth}"
        aria-hidden="true"
        role="menu"
        aria-labelledby="submenu-button-{$parent.page_identifier}"
      >
        {foreach from=$nodes item=node}
          <li
            class="submenu__item-wrapper{if $node.children|count} has-child{/if}"
            data-depth="{$depth}"
            role="none"
          >
            <div class="submenu__link-wrapper">
              <a
                class="submenu__link {if $node.children|count} has-child{/if}"
                id="submenu-trigger-{$node.page_identifier}"
                href="{$node.url}"
                data-depth="{$depth}"
                {if $node.open_in_new_window}target="_blank"{/if}
                role="menuitem"
                {if $node.current}aria-current="page"{/if}
              >
                {$node.label}
              </a>

              {if $node.children|count}
                <button
                  class="btn btn-link ps-mainmenu__toggle-dropdown"
                  id="submenu-button-{$node.page_identifier}"
                  type="button"
                  aria-label="{l s='Display submenu %label%' sprintf=['%label%' => $node.label] d='Shop.Theme.Global'}"
                  aria-haspopup="menu"
                  aria-expanded="false"
                  aria-controls="submenu-{$node.page_identifier}"
                >
                  <span class="material-icons ps-mainmenu_dropdown ps-mainmenu_dropdown-down">&#xE5CF;</span>
                </button>
              {/if}
            </div>
          </li>

          {if $node.children|count}
            <div
              class="nested-submenu__container submenu__level-container level-{$depth + 1} d-none"
              id="submenu-{$node.page_identifier}"
              data-depth="{$depth + 1}"
              aria-hidden="true"
              role="group"
              aria-labelledby="submenu-button-{$node.page_identifier}"
            >
              {desktopSubMenu nodes=$node.children parent=$node depth=$depth + 1}
            </div>
          {/if}
        {/foreach}
      </ul>
    {/if}
  {/if}
{/function}

{* GENERATE DESKTOP FIRST LEVEL *}
{function name="desktopFirstLevel" itemsFirstLevel=[]}
  {if $itemsFirstLevel|count}
    <ul
      class="ps-mainmenu__tree"
      id="top-menu"
      data-depth="0"
      role="menubar"
    >
      {foreach from=$itemsFirstLevel item=menuItem}
        <li
          class="ps-mainmenu__tree__item type-{$menuItem.type} {if $menuItem.current} current{/if}"
          data-id="{$menuItem.page_identifier}"
          data-depth="0"
          role="none"
        >
          <a
            class="ps-mainmenu__tree__link"
            id="submenu-trigger-{$menuItem.page_identifier}"
            href="{$menuItem.url}"
            data-depth="0"
            {if $menuItem.open_in_new_window}target="_blank"{/if}
            role="menuitem"
            {if $menuItem.current}aria-current="page"{/if}
          >
            {$menuItem.label}
          </a>

          {if $menuItem.children|count}
            <button
              class="btn btn-link ps-mainmenu__toggle-dropdown"
              id="submenu-button-{$menuItem.page_identifier}"
              type="button"
              aria-label="{l s='Display submenu %label%' sprintf=['%label%' => $menuItem.label] d='Shop.Theme.Global'}"
              aria-haspopup="menu"
              aria-expanded="false"
              aria-controls="submenu-{$menuItem.page_identifier}"
            >
              <span class="material-icons ps-mainmenu_dropdown ps-mainmenu_dropdown-down">&#xE5CF;</span>
            </button>
          {/if}
        </li>

        {if $menuItem.children|count}
          {desktopSubMenu nodes=$menuItem.children parent=$menuItem depth=1}
        {/if}
      {/foreach}
    </ul>
  {/if}
{/function}

{* DESKTOP MENU ENTRY *}
{function name="desktopMenu" nodes=[]}
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
        parent=$child backTitle=$child.parent.label
        expandId=$child.expandId
      }
    {/foreach}
  {/if}
{/function}

<nav class="ps-mainmenu ps-mainmenu--desktop col-xl col-auto" aria-label="{l s='Main menu' d='Shop.Theme.Global'}">
  <div class="ps-mainmenu__desktop d-none d-xl-block position-static js-menu-desktop">
    {desktopMenu nodes=$menu.children}
  </div>

  {* MOBILE MENU *}
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

