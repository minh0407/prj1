package model;

import java.util.Date;

public class Wishlist {

    private int id;
    private int userId;
    private int productId;
    private Date addedDate;

    public Wishlist() {}

    public Wishlist(int id, int userId, int productId, Date addedDate) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.addedDate = addedDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Date getAddedDate() {
        return addedDate;
    }

    public void setAddedDate(Date addedDate) {
        this.addedDate = addedDate;
    }

    
}