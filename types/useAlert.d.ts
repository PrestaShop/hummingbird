/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

declare namespace Theme {
  namespace Alert {
    type Type = 'info' | 'dark' | 'primary' | 'secondary' | 'success' | 'warning' | 'danger';

    interface Options {
      type: Type;
      autohide?: boolean;
      delay?: number;
      classlist?: string;
      title?: string;
      template?: string;
      icon?: string;
      selector?: string;
      dismissible?: boolean;
    }

    interface Instance {
      instance: bootstrap.Alert | null;
      element: HTMLElement | null;
      show: () => boolean;
      hide: () => boolean;
      dispose: () => boolean;
      remove: () => boolean;
      title: (markup?: string) => string | false;
      message: (markup?: string) => string | boolean;
    }

    type Function = (message: string, options?: Options) => Instance
  }
}
