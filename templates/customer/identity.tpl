{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends 'customer/page.tpl'}

{block name='page_title'}
  {l s='Your personal information' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <p>{l s='Update your personal information to keep your account details up to date.' d='Shop.Theme.Customeraccount'}</p>

  {render file='customer/_partials/customer-form.tpl' ui=$customer_form}
{/block}
