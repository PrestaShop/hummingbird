{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
<div
  class="wishlist-delete"
  data-delete-list-url="{$deleteListUrl}"
  data-delete-product-url="{$deleteProductUrl}"
>
  <div class="wishlist-modal modal fade" tabindex="-1" role="dialog" aria-modal="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <form class="modal-content">
        <div class="modal-header px-3">
          <p class="h5 modal-title">
            <span class="js-wishlist-delete-product">{l s='Remove product from wishlist' d='Modules.Blockwishlist.Shop'}</span>
            <span class="js-wishlist-delete-list">{l s='Delete wishlist' d='Modules.Blockwishlist.Shop'}</span>
          </p>
          <button type="button" class="btn-close" data-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
        </div>
        <div class="modal-body js-wishlist-delete-product">
          {* %nameofthewishlist% is replaced by the name of the list *}
          <p class="modal-text">{l s='The product will be removed from "%nameofthewishlist%".' d='Modules.Blockwishlist.Shop'}</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="modal-cancel btn btn-secondary" data-dismiss="modal">
            {l s='Cancel' d='Modules.Blockwishlist.Shop'}
          </button>
          <button type="submit" class="btn btn-primary">
            <span class="js-wishlist-delete-product">{l s='Remove' d='Modules.Blockwishlist.Shop'}</span>
            <span class="js-wishlist-delete-list">{l s='Delete' d='Modules.Blockwishlist.Shop'}</span>
          </button>
        </div>
      </form>
    </div>
  </div>

  <div class="modal-backdrop fade"></div>
</div>
