package model;

import java.util.Date;

public class Order {

    private int id;
    private int userId;
    private Integer couponId;
    private double discountAmount;
    private Date orderDate;
    private double totalAmount;
    private String shippingAddress;
    private String phoneReceiver;
    private String receiverName;
    private String note;
    private String paymentMethod;
    private String paymentStatus;
    private String status;
    private Date updatedDate;

    public Order() {}

    public Order(int id, int userId, Integer couponId, double discountAmount, Date orderDate, double totalAmount, String shippingAddress, String phoneReceiver, String receiverName, String note, String paymentMethod, String paymentStatus, String status, Date updatedDate) {
        this.id = id;
        this.userId = userId;
        this.couponId = couponId;
        this.discountAmount = discountAmount;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.shippingAddress = shippingAddress;
        this.phoneReceiver = phoneReceiver;
        this.receiverName = receiverName;
        this.note = note;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.status = status;
        this.updatedDate = updatedDate;
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

    public Integer getCouponId() {
        return couponId;
    }

    public void setCouponId(Integer couponId) {
        this.couponId = couponId;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getPhoneReceiver() {
        return phoneReceiver;
    }

    public void setPhoneReceiver(String phoneReceiver) {
        this.phoneReceiver = phoneReceiver;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }


    
}