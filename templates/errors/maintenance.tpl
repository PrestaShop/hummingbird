{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='layouts/layout-error.tpl'}

{block name='content'}
  {block name='page_header_container'}
    <header class="page-header">
      {block name='page_header_logo'}
        <img 
          class="error__logo" 
          src="{$shop.logo}" 
          alt="{$shop.name}" 
          title="{$shop.name}" 
          width="{$shop.logo_details.width}" 
          height="{$shop.logo_details.height}" 
          loading="lazy"
        >
      {/block}

      {block name='hook_maintenance'}
        {capture name='maintenance_content'}{$HOOK_MAINTENANCE nofilter}{/capture}
        {if $smarty.capture.maintenance_content}
          <div class="error__content">
            {$smarty.capture.maintenance_content nofilter}
          </div>
        {/if}
      {/block}

      {block name='page_header'}
        <h1 class="error__title">
          {block name='page_title'}{l s='We\'ll be back soon.' d='Shop.Theme.Global'}{/block}
        </h1>
      {/block}
    </header>
  {/block}

  {block name='page_content_container'}
    {if $maintenance_text}
      <section id="content" class="page-content page-content--maintenance">
        <div class="error__text">
          {block name='page_content'}
            {$maintenance_text nofilter}
          {/block}
        </div>
      </section>
    {/if}
  {/block}

  {block name='page_footer_container'}{/block}
{/block}
