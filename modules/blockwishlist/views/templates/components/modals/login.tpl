{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div
  class="wishlist-login"
  data-login-text="{l s='Sign in' d='Modules.Blockwishlist.Shop'}"
  data-cancel-text="{l s='Cancel' d='Modules.Blockwishlist.Shop'}"
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
          <p class="h5 modal-title">{l s='Sign in' d='Modules.Blockwishlist.Shop'}</p>
          <button
            type="button"
            class="btn-close"
            @click="toggleModal"
            data-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>
        <div class="modal-body">
          <p class="modal-text">{l s='You need to be logged in to save products in your wishlist.' d='Modules.Blockwishlist.Shop'}</p>
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="modal-cancel btn btn-secondary"
            data-dismiss="modal"
            @click="toggleModal"
          >((cancelText))</button>

          <a
            class="btn btn-primary"
            :href="prestashop.urls.pages.authentication"
          >((loginText))</a>
        </div>
      </div>
    </div>
  </div>

  <div
    class="modal-backdrop fade"
    :class="{ldelim}show: !isHidden{rdelim}"
  ></div>
</div>
