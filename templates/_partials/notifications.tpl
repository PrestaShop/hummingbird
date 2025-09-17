{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{if isset($notifications)}
<div id="notifications">
  <div class="container">
    {if $notifications.error}
      {block name='notifications_error'}
        <article class="alert alert-danger alert-dismissible" role="alert" data-alert="danger" tabindex="0">
        {if $notifications.error|count > 1}
          <ul class="mb-0">
          {foreach $notifications.error as $notif}
            <li>{$notif nofilter}</li>
          {/foreach}
          </ul>
          {else}
            {$notifications.error.0 nofilter}
          {/if}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </article>
      {/block}
    {/if}

    {if $notifications.warning}
      {block name='notifications_warning'}
        <article class="alert alert-warning alert-dismissible" role="alert" data-alert="warning" tabindex="0">
          {if $notifications.warning|count > 1}
            <ul class="mb-0">
              {foreach $notifications.warning as $notif}
                <li>{$notif nofilter}</li>
              {/foreach}
            </ul>
          {else}
            {$notifications.warning.0 nofilter}
          {/if}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </article>
      {/block}
    {/if}

    {if $notifications.success}
      {block name='notifications_success'}
        <article class="alert alert-success alert-dismissible" role="alert" data-alert="success" tabindex="0">
          {if $notifications.success|count > 1}
            <ul class="mb-0">
              {foreach $notifications.success as $notif}
                <li>{$notif nofilter}</li>
              {/foreach}
            </ul>
          {else}
            {$notifications.success.0 nofilter}
          {/if}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </article>
      {/block}
    {/if}

    {if $notifications.info}
      {block name='notifications_info'}
        <article class="alert alert-info alert-dismissible" role="status" data-alert="info" tabindex="0">
          {if $notifications.info|count > 1}
            <ul class="mb-0">
              {foreach $notifications.info as $notif}
                <li>{$notif nofilter}</li>
              {/foreach}
            </ul>
          {else}
            {$notifications.info.0 nofilter}
          {/if}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </article>
      {/block}
    {/if}
  </div>
</div>
{/if}
