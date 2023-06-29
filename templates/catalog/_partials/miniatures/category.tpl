{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='category_miniature_item'}
  <section class="category-miniature">
    <a href="{$category.url}">
      <img
        src="{$category.image.medium.url}"
        alt="{if !empty($category.image.legend)}{$category.image.legend}{else}{$category.name}{/if}"
        loading="lazy"
        width="250"
        height="250"
     >
    </a>

    <h1 class="h4">
      <a href="{$category.url}">{$category.name}</a>
    </h1>

    <div class="category-description">{$category.description nofilter}</div>
  </section>
{/block}
