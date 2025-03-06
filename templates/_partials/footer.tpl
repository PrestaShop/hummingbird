{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{capture name="footer_before"}{hook h='displayFooterBefore'}{/capture}
{if isset($smarty.capture.footer_before) && $smarty.capture.footer_before}
  <div class="footer footer__before">
    {block name='hook_footer_before'}
      {$smarty.capture.footer_before nofilter}
    {/block}
  </div>
{/if}

<div class="footer footer__main">
  <div class="container">
    <div class="footer__main-top row">
      {block name='hook_footer'}
        {hook h='displayFooter'}
      {/block}
    </div>

    {capture name="footer_main_bottom"}{hook h='displayFooterAfter'}{/capture}
    {if isset($smarty.capture.footer_main_bottom) && $smarty.capture.footer_main_bottom}
      <div class="footer__main-bottom row">
        {block name='hook_footer_after'}
          {$smarty.capture.footer_main_bottom nofilter}
        {/block}
      </div>
    {/if}

    <p class="copyright">
      {block name='copyright_link'}
        <a href="https://www.prestashop-project.org/" target="_blank" rel="noopener noreferrer nofollow">
          {l s='%copyright% %year% - Ecommerce software by %prestashop%' sprintf=['%prestashop%' => 'PrestaShop™', '%year%' => 'Y'|date, '%copyright%' => '©'] d='Shop.Theme.Global'}
        </a>
      {/block}
    </p>
  </div>
</div>
