{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='layouts/layout-error.tpl'}

{block name='content'}

    {block name='page_header_container'}
      <header class="page-header">
        <div class="logo"><img src="{$shop.logo.src}" alt="logo" loading="lazy"></div>
        {block name='page_header'}
          <h1>{block name='page_title'}{$shop.name}{/block}</h1>
        {/block}
      </header>
    {/block}

    {block name='page_content_container'}
      <section id="content" class="page-content page-restricted">
        {block name='page_content'}
          <h2>{l s='403 Forbidden' d='Shop.Theme.Global'}</h2>
          <p>{l s='You cannot access this store from your country. We apologize for the inconvenience.' d='Shop.Theme.Global'}</p>
        {/block}
      </section>
    {/block}

    {block name='page_footer_container'}

    {/block}

{/block}
