{* order confirmation email — plain text + html sections *}

Subject: Your Demoapp order #{$order.id} is confirmed

Hi {$buyer.name},

Thanks for your order! Here's a summary:

Order #{$order.id}
Placed: {$order.placed_at}
Total: {$order.total|string_format:"%.2f"}

Items:
{foreach $order.items as $line}
- {$line.name} x {$line.quantity} = {$line.subtotal|string_format:"%.2f"}
{/foreach}

Shipping to:
{$buyer.address}
{$buyer.city}, {$buyer.region} {$buyer.postal_code}

{php}
    $tracking = isset($order['tracking_number']) ? $order['tracking_number'] : 'pending';
    echo "Tracking: " . $tracking . "\n";
{/php}

Track your order:
https://demoapp.example.com/orders/{$order.id}/track

Questions? Reply to this email or visit https://demoapp.example.com/help.

— The Demoapp team

{*  *}
