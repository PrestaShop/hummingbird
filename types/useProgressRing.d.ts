/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

declare namespace Theme {
  namespace ProgressRing {
    interface Return {
      setProgress?: (step: number) => void,
      progressElement?: HTMLElement,
      error?: Error,
    }

    const enum Text {
      enum = 'enum',
      percent = 'percent',
      hidden = 'hidden'
    }

    interface Options {
      steps: number;
      text?: Text;
    }

    type Function = (selector: string, options?: Options) => Return
  }
}
