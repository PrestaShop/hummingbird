{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<section class="contact-form">
  <form action="{$urls.pages.contact}" method="post" {if $contact.allow_file_upload}enctype="multipart/form-data"{/if}>

    {if $notifications}
      <div class="alert {if $notifications.nw_error}alert-danger{else}alert-success{/if}" role="alert" tabindex="0">
        <ul class="mb-0">
          {foreach $notifications.messages as $notif}
            <li>{$notif}</li>
          {/foreach}
        </ul>
      </div>
    {/if}

    {if !$notifications || $notifications.nw_error}
      <section class="form-fields">
        {include file='components/page-title-section.tpl' title={l s='Contact us' d='Shop.Theme.Global'}}

        <div class="mb-3">
          <label class="form-label" for="contact-us-subject-select">
            {l s='Subject' d='Shop.Forms.Labels'}
          </label>
          <select id="contact-us-subject-select" name="id_contact" class="form-select">
            {foreach from=$contact.contacts item=contact_elt}
              <option value="{$contact_elt.id_contact}">{$contact_elt.name}</option>
            {/foreach}
          </select>
        </div>

        <div class="mb-3">
          <label class="form-label required" for="contact-us-email-input">
            {l s='Email address' d='Shop.Forms.Labels'}
          </label>
          <input
            id="contact-us-email-input"
            class="form-control"
            name="from"
            type="email"
            value="{$contact.email}"
            placeholder="{l s='your@email.com' d='Shop.Forms.Help'}"
            autocomplete="email"
            required
          >
        </div>

        {if $contact.orders}
          <div class="mb-3">
            <label class="form-label" for="contact-us-id-order-select">
              {l s='Order reference' d='Shop.Forms.Labels'}
            </label>
            <select id="contact-us-id-order-select" name="id_order" class="form-select">
              <option value="">{l s='Select reference' d='Shop.Forms.Help'}</option>
              {foreach from=$contact.orders item=order}
                <option value="{$order.id_order}">{$order.reference}</option>
              {/foreach}
            </select>
            <span class="form-text">{l s='optional' d='Shop.Forms.Help'}</span>
          </div>
        {/if}

        {if $contact.allow_file_upload}
          <div class="mb-3">
            <label class="form-label" for="contact-us-attachment-input">
              {l s='Attachment' d='Shop.Forms.Labels'}
            </label>
            <input
              id="contact-us-attachment-input"
              type="file"
              name="fileUpload"
              class="form-control"
            >
            <span class="form-text">{l s='optional' d='Shop.Forms.Help'}</span>
          </div>
        {/if}

        <div class="mb-3">
          <label class="form-label required" for="contact-us-message-textarea">
            {l s='Message' d='Shop.Forms.Labels'}
          </label>
          <textarea
            id="contact-us-message-textarea"
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

      <footer class="buttons-wrapper buttons-wrapper--end">
        <input type="hidden" name="url" value="" />
        <input type="hidden" name="token" value="{$token}" />
        <input
          class="btn btn-primary"
          type="submit"
          name="submitMessage"
          value="{l s='Send' d='Shop.Theme.Actions'}"
          aria-label="{l s='Send your message' d='Shop.Theme.Actions'}"
        >
      </footer>
    {/if}

  </form>
</section>
