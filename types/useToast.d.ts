/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

 declare namespace Theme {
  namespace Toast {
    type Type = 'info' | 'dark' | 'primary' | 'secondary' | 'success' | 'warning' | 'danger';

    interface Options {
      type: Type;
      icon?: string;
      title?: string;
      dismissible?: boolean;
      classlist?: string;
      selector?: string;
      autohide?: boolean;
      template?: string;
      delay?: number;
    }

    interface Instance {
      instance: bootstrap.Toast | null;
      element: HTMLElement | null;
      show: () => boolean;
      hide: () => boolean;
      dispose: () => boolean;
      remove: () => boolean;
      message: (markup?: string) => string | boolean;
      content: null | HTMLElement;
    }

    type Function = (message: string, options?: Theme.Toast.Options) => Theme.Toast.Instance
  }
}
