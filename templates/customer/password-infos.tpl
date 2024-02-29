{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file='page.tpl'}

{block name='container_class'}container container--limited-sm{/block}

{block name='page_title'}
  {l s='Forgot your password?' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  {if count($successes)}
    <div class="alert alert-success" role="alert">
      <ul>
        {foreach $successes as $success}
          <li>{$success}</li>
        {/foreach}
      </ul>
    </div>
  {/if}
{/block}

{block name='page_footer'}
  <hr>
  <a id="back-to-login" href="{$urls.pages.authentication}" class="btn btn-unstyle btn-with-icon">
    <i class="material-icons rtl-flip" aria-hidden="true">&#xE5CB;</i>
    <span>{l s='Back to login' d='Shop.Theme.Actions'}</span>
  </a>
{/block}
