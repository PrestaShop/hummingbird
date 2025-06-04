{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='brand_miniature_item'}
  <li class="brand">
    <div class="brand__image">
      <img class="brand__img img-fluid" src="{$brand.image}" alt="{$brand.name}" width="98" height="98" loading="lazy">
    </div>

    <div class="brand__infos">
      <a class="brand__title stretched-link" href="{$brand.url}">
        {$brand.name}
      </a>
    </div>

    <p class="brand__products">
      {$brand.nb_products}
    </p>
  </li>
{/block}
