{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
<div
  class="wishlist-add-to"
  data-url="{$url}"
  data-add-url="{$addUrl}"
>
  <div class="wishlist-modal modal fade" tabindex="-1" role="dialog" aria-modal="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header px-3">
          <p class="h5 modal-title">{$wishlistsTitlePage}</p>
          <button type="button" class="btn-close" data-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
        </div>

        <div class="modal-body">
          <div class="wishlist-chooselist">
            <ul class="wishlist-list"></ul>

            <div class="wishlist-list-loader" hidden>
              <span></span>
              <span></span>
              <span></span>
              <span></span>
            </div>

            <p class="wishlist-list-empty" hidden>
              {l s='No list found.' d='Modules.Blockwishlist.Shop'}
            </p>

            <template class="js-wishlist-list-item-template">
              <li class="wishlist-list-item">
                <p class="js-wishlist-list-item-name"></p>
              </li>
            </template>
          </div>
        </div>

        <div class="modal-footer">
          <div role="button" tabindex="0" class="wishlist-add-to-new text-primary">
            <i class="material-icons text-primary" aria-hidden="true">add_circle_outline</i> {$newWishlistCTA}
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="modal-backdrop fade"></div>
</div>
