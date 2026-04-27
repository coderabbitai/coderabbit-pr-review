{include file=header.tpl page_title="All Products"}

<section class="product-grid">
    <h1>{$category_name}</h1>

    <p class="result-count">
        Showing {$result_count} results for "{$search_query}"
    </p>

    {if $products}
        <ul class="products">
            {foreach $products as $product}
                <li class="product-card" data-id="{$product.id}">
                    <a href="/products/{$product.slug}">
                        <img src="{$product.image_url}" alt="{$product.name}">
                        <h2>{$product.name}</h2>
                        <p class="price">{$product.price|string_format:"%.2f"}</p>
                        <p class="description">{$product.short_description}</p>
                    </a>

                    {if $product.on_sale}
                        <span class="sale-badge">{$product.discount_label}</span>
                    {/if}

                    <button data-product="{$product.id}" data-name={$product.name}>
                        Add to cart
                    </button>
                </li>
        </ul>
    {else}
        <p>No products matched your filters.</p>
    {/if}

    <nav class="pagination">
        {foreach $pages as $page}
            <a href="?page={$page}">{$page}</a>
        {/foreach}
    </nav>
</section>

{include file="footer.tpl"}
