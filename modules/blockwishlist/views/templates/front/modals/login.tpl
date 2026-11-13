{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
<div
  class="wishlist-login"
>
  <div class="wishlist-modal modal fade" tabindex="-1" role="dialog" aria-modal="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header px-3">
          <p class="h5 modal-title">{l s='Sign in' d='Modules.Blockwishlist.Shop'}</p>
          <button type="button" class="btn-close" data-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
        </div>
        <div class="modal-body">
          <p class="modal-text">{l s='You need to be logged in to save products in your wishlist.' d='Modules.Blockwishlist.Shop'}</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="modal-cancel btn btn-secondary" data-dismiss="modal">
            {l s='Cancel' d='Modules.Blockwishlist.Shop'}
          </button>
          <a class="btn btn-primary" href="{$urls.pages.authentication}">
            {l s='Sign in' d='Modules.Blockwishlist.Shop'}
          </a>
        </div>
      </div>
    </div>
  </div>

  <div class="modal-backdrop fade"></div>
</div>
