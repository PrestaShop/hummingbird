{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{if $nb_comments != 0}
  <div class="comments-note">
    <div class="grade-stars" data-grade="{$grade}"></div>
    {if isset($showNbComments) && $showNbComments}
      <div class="comments-number">({$nb_comments})</div>
    {elseif isset($showGradeAverage) && $showGradeAverage}
      <div class="average-grade">({$grade|number_format:1})</div>
    {/if}
  </div>
{/if}
