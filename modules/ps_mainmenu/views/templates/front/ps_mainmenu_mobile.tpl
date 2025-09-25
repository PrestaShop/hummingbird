{* Mobile menu offcanvas template *}

<div
  class="offcanvas offcanvas-start js-menu-mobile"
  tabindex="-1"
  id="mobileMenu"
  aria-labelledby="mobileMenuLabel"
>
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="mobileMenuLabel">
      {l s='Menu' d='Shop.Theme.Global'}
    </h5>
    <button
      type="button"
      class="btn-close"
      data-bs-dismiss="offcanvas"
      aria-label="{l s='Close' d='Shop.Theme.Global'}"
    ></button>
  </div>

  <div class="offcanvas-body">
    {if $nodes|count}
      <ul class="list-unstyled mb-0" id="mobile-top-menu" data-depth="0">
        {foreach from=$nodes item=node}
          <li class="mb-2 type-{$node.type}{if $node.current} active{/if}" data-id="{$node.page_identifier}">
            <a
              href="{$node.url}"
              class="d-block py-2 px-1 fw-bold"
              {if $node.open_in_new_window}target="_blank"{/if}
            >
              {$node.label}
            </a>

            {if $node.children|count}
              <ul class="list-unstyled ms-3" data-depth="1">
                {foreach from=$node.children item=subnode}
                  <li class="mb-1 type-{$subnode.type}{if $subnode.current} active{/if}">
                    <a
                      href="{$subnode.url}"
                      class="d-block py-1 px-1"
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
  </div>
</div>
