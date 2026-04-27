{include file="header.tpl" page_title="Checkout"}

<section class="checkout">
    <h1>Review your order</h1>

    {if $cart.items}
        <table class="cart-summary">
            <thead>
                <tr><th>Item</th><th>Qty</th><th>Price</th></tr>
            </thead>
            <tbody>
                {foreach $cart.items as $line}
                    <tr>
                        <td>{$line.name}</td>
                        <td>{$line.quantity}</td>
                        <td>{$line.subtotal|string_format:"%.2f"}</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>

        <form action="/checkout/place-order" method="post">
            <fieldset>
                <legend>Shipping</legend>
                <label>Full name <input type="text" name="name" value="{$buyer.name}"></label>
                <label>Address <input type="text" name="address" value="{$buyer.address}"></label>
                <label>City <input type="text" name="city" value="{$buyer.city}"></label>

                <label>
                    Method
                    <select name="shipping_method">
                        <option value="standard">Standard</option>
                        <option value="express">Express</option>
                    </select>
                </label>

                {if $shipping_method == "express"}
                    <p class="note">Express delivery adds {$express_fee|string_format:"%.2f"}.</p>

                {if $promo_code == "WELCOME10"}
                    <p class="note">Promo applied: 10% off.</p>
                {/if}
            </fieldset>

            <fieldset>
                <legend>Payment</legend>
                <label>Card number <input type="text" name="card"></label>
                <label>Coupon <input type="text" name="coupon" value="{$applied_coupon}"></label>
            </fieldset>

            <button type="submit">Place order</button>
        </form>
    {else}
        <p>Your cart is empty. <a href="/products">Browse products</a>.</p>
    {/if}
</section>

{include file="footer.tpl"}
