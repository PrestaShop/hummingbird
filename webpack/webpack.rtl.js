/**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 */
const cssjanus = require('cssjanus');

module.exports = function (source) {
	return cssjanus.transform(source);
}
