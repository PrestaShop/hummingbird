/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

declare namespace Theme {
  namespace QuantitySelector {
    type Context = 'product' | 'quickview' | 'listing' | 'cart';

    interface Bounds {
      min: number;
      max: number | null;
    }

    // Shape of the data-ps-data JSON on a cart line selector
    interface CartData {
      updateUrl: string;
      idProduct: number;
      idProductAttribute: number;
      idCustomization: number;
    }

    interface QuantityChangedDetail {
      root: HTMLElement;
      context: Context;
      value: number;
      previous: number;
    }

    interface CartProduct {
      id_product: string | number;
      id_product_attribute: string | number;
      id_customization: string | number;
      availability: string;
      allow_oosp: number;
      quantity_wanted: string | number;
      stock_quantity: string | number;
      minimal_quantity: string | number;
      cart_quantity: string | number;
      update_quantity_url: string;
    }

    // Reason of the core updateCart event after an add to cart
    interface AddToCartReason {
      idProduct?: number | string;
      idProductAttribute?: number | string;
      linkAction?: string;
      cart?: {
        products?: Partial<CartProduct>[];
      };
    }

    interface CartUpdateResponse {
      hasError?: boolean;
      errors?: string | string[];
      quantity?: number | string;
      id_product?: number;
      id_product_attribute?: number;
      cart?: {
        products?: CartProduct[];
      };
    }

    /** @deprecated The quantity selector binds through event delegation, no init call is needed */
    type LegacyFunction = (selector?: string, delay?: number) => void;
  }
}
