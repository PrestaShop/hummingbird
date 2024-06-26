{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{assign var='icon' value=$icon|default:'check'}
{assign var='modal_message' value=$modal_message|default:''}

<script type="text/javascript">
  document.addEventListener("DOMContentLoaded", function() {
    const alertModal = $('#{$modal_id}');
    alertModal.on('hidden.bs.modal', function () {
      alertModal.modal('hide');
    });
  });
</script>

<div id="{$modal_id}" class="modal fade product-comment-modal" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <p class="h2 mb-0">
          <i class="material-icons {$icon}" data-icon="{$icon}"></i>
          {$modal_title}
        </p>
      </div>
      
      <div class="modal-body">
        <div class="row">
          <div class="col-md-12  col-sm-12" id="{$modal_id}-message">
            {$modal_message}
          </div>
        </div>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" aria-label="{l s='OK' d='Modules.Productcomments.Shop'}">
          {l s='OK' d='Modules.Productcomments.Shop'}
        </button>
      </div>
    </div>
  </div>
</div>
