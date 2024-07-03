{assign var=searchEngineTitle value=$as_search.title}
{if empty($searchEngineTitle)}
  {assign var=searchEngineTitle value={l s='Filters' mod='pm_advancedsearch4'}}
{/if}
{if preg_match('/.*(left|right)column$/i', $hookName)}

<div id="PM_ASBlockOutput_{$as_search.id_search|intval}"
     class="PM_ASBlockOutput PM_ASBlockOutputVertical{if $as_mobileVisible|default:false} PM_ASMobileVisible{/if}"{if empty($as_search.criterions)} style="display:none"{/if}
     data-id-search="{$as_search.id_search|intval}">

  <div id="PM_ASBlock_{$as_search.id_search|intval}" class="card">
    {if $searchEngineTitle}
      <div class="card-header">
				<span class="PM_ASBlockTitle">{$searchEngineTitle}{if $as_search.display_nb_result_on_blc}
            <small
              class="PM_ASBlockNbProductValue">({$as_search.total_products|intval} {if $as_search.total_products > 1}{l s='products' mod='pm_advancedsearch4'}{else}{l s='product' mod='pm_advancedsearch4'}{/if})</small>
          {/if}</span>
      </div>
    {/if}
    <div class="card-block">
      {else}
      <div id="PM_ASBlockOutput_{$as_search.id_search|intval}"
           class="h-100 PM_ASBlockOutput PM_ASBlockOutputHorizontal{if $as_mobileVisible|default:false} PM_ASMobileVisible{/if} {$as_search.css_classes}"{if empty($as_search.criterions)} style="display:none"{/if}
           data-id-search="{$as_search.id_search|intval}">
        <div id="PM_ASBlock_{$as_search.id_search|intval}" class="card bg-dark p-4 rounded-0 h-100 justify-content-center">
          <div class="card-header{if empty($as_search.title)} hidden-sm-up{/if} text-start p-0">
            <h2 class="PM_ASearchTitle text-white my-2">
              {if $as_search.id_search != "2"}
                {$searchEngineTitle}
              {/if}
              {if $as_search.display_nb_result_on_blc}
                <small class="PM_ASBlockNbProductValue">
                ({$as_search.total_products|intval} {if $as_search.total_products > 1}{l s='products' mod='pm_advancedsearch4'}{else}{l s='product' mod='pm_advancedsearch4'}{/if})
                </small>{/if}</h2>
          </div>
          <div class="card-block">
            {/if}
