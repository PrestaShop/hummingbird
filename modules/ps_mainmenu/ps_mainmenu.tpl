{function name="desktopMenu" nodes=[] depth=0 parent=null}
  {if $nodes|count}
    <ul
      {if $depth === 0}id="top-menu"{/if}
      class="{if $depth === 0}main-menu__tree h-100{elseif $depth === 1}row row-cols-4 gy-3{else}submenu{/if}"
      data-depth="{$depth}"
    >
    {foreach from=$nodes item=node}
      <li
        class="{$node.type}{if $node.current} current{/if}{if $depth === 0} js-menu-item-lvl-0 main-menu__tree__item d-flex align-items-center h-100{/if}"
        id="{$node.page_identifier}"
      >
        {if $depth > 1 && $node.children|count}
          <div class="dropdown dropend">
        {/if}
          <a
            class="main-menu__tree__link{if $node.children|count} dropdown-toggle{/if}{if $depth > 0} dropdown-item{/if}"
            href="{$node.url}"
            data-depth="{$depth}"
            {if $node.open_in_new_window}target="_blank"{/if}
            {if $depth > 1 && $node.children|count}
              data-bs-toggle="dropdown"
              {if $depth === 2}data-bs-offset="0,-1"{else}data-bs-display="static"{/if}
            {/if}
          >
            {$node.label}
          </a>
          {if $node.children|count}
            {if $depth !== 1}
              <div class="{if $depth === 0}menu-container shadow-sm js-sub-menu{/if}{if $depth > 1 && $node.children|count}dropdown-menu{/if}">
            {/if}
              {if $depth === 0}
                <div class="container">
              {/if}
                {desktopMenu nodes=$node.children depth=$node.depth parent=$node}
              {if $depth === 0}
                </div>
              {/if}
            {if $depth !== 1}
              </div>
            {/if}
          {/if}
        {if $depth > 1 && $node.children|count}
          </div>
        {/if}
      </li>
    {/foreach}
    </ul>
  {/if}
{/function}

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
          <li class="main-menu__title h5">{$parent.label}</li>
        {/if}
        {foreach from=$nodes item=node}
          <li
            class="{$node.type}{if $node.current} current{/if}{if $node.children|count} menu--childrens{/if}"
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
              <span class="main-menu__toggle-child js-menu-open-child" data-target="{$_expand_id}">
                <span data-target="#top_sub_menu_{$_expand_id}">
                  <i class="material-icons rtl-flip">chevron_right</i>
                </span>
              </span>
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

<div class="main-menu col-xl col-auto d-flex align-items-center">
  <div class="d-none d-xl-block position-static js-menu-desktop">
    {desktopMenu nodes=$menu.children}
  </div>

  <div class="header-block d-xl-none">
    <a
      class="header-block__action-btn"
      href="#"
      role="button"
      data-bs-toggle="offcanvas"
      data-bs-target="#mobileMenu"
      aria-controls="mobileMenu"
    >
      <span class="material-icons header-block__icon">menu</span>
    </a>
  </div>
</div>

<div
  class="main-menu__offcanvas offcanvas offcanvas-start js-menu-canvas"
  tabindex="-1"
  id="mobileMenu"
  aria-labelledby="mobileMenuLabel"
>
  <div class="offcanvas-header">
    <div class="main-menu__back-button">
      <button class="btn btn-unstyle d-none js-back-button" type="button">
        <span class="material-icons rtl-flip">chevron_left</span>
        <span class="js-menu-back-title">{l s='All' d='Shop.Theme.Global'}</span>
      </button>
    </div>
    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>

  <div class="main-menu__mobile">
    {mobileMenu nodes=$menu.children}
  </div>

  <div class="main-menu__additionnals offcanvas-body">
    <div class="main-menu__selects row">
      <div id="_mobile_currency_selector" class="col-auto"></div>
      <div id="_mobile_language_selector" class="col-auto"></div>
    </div>
    <div id="_mobile_contact_link"></div>
  </div>
</div>
