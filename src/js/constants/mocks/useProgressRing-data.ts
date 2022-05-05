/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

export const Template = `
  <svg class="progress-ring text-success col-4" width="74" height="74" style="width: 74px; height: 74px;">
    <circle
      class="progress-ring__background-circle" 
      stroke-width="4" 
      fill="transparent"
      r="29"
      cx="37" 
      cy="37"
    ></circle>
    <circle 
      class="progress-ring__circle" 
      stroke="currentColor" 
      stroke-width="4" 
      data-percent="0" 
      fill="transparent" 
      r="29" 
      cx="37" 
      cy="37"
      style="stroke-dasharray: 182.212, 182.212; stroke-dashoffset: 0;"
    ></circle>
    <text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle"></text>
  </svg>
 `;

export const TemplateWithoutText = `
  <svg class="progress-ring text-success col-4" width="74" height="74" style="width: 74px; height: 74px;">
    <circle
      class="progress-ring__background-circle" 
      stroke-width="4" 
      fill="transparent"
      r="29"
      cx="37" 
      cy="37"
    ></circle>
    <circle 
      class="progress-ring__circle" 
      stroke="currentColor" 
      stroke-width="4" 
      data-percent="0" 
      fill="transparent" 
      r="29" 
      cx="37" 
      cy="37"
      style="stroke-dasharray: 182.212, 182.212; stroke-dashoffset: 0;"
    ></circle>
  </svg>
 `;

export const TemplateWithoutCircle = `
 <svg class="progress-ring text-success col-4" width="74" height="74" style="width: 74px; height: 74px;">
   <text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle"></text>
 </svg>
`;

export default {
  Template,
  TemplateWithoutText,
};
