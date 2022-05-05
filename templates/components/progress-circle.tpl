{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{$radius = $size / 2 - $stroke * 2}
{$circumference = $radius * 2 * constant('M_PI')}

{$circumference = $circumference|string_format:"%.4f"}

<svg
  class="progress-ring{if $classes} {$classes}{/if}"
  width="{$size}"
  height="{$size}"
  style="width: {$size}px; height: {$size}px;"
>
  <circle
    class="progress-ring__background-circle"
    stroke-width="{$stroke}"
    fill="transparent"
    r="{$radius}"
    cx="{$size / 2}"
    cy="{$size / 2}"
  />
  <circle
    class="progress-ring__circle"
    stroke="currentColor"
    stroke-width="{$stroke}"
    data-percent="0"
    fill="transparent"
    r="{$radius}"
    cx="{$size / 2}"
    cy="{$size / 2}"
    style="stroke-dasharray: {$circumference}, {$circumference}; stroke-dashoffset: {$circumference};"
  />
  <text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle"></text>
</svg>
