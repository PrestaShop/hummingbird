{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{extends file=$layout}

{block name='content'}
  <div class="row">
    <div class="col-md-4 col-lg-3">
      {include file='components/account-menu.tpl'}
    </div>

    <div class="col-md-8 col-lg-9">
      {block name='page_header_container'}
        {block name='page_title'}
          <div class="page-header">
            <h1 class="h4">{$smarty.block.child}</h1>
          </div>
        {/block}

        {block name='account_link'}
          <a class="btn btn-unstyle d-md-none account-menu__back" href="{$urls.pages.my_account}">
            <i class="material-icons" aria-hidden="true">&#xE5CB;</i> {l s='Back to your account' d='Shop.Theme.Customeraccount'}
          </a>
        {/block}
      {/block}

      {block name='page_content_container'}
        <section id="content" class="page-content page-customer">
          {block name='page_content_top'}{/block}

          {block name='page_content'}
            <!-- Page content -->
          {/block}
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
