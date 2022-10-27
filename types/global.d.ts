declare namespace Theme {
  type ThemeType = {
    events: EVENTS;
    selectors: SelectorsMap;
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
  $: JQueryStatic;
  jQuery: JQueryStatic;
}

interface JQuery {
  inputSpinner: any;
  modal: any;
}
