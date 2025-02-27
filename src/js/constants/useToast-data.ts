/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

export const Theme = {
  light: 'text-bg-light',
  dark: 'text-bg-dark',
  primary: 'text-bg-primary',
  secondary: 'text-bg-secondary',
  info: 'text-bg-info',
  success: 'text-bg-success',
  warning: 'text-bg-warning',
  danger: 'text-bg-danger',
};

export const Fallback = `
  <div class="toast-container toast-container--fallback position-fixed top-0 end-0 p-3" id="js-toast-container">
    <template class="js-toast-template">
      <div class="toast toast--fallback" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
          <div class="toast-body"></div>
          <button type="button" class="btn-close me-2 m-auto d-none" data-bs-dismiss="toast"></button>
        </div>
      </div>
    </template>
  </div>
`;

export const Default: Theme.Toast.Options = {
  type: 'info',
  autohide: true,
  delay: 3000,
};
