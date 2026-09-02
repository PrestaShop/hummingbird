/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

export const delay = 5;
export const ProductId = '1';

export const ProductLineTemplate = `
  <div class="product-line">
    <div class="product-line__informations">
      <div class="row">
        <div class="quantity-button js-quantity-button" data-ps-ref="quantity-input">
          <div class="input-group">
            <button class="btn js-decrement-button" data-ps-action="decrement-quantity" type="button">
              <i class="material-icons"></i>
              <i class="material-icons confirmation d-none" data-ps-ref="quantity-confirm-icon"></i>
              <div class="spinner-border d-none"></div>
            </button>
            <input
              data-update-url="#"
              data-product-id="${ProductId}"
              value="1"
              min="1"
              type="text"
            >
            <button class="btn js-increment-button" data-ps-action="increment-quantity" type="button">
              <i class="material-icons"></i>
              <i class="material-icons confirmation d-none" data-ps-ref="quantity-confirm-icon"></i>
              <div class="spinner-border d-none"></div>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
`;

export const ProductTemplate = `
  <div class="modal quickview" data-ps-ref="quickview-modal">
  <div class="quickview__dialog modal-dialog">
    <div class="product__add-to-cart js-product-add-to-cart">
      <div class="row">
        <div class="product-actions__quantity quantity-button js-quantity-button" data-ps-ref="quantity-input">
          <div class="input-group">
            <button class="btn js-decrement-button" data-ps-action="decrement-quantity" type="button">
              <i class="material-icons"></i>
              <i class="material-icons confirmation d-none" data-ps-ref="quantity-confirm-icon"></i>
              <div class="spinner-border d-none"></div>
            </button>
            <input
              id="quantity_wanted"
              value="1"
              min="1"
              type="text"
            >
            <button class="btn js-increment-button" data-ps-action="increment-quantity" type="button">
              <i class="material-icons"></i>
              <i class="material-icons confirmation d-none" data-ps-ref="quantity-confirm-icon"></i>
              <div class="spinner-border d-none"></div>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
  </div>
`;
