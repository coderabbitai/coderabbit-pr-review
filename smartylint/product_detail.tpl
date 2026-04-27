{include file="header.tpl" page_title=$Product.name}

<article class="product-detail">
    <div class="gallery">
        {foreach $Product.images as $Image}
            <img src="{$Image.url}" alt="{$Image.alt|@default:""}">
        {/foreach}
    </div>

    <div class="info">
        <h1>{$Product.name}</h1>
        <p class="sku">SKU: {$Product.sku|@default:"n/a"}</p>
        <p class="price">{$Product.price|string_format:"%.2f"}</p>

        <div class="description">
            {$Product.long_description}
        </div>

        {if $Product.in_stock}
            <form action="/cart/add" method="post">
                <input type="hidden" name="product_id" value="{$Product.id}">
                <label>
                    Quantity:
                    <input type="number" name="qty" min="1" value="1">
                </label>
                <button type="submit">Add to cart</button>
            </form>
        {/if}
    </div>

    <section class="reviews">
        <h2>Customer reviews</h2>
        {foreach $Reviews as $Review}
            <article class="review">
                <header>
                    <strong>{$Review.author_name}</strong>
                    <time>{$Review.created_at|@default:"recently"}</time>
                </header>
                <p>{$Review.body}</p>
            </article>
        {/foreach}
    </section>

    {if $RelatedProducts}
        <aside class="related">
            <h2>You may also like</h2>
            {foreach $RelatedProducts as $Related}
                <a href="/products/{$Related.slug}">{$Related.name}</a>
            {/foreach}
        </aside>
    {/if}
</article>

{include file="footer.tpl"}
