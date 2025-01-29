{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<section id="content" class="page-content page-not-found">
  {block name='page_content'}
    {block name='error_content'}
      {if isset($errorContent)}
          {$errorContent nofilter}
          <a href="{$urls.pages.index}" class="btn btn-primary back-to-index">
            {l s='Back to Home page' d='Shop.Theme.Catalog'}
            <i class="material-icons rtl-flip" aria-hidden="true">&#xE315;</i>
          </a>
      {else}
        <h1 class="h4">{l s='The page you are looking for is no longer available' d='Shop.Theme.Catalog'}</h1>
        <p>{l s='It can not be reached anymore. Can we still attract you into our shop?' d='Shop.Theme.Catalog'}</p>
        <a class="btn btn-outline-primary btn-with-icon mt-3" href="{$urls.pages.index}">
          {l s='Go shopping' d='Shop.Theme.Catalog'}
          <i class="material-icons rtl-flip" aria-hidden="true">&#xE315;</i>
        </a>
      {/if}
    {/block}

    {block name='hook_not_found'}
      {hook h='displayNotFound'}
    {/block}
  {/block}
</section>
