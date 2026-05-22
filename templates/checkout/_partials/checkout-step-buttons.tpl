{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}

{if isset($previous_step) && (!isset($show_back_button) || $show_back_button)}
  <button class="btn btn-outline-primary js-back" type="button" data-step="{$previous_step.identifier}">
    <i class="material-icons rtl-flip" aria-hidden="true">&#xE5C4;</i>
    {l s='Back to %step_title%' d='Shop.Theme.Actions' sprintf=['%step_title%' => $previous_step.title]}
  </button>
{/if}

{if isset($next_step) && (!isset($show_next_button) || $show_next_button)}
  <button type="{if isset($submit_type)}{$submit_type}{else}submit{/if}" class="btn btn-primary" {if isset($submit_name)}name="{$submit_name}"{/if} {if isset($submit_value)}value="{$submit_value}"{/if}>
    {l s='Continue to %step_title%' d='Shop.Theme.Actions' sprintf=['%step_title%' => $next_step.title]}
    <i class="material-icons rtl-flip" aria-hidden="true">&#xE5C8;</i>
  </button>
{/if}
