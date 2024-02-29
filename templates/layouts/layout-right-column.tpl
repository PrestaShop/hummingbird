{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='layouts/layout-both-columns.tpl'}

{block name='content_columns'}
  <div class="{block name='container_class'}container{/block}">
    <div class="row">
      {block name='left_column'}{/block}

      {block name='content_wrapper'}
        <div id="content-wrapper" class="wrapper__content col-md-8 col-lg-9">
          {hook h='displayContentWrapperTop'}
          {block name='content'}
            <p>Hello world! This is HTML5 Boilerplate.</p>
          {/block}
          {hook h='displayContentWrapperBottom'}
        </div>
      {/block}

      {block name='right_column'}
        <div id="right-column" class="wrapper__right-column col-md-4 col-lg-3">
          {if $page.page_name == 'product'}
            {hook h='displayRightColumnProduct'}
          {else}
            {hook h='displayRightColumn'}
          {/if}
        </div>
      {/block}
    </div>
  </div>
{/block}
