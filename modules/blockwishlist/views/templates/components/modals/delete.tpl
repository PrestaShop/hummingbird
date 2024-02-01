{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div
  class="wishlist-delete"
  {if isset($listUrl)}
    data-delete-list-url="{$listUrl}"
  {/if}
  {if isset($deleteProductUrl)}
    data-delete-product-url="{$deleteProductUrl}"
  {/if}
  data-title="{l s='Remove product from wishlist' d='Modules.Blockwishlist.Shop'}"
  data-title-list="{l s='Delete wishlist' d='Modules.Blockwishlist.Shop'}"
  data-placeholder='{l s='The product will be removed from "%nameofthewishlist%".' d='Modules.Blockwishlist.Shop'}'
  data-cancel-text="{l s='Cancel' d='Modules.Blockwishlist.Shop'}"
  data-delete-text="{l s='Remove' d='Modules.Blockwishlist.Shop'}"
  data-delete-text-list="{l s='Delete' d='Modules.Blockwishlist.Shop'}"
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
          <p class="h5 modal-title">((modalTitle))</p>
          <button
            type="button"
            class="btn-close"
            @click="toggleModal"
            data-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>
        <div class="modal-body" v-if="productId">
          <p class="modal-text">((confirmMessage))</p>
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="modal-cancel btn btn-secondary"
            data-dismiss="modal"
            @click="toggleModal"
          >((cancelText))</button>

          <button
            type="button"
            class="btn btn-primary"
            @click="deleteWishlist"
          >((modalDeleteText))</button>
        </div>
      </div>
    </div>
  </div>

  <div
    class="modal-backdrop fade"
    :class="{ldelim}show: !isHidden{rdelim}"
  ></div>
</div>
