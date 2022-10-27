{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{if isset($notifications)}
<div id="notifications">
  <div class="container">
    {if $notifications.error}
      {block name='notifications_error'}
        <article class="alert alert-danger" role="alert" data-alert="danger">
          <ul class="mb-0">
            {foreach $notifications.error as $notif}
              <li>{$notif nofilter}</li>
            {/foreach}
          </ul>
        </article>
      {/block}
    {/if}

    {if $notifications.warning}
      {block name='notifications_warning'}
        <article class="alert alert-warning" role="alert" data-alert="warning">
          <ul class="mb-0">
            {foreach $notifications.warning as $notif}
              <li>{$notif nofilter}</li>
            {/foreach}
          </ul>
        </article>
      {/block}
    {/if}

    {if $notifications.success}
      {block name='notifications_success'}
        <article class="alert alert-success" role="alert" data-alert="success">
          <ul class="mb-0">
            {foreach $notifications.success as $notif}
              <li>{$notif nofilter}</li>
            {/foreach}
          </ul>
        </article>
      {/block}
    {/if}

    {if $notifications.info}
      {block name='notifications_info'}
        <article class="alert alert-info" role="alert" data-alert="info">
          <ul class="mb-0">
            {foreach $notifications.info as $notif}
              <li>{$notif nofilter}</li>
            {/foreach}
          </ul>
        </article>
      {/block}
    {/if}
  </div>
</div>
{/if}
