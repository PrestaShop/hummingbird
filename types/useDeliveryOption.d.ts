/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

declare namespace Theme {
    namespace DeliveryOptionForm {
        interface DeliveryOptionItem {
            dataForm?: DataForm[],
            deliveryOption?: Record<number, HTMLElement>,
            resp?: Response,
        }

        interface Response {
            preview?: string,
        }

        interface DataForm {
            name?: string,
            value?: string,
        }
    }
}
