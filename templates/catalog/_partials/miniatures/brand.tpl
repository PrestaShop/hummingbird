{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='brand_miniature_item'}
  <li class="brand card col-6 col-md-4 col-lg-3">
    <div class="brand__img">
      <a href="{$brand.url}">
        <img src="{$brand.image}" alt="{$brand.name}" loading="lazy">
      </a>
    </div>

    <div class="brand__infos">
      <p><a class="brand__link" href="{$brand.url}">{$brand.name}</a></p>
      {$brand.text nofilter}
    </div>

    <div class="brand__products">
      <a class="btn" href="{$brand.url}">{$brand.nb_products}</a>
    </div>
  </li>
{/block}
