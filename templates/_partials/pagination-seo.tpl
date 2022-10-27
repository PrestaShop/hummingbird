{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{if isset($listing.pagination) && $listing.pagination.should_be_displayed}
    {$page_nb = 1}
    {if isset($smarty.get.page)}
        {$page_nb = $smarty.get.page|intval|default:1}
    {/if}
    {$queryPage = '?page='|cat:$page_nb}
    {$page.canonical = $page.canonical|replace:$queryPage:''}

    {$prev = false}
    {$next = false}
    {if ($page_nb - 1) == 1}
        {$prev = $page.canonical}
    {elseif $page_nb> 2}
        {$prev = ($page['canonical']|cat:'?page='|cat:($page_nb - 1))}
    {/if}
    {if $listing.pagination.total_items> $listing.pagination.items_shown_to}
        {$next = ($page['canonical']|cat:'?page='|cat:($page_nb + 1))}
    {/if}

    {if $prev}<link rel="prev" href="{$prev}">{/if}
    {if $next}<link rel="next" href="{$next}">{/if}
{/if}
