{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{assign var='icon' value=$icon|default:'check'}
{assign var='modal_message' value=$modal_message|default:''}


<div id="{$modal_id}" class="modal fade product-comment-modal" tabindex="-1" aria-labelledby="{$modal_id}-title" aria-hidden="true" data-ps-ref="{$data_ps_ref|default:$modal_id}">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <p class="h2 modal-title" id="{$modal_id}-title">
          {$modal_title}
        </p>

        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}"></button>
      </div>

      <div class="modal-body">
        <div class="row">
          <div class="col-md-12  col-sm-12" id="{$modal_id}-message">
            {$modal_message}
          </div>
        </div>
      </div>

      <div class="modal-footer post-comment-buttons">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">
          {l s='Ok' d='Modules.Productcomments.Shop'}
        </button>
      </div>
    </div>
  </div>
</div>
