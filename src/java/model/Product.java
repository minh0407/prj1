package model;

import java.util.Date;

public class Product {

    private int id;
    private String name;
    private String slug;
    private String description;
    private double price;
    private int stock;
    private int sold;
    private String image;
    private double discount;
    private int warranty;
    private boolean isFeatured;
    private boolean status;
    private Date createdDate;
    private int categoryId;
    private int brandId;

    // JOIN fields - set thủ công sau khi query
    private String brandName;
    private String categoryName;

    public Product() {}

    public Product(int id, String name, String slug, String description,
            double price, int stock, int sold, String image,
            double discount, int warranty,
            boolean isFeatured, boolean status,
            Date createdDate, int categoryId, int brandId) {
        this.id = id;
        this.name = name;
        this.slug = slug;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.sold = sold;
        this.image = image;
        this.discount = discount;
        this.warranty = warranty;
        this.isFeatured = isFeatured;
        this.status = status;
        this.createdDate = createdDate;
        this.categoryId = categoryId;
        this.brandId = brandId;
    }

    // ── Computed getters dùng trong JSP ──────────────────────────────

    /** Giá sau giảm: price * (1 - discount/100) */
    public double getSalePrice() {
        if (discount <= 0) return price;
        return price * (1 - discount / 100.0);
    }

    /** % đã bán trên tổng (stock + sold) */
    public int getSoldPercent() {
        int total = stock + sold;
        if (total == 0) return 0;
        return (int) Math.round(sold * 100.0 / total);
    }

    // ── Standard getters/setters ──────────────────────────────────────

    public int getId()                  { return id; }
    public void setId(int id)           { this.id = id; }

    public String getName()             { return name; }
    public void setName(String name)    { this.name = name; }

    public String getSlug()             { return slug; }
    public void setSlug(String slug)    { this.slug = slug; }

    public String getDescription()              { return description; }
    public void setDescription(String d)        { this.description = d; }

    public double getPrice()            { return price; }
    public void setPrice(double price)  { this.price = price; }

    public int getStock()               { return stock; }
    public void setStock(int stock)     { this.stock = stock; }

    public int getSold()                { return sold; }
    public void setSold(int sold)       { this.sold = sold; }

    public String getImage()            { return image; }
    public void setImage(String image)  { this.image = image; }

    public double getDiscount()                 { return discount; }
    public void setDiscount(double discount)    { this.discount = discount; }

    public int getWarranty()                    { return warranty; }
    public void setWarranty(int warranty)       { this.warranty = warranty; }

    public boolean isIsFeatured()               { return isFeatured; }
    public void setIsFeatured(boolean f)        { this.isFeatured = f; }

    public boolean isStatus()                   { return status; }
    public void setStatus(boolean status)       { this.status = status; }

    public Date getCreatedDate()                { return createdDate; }
    public void setCreatedDate(Date d)          { this.createdDate = d; }

    public int getCategoryId()                  { return categoryId; }
    public void setCategoryId(int categoryId)   { this.categoryId = categoryId; }

    public int getBrandId()                     { return brandId; }
    public void setBrandId(int brandId)         { this.brandId = brandId; }

    public String getBrandName()                { return brandName != null ? brandName : ""; }
    public void setBrandName(String brandName)  { this.brandName = brandName; }

    public String getCategoryName()                     { return categoryName != null ? categoryName : ""; }
    public void setCategoryName(String categoryName)    { this.categoryName = categoryName; }
}
