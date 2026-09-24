{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{* Stock label of a product, with the icon and the colour of its availability state.
   The caller passes its own BEM block as $componentName, and optionally a $dataPsRef. *}
{if !empty($product.availability_message)}
  {** First, we prepare the icons and colors we want to use *}
  {if $product.availability == 'in_stock'}
    {assign 'availability_icon' 'E5CA'}
    {assign 'availability_class' 'text-success'}
  {elseif $product.availability == 'available'}
    {assign 'availability_icon' 'E002'}
    {assign 'availability_class' 'text-warning'}
  {elseif $product.availability == 'last_remaining_items'}
    {assign 'availability_icon' 'E002'}
    {assign 'availability_class' 'text-warning'}
  {else}
    {assign 'availability_icon' 'E14B'}
    {assign 'availability_class' 'text-danger'}
  {/if}

  {** And render the availability message with icon *}
  <div class="{$componentName}__availability-status {$availability_class}" aria-live="off"{if !empty($dataPsRef)} data-ps-ref="{$dataPsRef}"{/if}>
    <i class="{$componentName}__availability-icon material-icons rtl-no-flip" aria-hidden="true">&#x{$availability_icon};</i>

    <div class="{$componentName}__availability-messages">
      <span class="visually-hidden">{l s='Product availability:' d='Shop.Theme.Global'}</span>
      <span>{$product.availability_message}</span>

      {if !empty($product.availability_submessage)}
        <small class="d-block">{$product.availability_submessage}</small>
      {/if}
    </div>
  </div>
{/if}
