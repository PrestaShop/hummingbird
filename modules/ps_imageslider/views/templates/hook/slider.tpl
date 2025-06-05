{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{if $homeslider.slides}
  <section class="ps-imageslider">
    <div id="ps_imageslider" class="carousel slide" data-bs-ride="carousel">
      <div class="carousel-indicators">
        {foreach from=$homeslider.slides item=slide name='homeslider'}
          <button type="button" data-bs-target="#ps_imageslider" data-bs-slide-to="{$slide@index}" aria-label="{$slide.title}"
          {if $slide@first} class="active" aria-current="true" {/if}></button>
        {/foreach}
      </div>

      <div class="carousel-inner" role="list" aria-label="{l s='Carousel container' d='Shop.Theme.Global'}">
        {foreach from=$homeslider.slides item=slide name='homeslider'}
          <div class="carousel-item {if $slide@first} active{/if}" role="listitem">
            {if !empty($slide.url)}<a class="ps-imageslider__link d-block h-100 text-body" href="{$slide.url}">{/if}
              <figure class="ps-imageslider__figure">
                <img class="w-100" src="{$slide.image_url}" alt="{$slide.legend|escape}" {if $slide@first}loading="eager"{else}loading="lazy"{/if} width="{$slide.sizes[0]}" height="{$slide.sizes[1]}">

                {if $slide.title || $slide.description}
                  <figcaption class="ps-imageslider__figcaption carousel-caption d-none d-lg-block fs-5">
                    {if $slide.title}<h2 class="h1 text-uppercase">{$slide.title}</h2>{/if}
                    {if $slide.description}<div>{$slide.description nofilter}</div>{/if}
                  </figcaption>
                {/if}
              </figure>
            {if !empty($slide.url)}</a>{/if}
          </div>
        {/foreach}
      </div>

      <button class="carousel-control-prev" type="button" data-bs-target="#ps_imageslider" data-bs-slide="prev" aria-label="{l s='Previous' d='Shop.Theme.Actions'}">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      </button>

      <button class="carousel-control-next" type="button" data-bs-target="#ps_imageslider" data-bs-slide="next" aria-label="{l s='Next' d='Shop.Theme.Actions'}">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
      </button>
    </div>
  </section>
{/if}
