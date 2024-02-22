{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div
  class="wishlist-share"
  data-url="{$url}"
  data-title="{l s='Share wishlist' d='Modules.Blockwishlist.Shop'}"
  data-copied-text="{l s='Copied!' d='Modules.Blockwishlist.Shop'}"
  data-label="{l s='Share link' d='Modules.Blockwishlist.Shop'}"
  data-cancel-text="{l s='Cancel' d='Modules.Blockwishlist.Shop'}"
  data-copy-text="{l s='Copy text' d='Modules.Blockwishlist.Shop'}"
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
          <p class="h5 modal-title">((title))</p>
          <button
            type="button"
            class="btn-close"
            @click="toggleModal"
            data-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>
        <div class="modal-body">
          <div class="form-group form-group-lg">
            <label class="form-label" for="input2">((label))</label>
            <input
              type="text"
              class="form-control form-control-lg"
              v-model="value"
              id="input2"
              placeholder="Share link"
            >
          </div>
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
            @click="copyLink"
          >(( actionText ))</button>
        </div>
      </div>
    </div>
  </div>

  <div
    class="modal-backdrop fade"
    :class="{ldelim}show: !isHidden{rdelim}"
  ></div>
</div>
