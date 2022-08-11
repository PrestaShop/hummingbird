/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

const initLanguageSelector = () => {
  const {Theme} = window;
  const {languageSelector: LanguageSelectorMap} = Theme.selectors;
  const languageSelector = document.querySelector<HTMLElement>(LanguageSelectorMap.languageSelector);

  languageSelector?.addEventListener('change', (event) => {
    const option = event.target as HTMLOptionElement;

    window.location.href = option.value;
  });
};

$(() => {
  const {prestashop, Theme: {events}} = window;

  initLanguageSelector();

  prestashop.on(events.responsiveUpdate, () => {
    initLanguageSelector();
  });
});

window.Theme.default = {
  ...window.Theme.default,
  initLanguageSelector,
};
