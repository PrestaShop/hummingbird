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

{if $homeslider.slides}
  <div id="homeSlider" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-indicators">
      {assign var="count" value=0}
      {foreach from=$homeslider.slides item=slide name='homeslider'}
        <button type="button" data-bs-target="#homeSlider" data-bs-slide-to="{$count}" aria-label="{$slide.title}"{if $smarty.foreach.homeslider.first} class="active" aria-current="true"{/if}></button>
        {$count = $count + 1}
      {/foreach}
    </div>
    <div class="carousel-inner">
      {foreach from=$homeslider.slides item=slide name='homeslider'}
        <li class="carousel-item{if $smarty.foreach.homeslider.first} active{/if}" role="option" aria-hidden="{if $smarty.foreach.homeslider.first}false{else}true{/if}">
          <a class="carousel-link" href="{$slide.url}">
            <figure class="carousel-content">
              <img src="{$slide.image_url}" alt="{$slide.legend|escape}" loading="lazy" height="340" style="width:100%; object-fit:cover;">
              {if $slide.title || $slide.description}
                <figcaption class="carousel-caption caption">
                  <h2 class="display-1 text-uppercase">{$slide.title}</h2>
                  <div class="caption-description">{$slide.description nofilter}</div>
                </figcaption>
              {/if}
            </figure>
          </a>
        </li>
      {/foreach}
    </div>

    <button class="carousel-control-prev" type="button" data-bs-target="#homeSlider" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#homeSlider" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>
{/if}
