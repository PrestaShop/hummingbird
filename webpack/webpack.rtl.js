const cssjanus = require('cssjanus');

module.exports = function (source) {
	return cssjanus.transform(source);
}
