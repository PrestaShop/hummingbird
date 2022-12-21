{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{function renderLogo}
  <a class="navbar-brand d-block" href="{$urls.pages.index}">
    <img
      class="logo img-fluid"
      src="{$shop.logo_details.src}"
      alt="{$shop.name}"
      width="{$shop.logo_details.width}"
      height="{$shop.logo_details.height}"
    >
  </a>
{/function}
