{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<section id="content" class="page-content page-content--not-found">
  {block name='page_content'}
    {block name='error_content'}
      {if isset($errorContent)}
        {$errorContent nofilter}

        <a href="{$urls.pages.index}" class="btn btn-primary">
          <i class="material-icons" aria-hidden="true">&#xE5C4;</i>
          {l s='Back to Home page' d='Shop.Theme.Catalog'}
        </a>
      {else}
        <h1 class="h2">{l s='The page you are looking for is no longer available' d='Shop.Theme.Catalog'}</h1>

        <p>{l s='It can not be reached anymore. Can we still attract you into our shop?' d='Shop.Theme.Catalog'}</p>

        <a class="btn btn-primary" href="{$urls.pages.index}">
          {l s='Go shopping' d='Shop.Theme.Catalog'}
          <i class="material-icons" aria-hidden="true">&#xE5C8;</i>
        </a>
      {/if}
    {/block}

    {block name='hook_not_found'}
      {hook h='displayNotFound'}
    {/block}
  {/block}
</section>
