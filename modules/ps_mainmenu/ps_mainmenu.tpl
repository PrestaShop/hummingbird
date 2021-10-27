{assign var=_counter value=0}
{function name="menu" nodes=[] depth=0 parent=null}
    {if $nodes|count}
      <ul class="{if $depth == 0}main-menu__tree{/if}" {if $depth == 0}id="top-menu"{/if} data-depth="{$depth}">
        {foreach from=$nodes item=node}
            <li class="{$node.type}{if $node.current} current {/if}{if $depth == 0} main-menu__tree__item{/if}{if $node.children|count} dropdown{/if}" id="{$node.page_identifier}">
            {assign var=_counter value=$_counter+1}
              <a
                class="{if $depth>= 0}main-menu__tree__link dropdown-item{/if}{if $node.children|count} dropdown-toggle{/if}"
                href="{$node.url}" data-depth="{$depth}"
                {if $node.open_in_new_window} target="_blank" {/if}
             >
                {if $node.children|count}
                  {* Cannot use page identifier as we can have the same page several times *}
                  {assign var=_expand_id value=10|mt_rand:100000}
                  <span class="float-xs-right d-none d-sm-block d-md-none">
                    <span data-target="#top_sub_menu_{$_expand_id}" data-bs-toggle="collapse" class="navbar-toggler collapse-icons">
                      <i class="material-icons add">&#xE313;</i>
                      <i class="material-icons remove">&#xE316;</i>
                    </span>
                  </span>
                {/if}
                {$node.label}
              </a>
              {if $node.children|count}
              <div {if $depth === 0} class="dropdown-menu js-sub-menu"{/if} id="top_sub_menu_{$_expand_id}">
                {if $depth === 0}
                  <div class="container">
                {/if}
                  {menu nodes=$node.children depth=$node.depth parent=$node}
                {if $depth === 0}
                  </div>
                {/if}
              </div>
              {/if}
            </li>
        {/foreach}
      </ul>
    {/if}
{/function}

{function name="mobileMenu" nodes=[] depth=0 parent=null}
    {if $nodes|count}
      <ul class="menu menu--mobile{if $depth == 0} menu--current js-menu-current{else} menu--child js-menu-child{/if}" {if $depth == 0}id="menu-mobile"{/if} data-depth="{$depth}">
        {foreach from=$nodes item=node}
            <li class="{$node.type}{if $node.current} current {/if}{if
            $node.children|count} menu--childrens{/if}" id="{$node.page_identifier}">
            {assign var=_counter value=$_counter+1}
              <a
                class="{if $depth>= 0}menu__link{/if}"
                href="{$node.url}" data-depth="{$depth}"
                {if $node.open_in_new_window} target="_blank" {/if}
             >
                {$node.label}
              </a>

              {if $node.children|count}
                {* Cannot use page identifier as we can have the same page several times *}
                {assign var=_expand_id value=10|mt_rand:100000}
                <span class="js-menu-open-child">
                  <span data-target="#top_sub_menu_{$_expand_id}" class="navbar-toggler collapse-icons">
                    <i class="material-icons">chevron_right</i>
                  </span>
                </span>
              {/if}
              {if $node.children|count}
                {mobileMenu nodes=$node.children depth=$node.depth parent=$node}
              {/if}
            </li>
        {/foreach}
      </ul>
    {/if}
{/function}

<div id="_desktop_menu" class="main-menu main-menu--desktop order-0 order-xl-1">
  <div class="d-none d-xl-block position-static js-menu-desktop">
    {menu nodes=$menu.children}
  </div>

  <button class="main-menu__toggler btn btn-unstyle d-xl-none me-2" type="button" data-bs-toggle="offcanvas" data-bs-target="#mobileMenu" aria-controls="mobileMenu">
    <span class="material-icons">menu</span>  
  </button>
</div>

<div class="main-menu__offcanvas offcanvas offcanvas-start" tabindex="-1" id="mobileMenu" aria-labelledby="mobileMenuLabel">
  <div class="offcanvas-header">
    <button class="btn btn-unstyle d-none js-back-button" type="button">
      <span class="material-icons">chevron_left</span>  
    </button>

    <h5 class="offcanvas-title js-menu-title" id="mobileMenuLabel">Menu</h5>

    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>

  <div class="main-menu__mobile">
    {mobileMenu nodes=$menu.children}
  </div>

  <div class="main-menu__additionnals offcanvas-body">
    <div id="_mobile_currency_selector"></div>
    <div id="_mobile_language_selector"></div>
    <div id="_mobile_contact_link"></div>
  </div>
</div>
