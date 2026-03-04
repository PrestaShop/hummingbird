{* templates/checkout/_partials/connected-account-info.tpl *}
<div class="step__account">
    <p>
        {l s='Connected as [1]%firstname% %lastname%[/1].'
        d='Shop.Theme.Customeraccount'
        sprintf=[
            '[1]' => "<a href='{$urls.pages.identity}' aria-label='{l s='My account (%firstname% %lastname%)' d='Shop.Theme.Customeraccount' sprintf=['%firstname%' => $customer.firstname, '%lastname%' => $customer.lastname]}'>",
            '[/1]' => "</a>",
            '%firstname%' => $customer.firstname,
            '%lastname%' => $customer.lastname
        ]
        }
    </p>

    <p class="mb-1">
        {l
        s='Not you? [1]Sign out[/1]'
        d='Shop.Theme.Customeraccount'
        sprintf=[
        '[1]' => "<a class='text-danger' href='{$urls.actions.logout}'>",
        '[/1]' => "</a>"
        ]
        }
    </p>

    {if !isset($empty_cart_on_logout) || $empty_cart_on_logout}
        <p class="mb-0">
        <small class="text-body-tertiary">{l s='If you sign out now, your cart will be emptied.' d='Shop.Theme.Checkout'}</small>
        </p>
    {/if}
</div>