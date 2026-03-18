/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */

type Validator<T> = (data: unknown) => data is T;
