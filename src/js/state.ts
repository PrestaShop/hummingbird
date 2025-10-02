type CartState = {
  cartUpdateAction?: 'delete-from-cart' | 'update-product-quantity' | 'submit-voucher' | 'remove-voucher' | null;
};

type FocusState = {
  storedFocusElement: HTMLElement | null;
  storedFocusElementId: string | null;
};

type ThemeStateType = CartState & FocusState;

class ThemeState {
  private state: ThemeStateType = {
    cartUpdateAction: null,
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
