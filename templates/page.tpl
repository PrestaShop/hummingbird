{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file=$layout}

{block name='content'}
  {block name='page_header_container'}
    {block name='page_title'}
      <div class="page-header">
        <h1 class="h4">{$smarty.block.child}</h1>
      </div>
    {/block}
  {/block}

  {block name='page_content_container'}
    <section id="content" class="page-content page-general">
      {block name='page_content_top'}{/block}

      {block name='page_content'}
        <!-- Page content -->
      {/block}
    </section>
  {/block}

  {block name='page_footer_container'}
    <footer class="page-footer">
      {block name='page_footer'}
          <!-- Footer content -->
      {/block}
    </footer>
  {/block}
{/block}
