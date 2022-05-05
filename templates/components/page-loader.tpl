{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'page-loader'}

{block name='page_loader'}
  <div class="page-loader js-page-loader d-none">
    <div class="spinner-border text-primary" role="status">
      <span class="visually-hidden">{l s='Loading...' d='Shop.Theme.Global'}</span>
    </div>
  </div>
{/block}
