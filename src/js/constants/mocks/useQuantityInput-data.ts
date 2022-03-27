/**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 */

export const delay = 25;
export const ProductId = 1;

export const ProductLineTemplate = `
  <div class="product-line">
    <div id="js-product-line-alert--${ProductId}"></div>
    <div class="product-line__informations">
      <div class="row">
        <div class="quantity-button js-quantity-button">
          <div class="input-group">
            <button class="btn js-decrement-button" type="button">
              <i class="material-icons"></i>
              <i class="material-icons confirmation d-none"></i>
              <div class="spinner-border d-none"></div>
            </button>
            <input
              data-update-url="#"
              data-product-id="${ProductId}"
              value="1"
              min="1"
              type="text"
            >
            <button class="btn js-increment-button" type="button">
              <i class="material-icons"></i>
              <i class="material-icons confirmation d-none"></i>
              <div class="spinner-border d-none"></div>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
`;

export const ProductTemplate = `
  <div class="modal-dialog">
    <div class="product__add-to-cart js-product-add-to-cart">
      <div class="row">
        <div class="product-actions__quantity quantity-button js-quantity-button">
          <div class="input-group">
            <button class="btn js-decrement-button" type="button">
              <i class="material-icons"></i>
              <i class="material-icons confirmation d-none"></i>
              <div class="spinner-border d-none"></div>
            </button>
            <input
              id="quantity_wanted"
              value="1"
              min="1"
              type="text"
            >
            <button class="btn js-increment-button" type="button">
              <i class="material-icons"></i>
              <i class="material-icons confirmation d-none"></i>
              <div class="spinner-border d-none"></div>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
`;
