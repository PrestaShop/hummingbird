{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='address_form'}
  <div class="js-address-form">
    {include file='_partials/form-errors.tpl' errors=$errors['']}

    {block name='address_form_url'}
    <form
      class="form-validation"
      method="POST"
      action="{url entity='address' params=['id_address' => $id_address]}"
      data-id-address="{$id_address}"
      data-refresh-url="{url entity='address' params=['ajax' => 1, 'action' => 'addressForm', 'id_address' => $id_address]}"
      novalidate
    >
    {/block}

      {block name='address_form_fields'}
        <section class="form-fields">
          {block name='form_fields'}
            {foreach from=$formFields item="field"}
              {block name='form_field'}
                {form_field field=$field}
              {/block}
            {/foreach}
          {/block}
        </section>
      {/block}

      {block name='address_form_footer'}
        {block name='form_buttons'}
          <footer class="buttons-wrapper buttons-wrapper--end">
            <input type="hidden" name="submitAddress" value="1">
            <button class="btn btn-primary form-control-submit" type="submit">
              {l s='Save' d='Shop.Theme.Actions'}
            </button>
          </footer>
        {/block}
      {/block}
    </form>
  </div>
{/block}
