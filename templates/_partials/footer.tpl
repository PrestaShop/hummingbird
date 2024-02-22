{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div class="footer__before">
  {block name='hook_footer_before'}
    {hook h='displayFooterBefore'}
  {/block}
</div>

<div class="footer__main">
  <div class="container">
    <div class="footer__main__top row">
      {block name='hook_footer'}
        {hook h='displayFooter'}
      {/block}
    </div>

    <div class="footer__main__bottom row">
      {block name='hook_footer_after'}
        {hook h='displayFooterAfter'}
      {/block}
    </div>

    <p class="copyright">
      {block name='copyright_link'}
        <a href="https://www.prestashop-project.org/" target="_blank" rel="noopener noreferrer nofollow">
          {l s='%copyright% %year% - Ecommerce software by %prestashop%' sprintf=['%prestashop%' => 'PrestaShop™', '%year%' => 'Y'|date, '%copyright%' => '©'] d='Shop.Theme.Global'}
        </a>
      {/block}
    </p>
  </div>
</div>
