{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div id="_desktop_ps_currencyselector">
  <div class="ps-currencyselector">
    <select class="form-select js-currency-selector" aria-label="{l s='Change currency' d='Shop.Theme.Global'}">
      {foreach from=$currencies item=currency}
        <option value="{$currency.url}"{if $currency.current} selected="selected"{/if}>{$currency.iso_code}{if $currency.sign !== $currency.iso_code} {$currency.sign}{/if}</option>
      {/foreach}
    </select>
  </div>
</div>
