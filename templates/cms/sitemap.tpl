{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='page.tpl'}

{block name='page_title'}
  {l s='Sitemap' d='Shop.Theme.Global'}
{/block}

{block name='page_content'}
  <div class="row sitemap">
      <div class="col-md-6 col-lg-3">
        <h2 class="h3">{$our_offers}</h2>
        {include file='cms/_partials/sitemap-nested-list.tpl' links=$links.offers}
        <hr class="d-block d-md-none" />
      </div>
      <div class="col-md-6 col-lg-3">
        <h2 class="h3">{$categories}</h2>
        {include file='cms/_partials/sitemap-nested-list.tpl' links=$links.categories}
        <hr class="d-block d-md-none" />
      </div>
      <div class="col-md-6 col-lg-3">
        <h2 class="h3">{$your_account}</h2>
        {include file='cms/_partials/sitemap-nested-list.tpl' links=$links.user_account}
        <hr class="d-block d-md-none" />
      </div>
      <div class="col-md-6 col-lg-3">
        <h2 class="h3">{$pages}</h2>
        {include file='cms/_partials/sitemap-nested-list.tpl' links=$links.pages}
      </div>
  </div>
{/block}
