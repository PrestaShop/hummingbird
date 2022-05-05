{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='page.tpl'}

{block name="breadcrumb"}{/block}

{block name='page_title'}
  {$page.title}
{/block}

{capture assign="errorContent"}
  <h4>{l s='No products available yet' d='Shop.Theme.Catalog'}</h4>
  <p>{l s='Stay tuned! More products will be shown here as they are added.' d='Shop.Theme.Catalog'}</p>
{/capture}

{block name='page_content_container'}
  {include file='errors/not-found.tpl' errorContent=$errorContent}
{/block}
