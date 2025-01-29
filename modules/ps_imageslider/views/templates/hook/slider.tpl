{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{if $homeslider.slides}
  <div id="home-slider" class="ratio ratio-homeSlider">
    <div class="carousel slide" data-bs-ride="carousel">
      <div class="carousel-indicators">
        {assign var="count" value=0}
        {foreach from=$homeslider.slides item=slide name='homeslider'}
          <button type="button" data-bs-target="#home-slider .carousel" data-bs-slide-to="{$count}" aria-label="{$slide.title}"
          {if $smarty.foreach.homeslider.first} class="active" aria-current="true" {/if}></button>
          {$count = $count + 1}
        {/foreach}
      </div>
      <div class="carousel-inner" role="listbox" aria-label="{l s='Carousel container' d='Shop.Theme.Global'}">
        {foreach from=$homeslider.slides item=slide name='homeslider'}
          <li class="carousel-item{if $smarty.foreach.homeslider.first} active{/if}" role="option"
            aria-hidden="{if $smarty.foreach.homeslider.first}false{else}true{/if}">
            {if !empty($slide.url)}<a class="carousel-link" href="{$slide.url}">{/if}
              <figure class="carousel-content">
                <img src="{$slide.image_url}" alt="{$slide.legend|escape}" {if $slide@iteration == 1}loading="eager"{else}loading="lazy"{/if} {$slide.size|replace: '"':''}>
                {if $slide.title || $slide.description}
                  <figcaption class="carousel-caption caption">
                    <h2 class="display-1 text-uppercase">{$slide.title}</h2>
                    <div class="caption-description">{$slide.description nofilter}</div>
                  </figcaption>
                {/if}
              </figure>
            {if !empty($slide.url)}</a>{/if}
          </li>
        {/foreach}
      </div>

      <button class="carousel-control-prev" type="button" data-bs-target="#home-slider .carousel" data-bs-slide="prev" aria-label="{l s='Previous' d='Shop.Theme.Actions'}">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      </button>

      <button class="carousel-control-next" type="button" data-bs-target="#home-slider .carousel" data-bs-slide="next" aria-label="{l s='Next' d='Shop.Theme.Actions'}">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
      </button>
    </div>
  </div>
{/if}
