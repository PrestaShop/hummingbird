/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

export const Theme = {
  light: 'alert-light',
  dark: 'alert-dark',
  primary: 'alert-primary',
  secondary: 'alert-secondary',
  info: 'alert-info',
  success: 'alert-success',
  warning: 'alert-warning',
  danger: 'alert-danger',
};

export const Codepoint = {
  light: 'e88f',
  dark: 'e88f',
  primary: 'e88f',
  secondary: 'e88f',
  info: 'e88e',
  success: 'e5ca',
  warning: 'e002',
  danger: 'e000',
};

export const Template = `
  <div class="alert alert-dismissible fade d-flex align-items-center" role="alert">
    <h4 class="alert-heading w-100 d-none"></h4>
    <i class="material-icons flex-shrink-0 me-2"></i>
    <div class="alert-body flex-fill"></div>
    <button type="button" class="btn-close ms-2" data-bs-dismiss="alert"></button>
  </div>
`;

export const Default: Theme.Alert.Options = {
  type: 'info',
  dismissible: true,
};
