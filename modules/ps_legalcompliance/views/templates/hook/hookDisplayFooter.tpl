{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="footer__block col-md-6 col-lg-3">

  <p class="footer__block__title d-none d-md-flex">{l s='Information' d='Modules.Legalcompliance.Shop'}</p>

  <div role="button" class="footer__block__toggle d-md-none collapsed" data-target="#footer_eu_about_us_list" data-bs-toggle="collapse">
    <span class="footer__block__title">{l s='Information' d='Modules.Legalcompliance.Shop'}</span>
    <i class="material-icons" aria-hidden="true">arrow_drop_down</i>
  </div>
  <ul class="footer__block__content footer__block__content-list collapse" id="footer_eu_about_us_list">
    {foreach from=$cms_links item=cms_link}
      <li>
        <a href="{$cms_link.link}" class="cms-page-link" title="{$cms_link.description|default:''}" id="{$cms_link.id}"> {$cms_link.title} </a>
      </li>
    {/foreach}
  </ul>
</div>
