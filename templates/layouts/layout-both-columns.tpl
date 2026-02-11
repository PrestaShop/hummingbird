{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{include file='_partials/helpers.tpl'}

<!doctype html>
<html lang="{$language.locale}">
  <head>
    {block name='head'}
      {include file='_partials/head.tpl'}
    {/block}
  </head>

  <body id="{$page.page_name}" class="{$page.body_classes|classnames}">
    {block name='top_content'}
      <div id="back-to-top"></div>
    {/block}

    {block name='skip_to_main_content'}
      <a class="visually-hidden-focusable btn btn-primary skip-link" href="#main-content">{l s='Skip to main content' d='Shop.Theme.Global'}</a>
    {/block}

    {block name='hook_after_body_opening_tag'}
      {hook h='displayAfterBodyOpeningTag'}
    {/block}

    {block name='product_activation'}
      {include file='catalog/_partials/product-activation.tpl'}
    {/block}

    <header id="header" class="header js-sticky-header">
      {block name='header'}
        {include file='_partials/header.tpl'}
      {/block}
    </header>

    <main id="wrapper" class="wrapper">
      {hook h='displayWrapperTop'}
      
      {block name='breadcrumb'}
        {include file='_partials/breadcrumb.tpl'}
      {/block}

      {block name='main_content'}
        {* This is the main content anchor used for accessibility. *}
        <div id="main-content"></div>
      {/block}

      {block name='notifications'}
        {include file='_partials/notifications.tpl'}
      {/block}

      {block name='content_columns'}
        <div class="{block name='container_class'}columns-container container{/block}">
          <div class="row">
            {block name='left_column'}
              <div id="left-column" class="left-column col-md-4 col-lg-3">
                {if $page.page_name === 'product'}
                  {hook h='displayLeftColumnProduct'}
                {else}
                  {hook h='displayLeftColumn'}
                {/if}
              </div>
            {/block}

            {block name='content_wrapper'}
              <div id="center-column" class="center-column page col-md-4 col-lg-6">
                {hook h='displayContentWrapperTop'}
                {block name='content'}
                  <p>Hello world! This is HTML5 Boilerplate.</p>
                {/block}
                {hook h='displayContentWrapperBottom'}
              </div>
            {/block}

            {block name='right_column'}
              <div id="right-column" class="right-column col-md-4 col-lg-3">
                {if $page.page_name === 'product'}
                  {hook h='displayRightColumnProduct'}
                {else}
                  {hook h='displayRightColumn'}
                {/if}
              </div>
            {/block}
          </div>
        </div>
      {/block}

      {hook h='displayWrapperBottom'}
    </main>

    {block name='footer'}
      <footer id="footer" class="footer">
        {include file='_partials/footer.tpl'}
      </footer>
    {/block}

    {block name='javascript_bottom'}
      {include file='_partials/javascript.tpl' javascript=$javascript.bottom}
    {/block}

    {block name='bottom_elements'}
      {include file='components/page-loader.tpl'}
      {include file='components/toast-container.tpl'}
      {include file='components/password-policy-template.tpl'}
    {/block}

    {block name='hook_before_body_closing_tag'}
      {hook h='displayBeforeBodyClosingTag'}
    {/block}

    {block name='modal_container'}
      <div data-ps-target="modal-container">
        {capture name="modal_content"}{hook h='displayModalContent'}{/capture}
        {if $smarty.capture.modal_content}
          {$smarty.capture.modal_content nofilter}
        {/if}
      </div>
    {/block}

    {block name='back_to_top'}
      <a class="visually-hidden-focusable btn btn-primary back-to-top-link" href="#back-to-top">{l s='Back to top' d='Shop.Theme.Global'}</a>
    {/block}
  </body>
</html>
