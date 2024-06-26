{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{assign var='icon' value=$icon|default:'check'}
{assign var='modal_message' value=$modal_message|default:''}

<script type="text/javascript">
  document.addEventListener("DOMContentLoaded", function() {
    const confirmModal = $('#{$modal_id}');
    confirmModal.on('hidden.bs.modal', function () {
      confirmModal.modal('hide');
      confirmModal.trigger('modal:confirm', false);
    });

    $('.confirm-button', confirmModal).click(function() {
      confirmModal.trigger('modal:confirm', true);
    });
    $('.refuse-button', confirmModal).click(function() {
      confirmModal.trigger('modal:confirm', false);
    });
  });
</script>

<div id="{$modal_id}" class="modal fade product-comment-modal" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <p class="h2">
          <i class="material-icons {$icon}" data-icon="{$icon}"></i>
          {$modal_title}
        </p>
      </div>

      <div class="modal-body">
        <div id="{$modal_id}-message">
          {$modal_message}
        </div>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-outline-primary me-2 refuse-button" data-bs-dismiss="modal" aria-label="{l s='No' d='Modules.Productcomments.Shop'}">
          {l s='No' d='Modules.Productcomments.Shop'}
        </button>
        <button type="button" class="btn btn-primary confirm-button" data-bs-dismiss="modal" aria-label="{l s='Yes' d='Modules.Productcomments.Shop'}">
          {l s='Yes' d='Modules.Productcomments.Shop'}
        </button>
      </div>
    </div>
  </div>
</div>
