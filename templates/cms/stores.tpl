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
{extends file='page.tpl'}

{block name='page_title'}
  {l s='Our stores' d='Shop.Theme.Global'}
{/block}

{block name='page_content'}
  <div class="row">
    {foreach $stores as $store}
      <article id="store-{$store.id}" class="store col-md-6 col-lg-4 col-xl-6">
        <div class="card">
          <div class="card-body">
            <div class="row">
              <div class="col-xl-6 store__picture">
                <img
                  src="{$store.image.bySize.stores_default.url}"
                  width="{$store.image.bySize.stores_default.width}"
                  height="{$store.image.bySize.stores_default.height}"
                  class="img-fluid"
                  {if !empty($store.image.legend)}
                    alt="{$store.image.legend}"
                    title="{$store.image.legend}"
                  {else}
                    alt="{$store.name}"
                  {/if}
              >
              </div>
              <div class="col-xl-6 store__description d-none d-md-block">
                <h2 class="h6 store__name">{$store.name}</h2>
                <address class="store__address">{$store.address.formatted nofilter}</address>
                {if $store.note || $store.phone || $store.fax || $store.email}
                  <a data-bs-toggle="collapse" href="#about-{$store.id}" aria-expanded="false" aria-controls="about-{$store.id}"><strong>{l s='About and Contact' d='Shop.Theme.Global'}</strong><i class="material-icons">&#xE409;</i></a>
                {/if}
                <hr>
                <table class="store__opening-times">
                  {foreach $store.business_hours as $day}
                  <tr>
                    <th>{$day.day|truncate:4:'.'}</th>
                    <td>
                      <ul>
                      {foreach $day.hours as $h}
                        <li>{$h}</li>
                      {/foreach}
                      </ul>
                    </td>
                  </tr>
                  {/foreach}
                </table>
              </div>
              <div class="store__description accordion d-block d-md-none">
                <div class="accordion-item">
                  <h2 class="h6 store__name">{$store.name}</h2>
                  <address class="store__address">{$store.address.formatted nofilter}</address>
                  {if $store.note || $store.phone || $store.fax || $store.email}
                    <a data-bs-toggle="collapse" href="#about-{$store.id}" aria-expanded="false" aria-controls="about-{$store.id}"><strong>{l s='About and Contact' d='Shop.Theme.Global'}</strong><i class="material-icons">&#xE409;</i></a>
                  {/if}
                  <hr>
                  <button class="store__toggle accordion-button collapsed pb-2 px-0" data-bs-toggle="collapse" data-bs-target="#table-{$store.id}">{l s='View schedules' d='Shop.Theme.Global'}</button>
                  <table id="table-{$store.id}" class="store__opening-times accordion-collapse collapse">
                    {foreach $store.business_hours as $day}
                    <tr>
                      <th>{$day.day|truncate:4:'.'}</th>
                      <td>
                        <ul>
                        {foreach $day.hours as $h}
                          <li>{$h}</li>
                        {/foreach}
                        </ul>
                      </td>
                    </tr>
                    {/foreach}
                  </table>
                </div>
              </div>
            </div>
          </div>
          {if $store.note || $store.phone || $store.fax || $store.email}
            <div class="card-footer store__footer collapse" id="about-{$store.id}">
              {if $store.note}
                  <p class="store__note">{$store.note}</p>
              {/if}
              <ul class="store__contacts">
                {if $store.phone}
                  <li><i class="material-icons">&#xE0B0;</i>{$store.phone}</li>
                {/if}
                {if $store.fax}
                  <li><i class="material-icons">&#xE8AD;</i>{$store.fax}</li>
                {/if}
                {if $store.email}
                  <li><i class="material-icons">&#xE0BE;</i>{$store.email}</li>
                {/if}
              </ul>
            </div>
          {/if}
        </div>
      </article>
    {/foreach}
  </div>
{/block}
