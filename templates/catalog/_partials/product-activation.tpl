{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{if $page.admin_notifications}
  <div class="alert alert-warning" role="alert">
    <div class="container">
      {foreach $page.admin_notifications as $notif}
        <div>
          <i class="material-icons" aria-hidden="true">&#xE001;</i>

          <p class="alert-text">{$notif.message}</p>
        </div>
      {/foreach}
    </div>
  </div>
{/if}
