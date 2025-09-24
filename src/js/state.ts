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
    this.state = { ...this.state, ...newState };
  }
}

const themeState = new ThemeState();
export default themeState;
