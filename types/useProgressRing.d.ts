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

    type TextType = 'enum' | 'percent' | 'hidden';

    interface Options {
      steps: number;
      text?: TextType;
    }

    type Function = (selector: string, options?: Options) => Return
  }
}
