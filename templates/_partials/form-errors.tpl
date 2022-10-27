{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{if $errors|count}
  <div class="help-block">
    {block name='form_errors'}
      <div class="alert alert-danger mt-3">
          {if $errors|count > 1}
            <p class="mb-1">
              {l s='There are %d% errors:' sprintf=['%d%' => $errors|count] d='Shop.Notifications.Error'}
            </p>
            <ol>
              {foreach $errors as $error}
                <li>{$error|nl2br nofilter}</li>
              {/foreach}
            </ol>
          {else}
              {$errors.0|nl2br nofilter}
          {/if}
      </div>
    {/block}
  </div>
{/if}