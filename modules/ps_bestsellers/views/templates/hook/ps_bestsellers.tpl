{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<section class="best-sellers-products mt-3">
    <div class="container">
        {include file='components/section-title.tpl' title={l s='Best Sellers' d='Shop.Theme.Catalog'}}
        {include file='catalog/_partials/productlist.tpl' products=$products productClass='col-12 col-xs-6 col-lg-4 col-xl-3'}
        <div class="best-sellers-products-footer text-center">
            <a class="all-product-link btn btn-outline-primary" href="{$allBestSellers}">
                {l s='All best sellers' d='Shop.Theme.Catalog'}<i class="material-icons rtl-flip" aria-hidden="true">&#xE315;</i>
            </a>
        </div>
    </div>
</section>
