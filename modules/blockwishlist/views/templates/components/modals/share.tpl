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
 class="wishlist-share"
 data-url="{$url}"
 data-title="{l s='Share wishlist' d='Modules.Blockwishlist.Shop'}"
 data-copied-text="{l s='Copied!' d='Modules.Blockwishlist.Shop'}"
 data-label="{l s='Share link' d='Modules.Blockwishlist.Shop'}"
 data-cancel-text="{l s='Cancel' d='Modules.Blockwishlist.Shop'}"
 data-copy-text="{l s='Copy text' d='Modules.Blockwishlist.Shop'}"
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
         <h5 class="modal-title">((title))</h5>
         <button
           type="button"
           class="btn-close"
           @click="toggleModal"
           data-dismiss="modal"
           aria-label="Close"
         >
         </button>
       </div>
       <div class="modal-body">
         <div class="form-group form-group-lg">
           <label class="form-label" for="input2">((label))</label>
           <input
             type="text"
             class="form-control form-control-lg"
             v-model="value"
             id="input2"
             placeholder="Share link"
           />
         </div>
       </div>
       <div class="modal-footer">
         <button
           type="button"
           class="modal-cancel btn btn-secondary"
           data-dismiss="modal"
           @click="toggleModal"
         >
           ((cancelText))
         </button>

         <button
           type="button"
           class="btn btn-primary"
           @click="copyLink"
         >
           (( actionText ))
         </button>
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
