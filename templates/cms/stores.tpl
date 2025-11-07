{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{extends file='page.tpl'}

{block name='page_title'}
  {l s='Our stores' d='Shop.Theme.Global'}
{/block}

{block name='page_content_container'}
  <section id="content" class="page-content page-content--stores">
    {block name='page_content'}
      <div class="store__list">
        {foreach $stores as $store}
          <article id="store-{$store.id}" class="store">
            <div class="store__image">
              <picture>
                {if isset($store.image.bySize.stores_default.sources.avif)}
                  <source 
                    srcset="{$store.image.bySize.stores_default.sources.avif}"
                    type="image/avif"
                  >
                {/if}

                {if isset($store.image.bySize.stores_default.sources.webp)}
                  <source 
                    srcset="{$store.image.bySize.stores_default.sources.webp}"
                    type="image/webp"
                  >
                {/if}

                <img
                  class="store__img img-fluid"
                  srcset="{$store.image.bySize.stores_default.url}"
                  loading="lazy"
                  width="{$store.image.bySize.stores_default.width}"
                  height="{$store.image.bySize.stores_default.height}"
                  {if !empty($store.image.legend)}
                    alt="{$store.image.legend}"
                    title="{$store.image.legend}"
                  {else}
                    alt="{$store.name}"
                  {/if}
                >
              </picture>
            </div>

            <div class="store__informations">
              <p class="store__name">{$store.name}</p>

              <address class="store__address">
                {$store.address.formatted nofilter}
              </address>

              <div class="accordion accordion--small mt-2">
                {if $store.note || $store.phone || $store.fax || $store.email}
                  <div class="accordion-item">
                    <div class="accordion-header">
                      <a class="store__toggle accordion-button collapsed" data-bs-toggle="collapse" href="#about-{$store.id}" aria-expanded="false" aria-controls="about-{$store.id}">
                        {l s='About and Contact' d='Shop.Theme.Global'}
                      </a>
                    </div>

                    <div class="store__additional-infos accordion-collapse collapse" id="about-{$store.id}">
                      <div class="accordion-body pb-2">
                        {if $store.note}
                          <p class="store__note">{$store.note}</p>
                        {/if}
          
                        <ul class="store__contacts">
                          {if $store.phone}
                            <li class="store__contact">
                              <i class="material-icons" aria-hidden="true">&#xE0B0;</i>{$store.phone}
                            </li>
                          {/if}
          
                          {if $store.fax}
                            <li class="store__contact">
                              <i class="material-icons" aria-hidden="true">&#xE8AD;</i>{$store.fax}
                            </li>
                          {/if}
          
                          {if $store.email}
                            <li class="store__contact store__contact--email">
                              <i class="material-icons" aria-hidden="true">&#xE0BE;</i>{$store.email}
                            </li>
                          {/if}
                        </ul>
                      </div>
                    </div>
                  </div>
                {/if}

                <div class="accordion-item border-0">
                  <div class="accordion-header">
                    <button class="store__toggle accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#table-{$store.id}" aria-label="{l s='View schedules for %store_name%' sprintf=['%store_name%' => $store.name] d='Shop.Theme.Global'}">
                      {l s='View schedules' d='Shop.Theme.Global'}
                    </button>
                  </div>

                  <div id="table-{$store.id}" class="accordion-collapse collapse">
                    <div class="accordion-body pb-2">
                      <table class="store__opening-times table-sm">
                        {foreach $store.business_hours as $day}
                          <tr>
                            <th>
                              {$day.day}
                            </th>

                            <td>
                              {foreach $day.hours as $hour}
                                {$hour}
                              {/foreach}
                            </td>
                          </tr>
                        {/foreach}
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </article>
        {/foreach}
      </div>
    {/block}
  </section>
{/block}
