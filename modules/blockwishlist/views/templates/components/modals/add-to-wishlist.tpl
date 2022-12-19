{**
 * 2007-2020 PrestaShop and Contributors
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

<div
 class="wishlist-add-to"
 data-url="{$url}"
>
 <div
   class="wishlist-modal modal fade"
   {literal}
     :class="{show: !isHidden}"
   {/literal}
   tabindex="-1"
   role="dialog"
   aria-modal="true"
 >
   <div class="modal-dialog modal-dialog-centered" role="document">
     <div class="modal-content">
       <div class="modal-header px-3">
         <h5 class="modal-title">
           {l s='Add to wishlist' d='Modules.Blockwishlist.Shop'}
         </h5>
         <button
           type="button"
           class="btn-close"
           @click="toggleModal"
           data-dismiss="modal"
           aria-label="{l s='Close' d='Modules.Blockwishlist.Shop'}"
         >
         </button>
       </div>

       <div class="modal-body">
         <choose-list
           @hide="toggleModal"
           :product-id="productId"
           :product-attribute-id="productAttributeId"
           :quantity="quantity"
           url="{$url}"
           add-url="{$addUrl}"
           empty-text="{l s='No list found.' d='Modules.Blockwishlist.Shop'}"
         ></choose-list>
       </div>

       <div class="modal-footer">
         <a @click="openNewWishlistModal" class="wishlist-add-to-new text-primary">
           <i class="material-icons text-primary">add_circle_outline</i> {$newWishlistCTA}
         </a>
       </div>
     </div>
   </div>
 </div>

 <div 
   class="modal-backdrop fade"
   {literal}
     :class="{in: !isHidden}"
   {/literal}
 >
 </div>
</div>
