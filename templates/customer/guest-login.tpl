{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{extends file='page.tpl'}

{block name='container_class'}container container--limited-sm{/block}

{block name='page_title'}
  {l s='Guest Order Tracking' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  {* Submitted with POST so the shopper's email address does not end up in the URL, where it reaches
     analytics as a page path, the browser history, the access log and any referrer. The controller reads
     the fields with Tools::getValue(), which takes POST as well, and links that already carry the
     parameters in a query string keep working. *}
  <form id="guestOrderTrackingForm" action="{$urls.pages.guest_tracking}" method="post">
    <input type="hidden" name="controller" value="guest-tracking">

    <p>{l s='To track your order, please enter the following information:' d='Shop.Theme.Customeraccount'}</p>

    <div class="mb-3">
      <label class="form-label required">
        {l s='Order Reference' d='Shop.Forms.Labels'}
      </label>

      <input
        class="form-control"
        name="order_reference"
        type="text"
        size="8"
        value="{if isset($smarty.request.order_reference)}{$smarty.request.order_reference}{/if}"
      >

      <div class="form-text">
        {l s='For example: QIIXJXNUI or QIIXJXNUI#1' d='Shop.Theme.Customeraccount'}
      </div>
    </div>

    <div class="mb-3">
      <label class="form-label required">
        {l s='Email' d='Shop.Forms.Labels'}
      </label>

      <input
        class="form-control"
        name="email"
        type="email"
        value="{if isset($smarty.request.email)}{$smarty.request.email}{/if}"
      >
    </div>

    <footer class="buttons-wrapper buttons-wrapper--end">
      <button class="btn btn-primary" type="submit">
        {l s='Send' d='Shop.Theme.Actions'}
      </button>
    </footer>
  </form>
{/block}
