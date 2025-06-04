{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License version 3.0
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License version 3.0
 *}
{if isset($blocks) && !empty($blocks)}
  <div class="blockreassurance blockreassurance--white">
    <div class="blockreassurance--horizontal container">
      {foreach from=$blocks item=$block key=$key}
        {if $block['type_link'] !== $LINK_TYPE_NONE && !empty($block['link'])}
          <a class="reassurance reassurance--link" href="{$block['link']|escape:'htmlall':'UTF-8'}">
        {else}
          <div class="reassurance">
        {/if}

          <span class="reassurance__image">
            {if $block['custom_icon']}
              <img {if $block['is_svg']}class="svg img-fluid invisible" {/if}src="{$block['custom_icon']}">
            {elseif $block['icon']}
              <img class="svg img-fluid invisible" src="{$block['icon']}">
            {/if}
          </span>

          <span class="reassurance__content">
            <span class="reassurance__title">{$block['title']|escape:'htmlall':'UTF-8'}</span>
            {if !empty($block['description'])}
              <br/>
              <small class="reassurance__desc">{$block['description'] nofilter}</small>
            {/if}
          </span>

        {if !empty($block['link']) && $block['type_link'] !== $LINK_TYPE_NONE}
          </a>
        {else}
          </div>
        {/if}
      {/foreach}
    </div>
  </div>
{/if}