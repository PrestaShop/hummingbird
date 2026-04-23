/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
declare namespace Theme {
  type ThemeType = {
    events: EVENTS;
    selectors: SelectorsMap;
    components: Components;
  }

  type Components = {
    useToast: Theme.Toast.Function
    useAlert: Theme.Alert.Function
    useProgressRing: Theme.ProgressRing.Function,
    useQuantityInput: Theme.QuantityInput.Function,
  }

  interface Window {
    Theme: ThemeType;
  }
}

interface Window extends Theme.Window {
  prestashop: any;
}
