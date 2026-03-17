{**
 * OPC — Order options (delivery message, recyclable packaging, gift)
 * Mirrors the order-options block from shipping.tpl for ISO UX.
 *
 * Variables: $delivery_message, $recyclablePackAllowed, $recyclable, $gift
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="order-options mt-3">
  <div class="mb-3">
    <label for="delivery_message" class="form-label">
      {l s='Write a comment about this order' d='Shop.Theme.Checkout'}
    </label>
    <textarea
      class="form-control"
      rows="2"
      id="delivery_message"
      name="delivery_message"
      placeholder="{l s='Write your comment...' d='Shop.Theme.Checkout'}"
    >{$delivery_message|escape:'html'}</textarea>
  </div>

  {if $recyclablePackAllowed}
    <div class="form-check mb-3">
      <input
        class="form-check-input"
        type="checkbox"
        id="input_recyclable"
        name="recyclable"
        value="1"
        {if $recyclable}checked{/if}
      >
      <label class="form-check-label" for="input_recyclable">
        {l s='I would like to receive my order in recycled packaging.' d='Shop.Theme.Checkout'}
      </label>
    </div>
  {/if}

  {if $gift.allowed}
    <div class="form-check mb-2">
      <input
        class="form-check-input js-gift-checkbox"
        type="checkbox"
        id="input_gift"
        name="gift"
        value="1"
        data-bs-toggle="collapse"
        data-bs-target="#opc-gift-message"
        {if $gift.isGift}checked{/if}
      >
      <label class="form-check-label" for="input_gift">
        {$gift.label}
      </label>
    </div>

    <div id="opc-gift-message" class="collapse{if $gift.isGift} show{/if} mb-3">
      <label for="gift_message" class="form-label">
        {l s="If you'd like, you can add a note to the gift:" d='Shop.Theme.Checkout'}
      </label>
      <textarea
        class="form-control"
        rows="2"
        id="gift_message"
        name="gift_message"
      >{$gift.message|escape:'html'}</textarea>
    </div>
  {/if}
</div>
