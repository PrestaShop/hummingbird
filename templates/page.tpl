{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file=$layout}

{block name='content'}
  {block name='page_header_container'}
    {block name='page_title'}
      <div class="page-header">
        {include file='components/page-title-section.tpl' title={$smarty.block.child}}
      </div>
    {/block}
  {/block}

  {block name='page_content_container'}
    <section id="content" class="page-content page-content--general">
      {block name='page_content_top'}{/block}

      {block name='page_content'}{/block}
    </section>
  {/block}

  {block name='page_footer_container'}
    <footer class="page-footer">
      {block name='page_footer'}{/block}
    </footer>
  {/block}
{/block}
