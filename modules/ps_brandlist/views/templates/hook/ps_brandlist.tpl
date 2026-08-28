{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

<section class="ps-brandlist left-block">
  <p class="left-block__title h3">
    {if $display_link_brand}
      <a href="{$page_link}">
        {l s='Brands' d='Shop.Theme.Catalog'}
      </a>
    {else}
      {l s='Brands' d='Shop.Theme.Catalog'}
    {/if}
  </p>

  {if $brands}
    {include file="module:ps_brandlist/views/templates/_partials/$brand_display_type.tpl" brands=$brands}
  {else}
    <p class="mb-0">{l s='No brand' d='Shop.Theme.Catalog'}</p>
  {/if}
</section>
