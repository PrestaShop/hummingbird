/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

/**
 * Promotes the zoom gallery's deferred image candidates the first time the modal is opened.
 *
 * WHY: the modal is rendered on every product page but starts hidden, and a browser fetches an
 * image inside a `display: none` container whatever its `loading` attribute says - `loading="lazy"`
 * does not defer it, because the element has no box to intersect the viewport with. The large
 * candidates therefore ship in `data-srcset` / `data-sizes` and the markup keeps a `src` the page
 * has already loaded, so a visitor who never zooms pays nothing and one who does still sees an
 * image immediately while the larger one arrives.
 */
const initProductImagesModal = () => {
  const {Theme: {selectors}} = window;
  const modal = document.querySelector<HTMLElement>(selectors.product.productImagesModal);

  if (!modal) {
    return;
  }

  const promoteDeferredCandidates = () => {
    modal.querySelectorAll<HTMLElement>('[data-srcset]').forEach((element) => {
      const {srcset, sizes} = element.dataset;

      // WHY: `sizes` has to be in place before `srcset`, because the browser resolves the candidate
      // list as soon as `srcset` appears - assigning it first would let it choose against the
      // default `100vw` and fetch a wider file than the modal will ever display.
      if (sizes) {
        element.setAttribute('sizes', sizes);
        delete element.dataset.sizes;
      }

      if (srcset) {
        element.setAttribute('srcset', srcset);
        delete element.dataset.srcset;
      }
    });
  };

  // WHY: no `once` option - promotion is already idempotent because each attribute is deleted as it
  // is promoted, so a reopened modal finds nothing left to do. One mechanism, and it is tested.
  modal.addEventListener('show.bs.modal', promoteDeferredCandidates);
};

export default initProductImagesModal;
