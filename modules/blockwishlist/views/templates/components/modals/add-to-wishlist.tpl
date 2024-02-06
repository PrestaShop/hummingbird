{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div
 class="wishlist-add-to"
 data-url="{$url}"
>
  <div
    class="wishlist-modal modal fade"
    :class="{ldelim}show: !isHidden{rdelim}"
    tabindex="-1"
    role="dialog"
    aria-modal="true"
  >
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header px-3">
          <p class="h5 modal-title">{l s='Add to wishlist' d='Modules.Blockwishlist.Shop'}</p>
          <button
            type="button"
            class="btn-close"
            @click="toggleModal"
            data-dismiss="modal"
            aria-label="{l s='Close' d='Modules.Blockwishlist.Shop'}"
          ></button>
        </div>

        <div class="modal-body">
          <choose-list
            @hide="toggleModal"
            :product-id="productId"
            :product-attribute-id="productAttributeId"
            :quantity="quantity"
            url="{$url}"
            add-url="{$addUrl}"
            empty-text="{l s='No list found.' d='Modules.Blockwishlist.Shop'}"
          ></choose-list>
        </div>

        <div class="modal-footer">
          <div role="button" @click="openNewWishlistModal" class="wishlist-add-to-new text-primary">
            <i class="material-icons text-primary" aria-hidden="true">add_circle_outline</i> {$newWishlistCTA}
          </div>
        </div>
      </div>
    </div>
  </div>

  <div
    class="modal-backdrop fade"
    :class="{ldelim}show: !isHidden{rdelim}"
  ></div>
</div>
