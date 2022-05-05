{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'toast'}

<template class="js-{$componentName}-template">
  <div class="{$componentName}" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="d-flex">
      <div class="{$componentName}-body"></div>
      <button type="button" class="btn-close me-2 m-auto d-none" data-bs-dismiss="toast"></button>
    </div>
  </div>
</template>
