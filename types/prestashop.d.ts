/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

declare namespace PrestaShop {
  /**
   * The emitter API. `src/js/prestashop.ts` copies `EventEmitter.prototype` onto the global,
   * so these are available from the moment `initEmitter()` has run.
   *
   * The payload is whatever the emitting side passes, so each listener names the shape it
   * expects and the type parameter is inferred from it. Core emits a second argument on at
   * least one event - `prestashop.emit('updatedProduct', data, form)` - hence the rest.
   */
  interface Emitter {
    on<T = unknown>(event: string, listener: (payload: T, ...rest: unknown[]) => void): PrestaShop.Global;
    once<T = unknown>(event: string, listener: (payload: T, ...rest: unknown[]) => void): PrestaShop.Global;
    off<T = unknown>(event: string, listener: (payload: T, ...rest: unknown[]) => void): PrestaShop.Global;
    emit(event: string, ...payload: unknown[]): boolean;
  }

  /**
   * Viewport state. Owned by the theme, written by `src/js/responsive-toggler.ts`.
   */
  type Responsive = {
    current_width: number;
    min_width: number;
    mobile: boolean;
  };

  /**
   * A subset of `FrontController::getTemplateVarUrls()`. `pages` maps a page name to its URL.
   */
  type Urls = {
    base_url: string;
    current_url: string;
    pages: Record<string, string>;
  };

  /**
   * What `prestashop.checkPasswordScore()` resolves to, narrowed to the fields the theme reads.
   * The core implementation returns a zxcvbn result.
   */
  type PasswordScore = {
    score: number;
    feedback: {
      warning: string;
      suggestions: string[];
    };
  };

  /**
   * Added by `src/js/modules/blockcart.ts`, so it is only present once that module has loaded.
   */
  type BlockCart = {
    showModal: (addToCartModal: string) => void;
  };

  /**
   * The `window.prestashop` object, as far as this theme relies on it.
   *
   * It is deliberately not an open map: core publishes more than this, and a contributor who
   * needs another member declares it here with its type rather than reaching through `any`.
   */
  interface Global extends Emitter {
    responsive: Responsive;
    urls: Urls;
    checkPasswordScore(password: string): Promise<PasswordScore>;
    blockcart?: BlockCart;
  }
}
