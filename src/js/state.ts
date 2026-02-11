export const availableLastUpdateAction = {
  DELETE_FROM_CART: 'delete-from-cart',
  UPDATE_PRODUCT_QUANTITY: 'update-product-quantity',
  SUBMIT_VOUCHER: 'submit-voucher',
  REMOVE_VOUCHER: 'remove-voucher',
};

type LastUpdateActionKey = keyof typeof availableLastUpdateAction;
type LastUpdateActionValue = typeof availableLastUpdateAction[LastUpdateActionKey] | null;

type ThemeStateType = {
  lastUpdateAction: LastUpdateActionValue;
  storedFocusElement: HTMLElement | null;
  storedFocusElementId: string | null;
};

class ThemeState {
  private state: ThemeStateType = {
    lastUpdateAction: null,
    storedFocusElement: null,
    storedFocusElementId: null,
  };

  get<K extends keyof ThemeStateType>(key: K): ThemeStateType[K] {
    return this.state[key];
  }

  set<K extends keyof ThemeStateType>(key: K, value: ThemeStateType[K]): void {
    this.state[key] = value;
  }

  merge(newState: Partial<ThemeStateType>) {
    this.state = {...this.state, ...newState};
  }
}

export default ThemeState;

// Create and export a single instance of ThemeState that can be shared across the theme
export const state = new ThemeState();
