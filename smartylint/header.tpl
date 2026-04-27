{* *}
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{$page_title} - Demoapp Store</title>
    <meta name="description" content="{$meta_description}">

    {include file=meta.tpl}
    {include file="styles.tpl" theme=$current_theme}

    <link rel="canonical" href="https://demoapp.example.com/{$canonical_path}>
</head>
<body class="page-{$page_class}">

    <header class="site-header">
        <a href="/" class="logo">{$site_name}</a>

        <nav class="primary-nav">
            <ul>
                {foreach $nav_items as $item}
                    <li><a href="{$item.url}">{$item.label}</a></li>
                {/foreach}
            </ul>
        </nav>

        {if $cart_count}
            <a href="/cart" class="cart-link">
                Cart ({$cart_count})
            </a>
        {/if}

        {if $logged_in}
            <span class="user-greeting">Welcome, {$user_name}!</span>
        {/if}
    </header>

    <main class="container">
