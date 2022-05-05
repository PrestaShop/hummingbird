{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div id="_desktop_language_selector">
  <div class="language-selector__wrapper">
    <select id="language-selector" aria-label="{l s='Language' d='Shop.Theme.Global'}" class="form-select js-language-selector">
      {foreach from=$languages item=language}
        <option value="{url entity='language' id=$language.id_lang}"{if $language.id_lang == $current_language.id_lang} selected="selected"{/if} data-iso-code="{$language.iso_code}">{$language.name_simple}</option>
      {/foreach}
    </select>
  </div>
</div>
