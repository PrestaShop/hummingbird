{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{extends file='page.tpl'}

{block name='container_class'}container container--limited-md{/block}

{block name='page_title'}
  {l s='Withdrawal confirmed' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <section class="withdrawal-confirmation" id="withdrawal-confirmation">
    <p>
      {l
        s='Your withdrawal from the order %reference% was received on %date%.'
        d='Shop.Theme.Customeraccount'
        sprintf=['%reference%' => $withdrawal.order_reference, '%date%' => $withdrawal.submitted_at]
      }
    </p>
    <p>
      {l
        s='An acknowledgement of receipt has been sent to %email%. We will contact you about the return of the goods and your refund.'
        d='Shop.Theme.Customeraccount'
        sprintf=['%email%' => $withdrawal.email]
      }
    </p>
  </section>
{/block}
