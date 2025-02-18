{block name='module_products'}
  {block name='module_products_variables'}
    {assign var="need_container" value="true"}
  {/block}

  <section class="{block name='module_products_name'}{/block}">
    <div class="module-products {if isset($need_container) && $need_container}container{/if}">
      {block name='module_products_title'}{/block}
      
      {block name='module_products_list'}
        {if $products}
          <div class="module-products__list">
            {include file='catalog/_partials/productlist.tpl' products=$products}
          </div>
        {/if}
      {/block}
        
      {block name='module_products_footer' hide}
        <div class="module-products__buttons">
          {$smarty.block.child}
        </div>
      {/block}
    </div>
  </section>
{/block}
