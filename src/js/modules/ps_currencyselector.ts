/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const initCurrencySelector = () => {
  const {Theme} = window;
  const {currencySelector: CurrencySelectorMap} = Theme.selectors;
  const currencySelector = document.querySelector<HTMLElement>(CurrencySelectorMap.currencySelector);

  currencySelector?.addEventListener('change', (event) => {
    const option = event.target as HTMLOptionElement;

    window.location.href = option.value;
  });
};

$(() => {
  const {prestashop, Theme: {events}} = window;

  initCurrencySelector();

  prestashop.on(events.responsiveUpdate, () => {
    initCurrencySelector();
  });
});

window.Theme.default = {
  ...window.Theme.default,
  initCurrencySelector,
};
