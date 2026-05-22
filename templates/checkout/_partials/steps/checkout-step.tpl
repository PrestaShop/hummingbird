{**
 * For the full copyright and license information, please view the
 * LICENSE.md file that was distributed with this source code.
 *}
{block name='step'}
  {$previous_step = null}
  {$next_step = null}
  {if isset($checkout_steps)}
    {foreach from=$checkout_steps item="step" key="index"}
      {if $step.identifier == $identifier}
        {if isset($checkout_steps[$index - 1])}
          {$previous_step = $checkout_steps[$index - 1]}
        {/if}
        {if isset($checkout_steps[$index + 1])}
          {$next_step = $checkout_steps[$index + 1]}
        {/if}
        {break}
      {/if}
    {/foreach}
  {/if}
  <section 
    id="{$identifier}" 
    class="{[
      'step' => true,
      'tab-pane' => true,
      'collapse' => true,
      'step--current' => $step_is_current,
      'step--reachable' => $step_is_reachable,
      'step--complete' => $step_is_complete && !$step_is_current,
      'js-current-step' => $step_is_current,
      'active' => $step_is_current,
      'show' => $step_is_current
    ]|classnames}" role="tabpanel">
    <div class="step__title js-step-title">
      {if $step_is_current eq true}
        <h1 class="page-title-section">
      {else}
        <p class="page-title-section">
      {/if}
        {$title}
      {if $step_is_current eq true}
        </h1>
      {else}
        </p>
      {/if}

      <hr>
    </div>

    <div class="step__content">
      {block name='step_content'}DUMMY STEP CONTENT{/block}
    </div>
  </section>
{/block}
