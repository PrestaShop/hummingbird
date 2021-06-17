{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}

{$componentName = 'ps-imageslider'}

{if $homeslider.slides}
  <div class="{$componentName}">
    <div class="swiper-wrapper">
      {foreach from=$homeslider.slides item=slide name='homeslider'}
        <li class="swiper-slide" role="option" aria-hidden="{if $smarty.foreach.homeslider.first}false{else}true{/if}">
          <a class="{$componentName}-link" href="{$slide.url}">
            <figure class="{$componentName}-content container">
              <img src="{$slide.image_url}" alt="{$slide.legend|escape}" loading="lazy" width="1110" height="340">
              {if $slide.title || $slide.description}
                <figcaption class="{$componentName}-text caption">
                  <h2 class="display-1 text-uppercase">{$slide.title}</h2>
                  <div class="caption-description">{$slide.description nofilter}</div>
                </figcaption>
              {/if}
            </figure>
          </a>
        </li>
      {/foreach}
    </div>
    <div class="{$componentName}-pagination"></div>

    <div class="{$componentName}-button-prev">
      <i class="material-icons">
        keyboard_arrow_left
      </i>
    </div>

    <div class="{$componentName}-button-next">
      <i class="material-icons">
        keyboard_arrow_right
      </i>
    </div>
  </div>
{/if}
