/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
import initProductImagesModal from '@js/product-images-modal';
import selectorsMap from '@constants/selectors-map';

const SRCSET = '/320.jpg 320w, /720.jpg 720w, /1440.jpg 1440w';
const SIZES = '(min-width: 1200px) 1440px, (min-width: 768px) 720px, 100vw';

function renderModal(): {modal: HTMLElement; img: HTMLImageElement; source: HTMLSourceElement} {
  document.body.innerHTML = `
    <div data-ps-ref="product-images-modal">
      <picture>
        <source data-srcset="${SRCSET}" data-sizes="${SIZES}" type="image/webp">
        <img src="/720.jpg" data-srcset="${SRCSET}" data-sizes="${SIZES}" alt="">
      </picture>
    </div>`;

  return {
    modal: document.querySelector<HTMLElement>(selectorsMap.product.productImagesModal) as HTMLElement,
    img: document.querySelector('img') as HTMLImageElement,
    source: document.querySelector('source') as HTMLSourceElement,
  };
}

describe('product images modal', () => {
  beforeEach(() => {
    window.Theme = {selectors: selectorsMap} as Theme.ThemeType;
  });

  test('leaves the large candidates deferred until the modal is opened', () => {
    const {img, source} = renderModal();

    initProductImagesModal();

    expect(img.hasAttribute('srcset')).toBe(false);
    expect(source.hasAttribute('srcset')).toBe(false);
    expect(img.getAttribute('src')).toBe('/720.jpg');
  });

  test('promotes srcset and sizes on both the img and the source when the modal opens', () => {
    const {modal, img, source} = renderModal();

    initProductImagesModal();
    modal.dispatchEvent(new Event('show.bs.modal'));

    expect(img.getAttribute('srcset')).toBe(SRCSET);
    expect(img.getAttribute('sizes')).toBe(SIZES);
    expect(source.getAttribute('srcset')).toBe(SRCSET);
    expect(source.getAttribute('sizes')).toBe(SIZES);
    expect(img.dataset.srcset).toBeUndefined();
    expect(img.dataset.sizes).toBeUndefined();
  });

  test('sets sizes before srcset so the browser never resolves against the default 100vw', () => {
    const {modal, img} = renderModal();
    const order: string[] = [];
    const setAttribute = img.setAttribute.bind(img);

    jest.spyOn(img, 'setAttribute').mockImplementation((name: string, value: string) => {
      order.push(name);
      setAttribute(name, value);
    });

    initProductImagesModal();
    modal.dispatchEvent(new Event('show.bs.modal'));

    expect(order).toEqual(['sizes', 'srcset']);
  });

  test('a candidate without deferred sizes gets srcset only, not a stray sizes attribute', () => {
    document.body.innerHTML = `
      <div data-ps-ref="product-images-modal">
        <img src="/720.jpg" data-srcset="${SRCSET}" alt="">
      </div>`;
    const modal = document.querySelector<HTMLElement>(selectorsMap.product.productImagesModal) as HTMLElement;
    const img = document.querySelector('img') as HTMLImageElement;

    initProductImagesModal();
    modal.dispatchEvent(new Event('show.bs.modal'));

    expect(img.getAttribute('srcset')).toBe(SRCSET);
    expect(img.hasAttribute('sizes')).toBe(false);
  });

  test('is idempotent, so reopening the modal does not overwrite the resolved candidates', () => {
    const {modal, img} = renderModal();

    initProductImagesModal();
    modal.dispatchEvent(new Event('show.bs.modal'));
    img.setAttribute('srcset', '/changed.jpg 1x');
    modal.dispatchEvent(new Event('show.bs.modal'));

    expect(img.getAttribute('srcset')).toBe('/changed.jpg 1x');
  });
});
