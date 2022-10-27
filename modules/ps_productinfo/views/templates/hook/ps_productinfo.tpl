{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div class="js-productinfo mt-1">
  {if isset($vars_nb_people)}
    <p>
      {if $vars_nb_people['%nb_people%'] == 1}
        {l s='1 person is currently watching this product.' d='Shop.Theme.Catalog'}
      {else}
        {l s='%nb_people% people are currently watching this product.' sprintf=$vars_nb_people d='Shop.Theme.Catalog'}
      {/if}
    </p>
  {/if}

  {if isset($vars_date_last_order)}
    <p>{l s='Last time this product was bought: %date_last_order%' sprintf=$vars_date_last_order d='Shop.Theme.Catalog'}</p>
  {/if}

  {if isset($vars_date_last_cart)}
    <p>{l s='Last time this product was added to a cart: %date_last_cart%' sprintf=$vars_date_last_cart d='Shop.Theme.Catalog'}</p>
  {/if}
</div>
