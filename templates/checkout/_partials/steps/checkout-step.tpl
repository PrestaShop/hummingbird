{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{block name='step'}
  <section  id    = "{$identifier}"
            class = "{[
                        'step'   => true,
                        'tab-pane'   => true,
                        'collapse'   => true,
                        'step--current'        => $step_is_current,
                        'step--reachable'      => $step_is_reachable,
                        'step--complete'       => $step_is_complete && !$step_is_current,
                        'js-current-step' => $step_is_current,
                        'active' => $step_is_current,
                        'show' => $step_is_current
                    ]|classnames} mb-5"
            role = "tabpanel"
  >
    <div class="step__title js-step-title">
      {if isset($step_is_current) && $step_is_current}
        <h1 class="step__title-left third-title">
      {else}
        <p class="step__title-left third-title">
      {/if}
        {$title}
      {if isset($step_is_current) && $step_is_current}
        </h1>
      {else}
        </p>
      {/if}
      
      <hr />
    </div>

    <div class="step__content">
      {block name='step_content'}DUMMY STEP CONTENT{/block}
    </div>
  </section>
{/block}
