{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div id="_desktop_contact_link">
  <div id="contact-link" class="contact-link">
    {if $contact_infos.phone}
      {* [1][/1] is for a HTML tag. *}
      {l
        s='Call us: [1]%phone%[/1]'
        sprintf=[
          '[1]' => '<span>',
          '[/1]' => '</span>',
          '%phone%' => $contact_infos.phone
        ]
        d='Shop.Theme.Global'
      }
    {else}
      <a href="{$urls.pages.contact}">{l s='Contact us' d='Shop.Theme.Global'}</a>
    {/if}
  </div>
</div>
