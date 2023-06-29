{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<section class="contact-form">
  <form action="{$urls.pages.contact}" method="post" {if $contact.allow_file_upload}enctype="multipart/form-data"{/if}>
    {if $notifications}
      <div class="alert {if $notifications.nw_error}alert-danger{else}alert-success{/if}">
        <ul>
          {foreach $notifications.messages as $notif}
            <li>{$notif}</li>
          {/foreach}
        </ul>
      </div>
    {/if}

    {if !$notifications || $notifications.nw_error}
      <section class="form-fields">

        <h1 class="h2 mb-4">{l s='Contact us' d='Shop.Theme.Global'}</h1>

        <div class="mb-3">
          <label class="form-label">{l s='Subject' d='Shop.Forms.Labels'}</label>
          <select name="id_contact" class="form-select">
            {foreach from=$contact.contacts item=contact_elt}
              <option value="{$contact_elt.id_contact}">{$contact_elt.name}</option>
            {/foreach}
          </select>
        </div>

        <div class="mb-3">
          <label class="form-label">{l s='Email address' d='Shop.Forms.Labels'}</label>
          <input
            class="form-control"
            name="from"
            type="email"
            value="{$contact.email}"
            placeholder="{l s='your@email.com' d='Shop.Forms.Help'}"
          >
        </div>

        {if $contact.orders}
          <div class="mb-3">
            <label class="form-label">{l s='Order reference' d='Shop.Forms.Labels'}</label>
            <select name="id_order" class="form-select">
              <option value="">{l s='Select reference' d='Shop.Forms.Help'}</option>
              {foreach from=$contact.orders item=order}
                <option value="{$order.id_order}">{$order.reference}</option>
              {/foreach}
            </select>
            <span class="form-text">
              {l s='optional' d='Shop.Forms.Help'}
            </span>
          </div>
        {/if}

        {if $contact.allow_file_upload}
          <div class="mb-3">
            <label class="form-label" for="fileUpload">{l s='Attachment' d='Shop.Forms.Labels'}</label>
            <input type="file" name="fileUpload" class="form-control">
            <span class="form-text">
              {l s='optional' d='Shop.Forms.Help'}
            </span>
          </div>
        {/if}

        <div class="mb-3">
          <label class="form-label">{l s='Message' d='Shop.Forms.Labels'}</label>
          <textarea
            class="form-control"
            name="message"
            placeholder="{l s='How can we help?' d='Shop.Forms.Help'}"
            rows="3"
          >{if $contact.message}{$contact.message}{/if}</textarea>
        </div>

        {if isset($id_module)}
          <div class="mb-3">
            {hook h='displayGDPRConsent' id_module=$id_module}
          </div>
        {/if}

      </section>

      <footer class="form-footer">
        <style>
          input[name=url] {
            display: none !important;
          }
        </style>
        <input type="text" name="url" value=""/>
        <input type="hidden" name="token" value="{$token}" />
        <input class="btn btn-primary" type="submit" name="submitMessage" value="{l s='Send' d='Shop.Theme.Actions'}">
      </footer>
    {/if}

  </form>
</section>
