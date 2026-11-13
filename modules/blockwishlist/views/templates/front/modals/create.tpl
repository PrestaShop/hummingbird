{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
<div
  class="wishlist-create"
  data-url="{$createUrl}"
  data-length-text="{l s='List title is too short' d='Modules.Blockwishlist.Shop'}"
>
  <div class="wishlist-modal modal fade" tabindex="-1" role="dialog" aria-modal="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <form class="modal-content">
        <div class="modal-header px-3">
          <p class="h5 modal-title">{l s='Create wishlist' d='Modules.Blockwishlist.Shop'}</p>
          <button type="button" class="btn-close" data-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
        </div>
        <div class="modal-body">
          <div class="form-group form-group-lg">
            <label class="form-label" for="input2">{l s='Wishlist name' d='Modules.Blockwishlist.Shop'}</label>
            <input
              type="text"
              class="form-control form-control-lg"
              id="input2"
              name="name"
              placeholder="{l s='Add name' d='Modules.Blockwishlist.Shop'}"
            />
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="modal-cancel btn btn-secondary" data-dismiss="modal">
            {l s='Cancel' d='Modules.Blockwishlist.Shop'}
          </button>
          <button type="submit" class="btn btn-primary">
            {l s='Create wishlist' d='Modules.Blockwishlist.Shop'}
          </button>
        </div>
      </form>
    </div>
  </div>

  <div class="modal-backdrop fade"></div>
</div>
