{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{extends file=$layout}

{block name='content'}
  <div class="row">
    {**
     * Used for the account menu in the guest tracking page, the account don't have to be shown
     *}
    {if $customer.is_logged && !$customer.is_guest}
      <div class="col-lg-3">
        {include file='components/account-menu.tpl'}
      </div>
    {/if}

    <div class="col-lg-{if $customer.is_logged && !$customer.is_guest}9{else}12{/if}">
      {block name='page_header_container'}
        {block name='page_title'}
          <div class="page-header">
            {include file='components/page-title-section.tpl' title={$smarty.block.child}}
          </div>
        {/block}

        {block name='account_link'}
          <a class="btn btn-outline-tertiary account-menu__back" href="{$urls.pages.my_account}">
            <i class="material-icons" aria-hidden="true">&#xE5C4;</i>
            {l s='Back to your account' d='Shop.Theme.Customeraccount'}
          </a>
        {/block}
      {/block}

      {block name='page_content_container'}
        <section id="content" class="page-content page-content--customer">
          {block name='page_content_top'}{/block}

          {block name='page_content'}{/block}
        </section>
      {/block}

      {block name='page_footer_container'}
          {block name='page_footer'}
            {block name='my_account_links'}
            {/block}
          {/block}
      {/block}
    </div>
  </div>
{/block}
