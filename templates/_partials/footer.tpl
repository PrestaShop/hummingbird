{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div class="footer__before">

  {include file='_partials/reassurance.tpl'}

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

    <div class="container-fluid">
      <div class="row">
        <div class="col-12 col-xl-4 text-center text-lg-start mb-4">
          <img width="200" height="100" class="img-fluid footer__logo" loading="lazy" src="{$urls.img_url}logo-a4x-400x200-W.webp"
               alt="Logo alternatif d'accessauto4x4">
          <p class=" my-4">
            Accessauto4x4 est votre spécialiste de l'accessoire automobile, 4x4, SUV et véhicules utilitaires, Notre
            large gamme de produits conformes ou constructeurs s'adaptent parfaitement à vos modèles de véhicule.
          </p>

          <a href="#" class="btn btn-light text-uppercase">Nous contacter</a>
        </div>

        <div class="row col-12 col-xl-8 mt-4">

          <div class="col-12 mb-4">
            <p class=" text-center">
              {include file="_svg/telephone-fill.svg"}&nbsp;
              Support téléphonique - <span class="text-primary fst-italic">France : (+33).6.66.11.14.81</span> - Espagne : +34.972.505.421
            </p>
          </div>

          <div class="col-12 col-md-6 text-center">
            <span class="h2 text-primary">COMMANDES</span>
            <ul>
              <li class="">liens</li>
              <li class="">liens</li>
              <li class="">liens</li>
              <li class="">liens</li>
            </ul>
          </div>

          <div class="col-12 col-md-6 text-center">
            <span class="h2 text-primary">INFORMATIONS</span>
            <ul>
              <li class="">liens</li>
              <li class="">liens</li>
              <li class="">liens</li>
              <li class="">liens</li>
            </ul>
          </div>
        </div>
      </div>
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
