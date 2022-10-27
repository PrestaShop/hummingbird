/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

// Mainly used by tests
const resetHTMLBodyContent = (bodyContent: string) => {
  const body = document.querySelector<HTMLBodyElement>('body');

  if (body) {
    body.innerHTML = bodyContent;
  }
};

export default resetHTMLBodyContent;
