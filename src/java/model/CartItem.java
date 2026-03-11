package model;

public class CartItem {

    private int    productId;
    private String productName;
    private String image;
    private double price;
    private int    quantity;
    private int    stock;

    public CartItem() {}

    public CartItem(int productId, String productName, String image,
                    double price, int quantity, int stock) {
        this.productId   = productId;
        this.productName = productName;
        this.image       = image;
        this.price       = price;
        this.quantity    = quantity;
        this.stock       = stock;
    }

    public int getProductId()             { return productId; }
    public void setProductId(int v)       { this.productId = v; }

    public String getProductName()        { return productName; }
    public void setProductName(String v)  { this.productName = v; }

    public String getImage()              { return image; }
    public void setImage(String v)        { this.image = v; }

    public double getPrice()              { return price; }
    public void setPrice(double v)        { this.price = v; }

    public int getQuantity()              { return quantity; }
    public void setQuantity(int v)        { this.quantity = v; }

    public int getStock()                 { return stock; }
    public void setStock(int v)           { this.stock = v; }

    /** Tổng tiền của item này */
    public double getSubtotal()           { return price * quantity; }

    /** Alias dùng trong JSP cũ */
    public double getTotal()              { return getSubtotal(); }
}
