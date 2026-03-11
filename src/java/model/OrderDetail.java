package model;

public class OrderDetail {

    private int    orderId;
    private int    productId;
    private int    quantity;
    private double price;
    private double discount; // phần trăm giảm giá, thường = 0

    public OrderDetail() {}

    public OrderDetail(int orderId, int productId, int quantity, double price, double discount) {
        this.orderId   = orderId;
        this.productId = productId;
        this.quantity  = quantity;
        this.price     = price;
        this.discount  = discount;
    }

    public int    getOrderId()            { return orderId; }
    public void   setOrderId(int v)       { this.orderId = v; }

    public int    getProductId()          { return productId; }
    public void   setProductId(int v)     { this.productId = v; }

    public int    getQuantity()           { return quantity; }
    public void   setQuantity(int v)      { this.quantity = v; }

    public double getPrice()              { return price; }
    public void   setPrice(double v)      { this.price = v; }

    public double getDiscount()           { return discount; }
    public void   setDiscount(double v)   { this.discount = v; }

    /** Thành tiền sau giảm giá */
    public double getSubtotal() {
        return price * quantity * (1 - discount / 100.0);
    }
}
