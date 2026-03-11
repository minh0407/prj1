package model;

public class UserAddress {

    private int id;
    private int userId;
    private String fullAddress;
    private String receiverName;
    private String receiverPhone;
    private boolean isDefault;

    public UserAddress() {
    }

    public UserAddress(int id, int userId, String fullAddress,
            String receiverName, String receiverPhone,
            boolean isDefault) {
        this.id = id;
        this.userId = userId;
        this.fullAddress = fullAddress;
        this.receiverName = receiverName;
        this.receiverPhone = receiverPhone;
        this.isDefault = isDefault;
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

    public String getFullAddress() {
        return fullAddress;
    }

    public void setFullAddress(String fullAddress) {
        this.fullAddress = fullAddress;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public boolean isDefault() {
        return isDefault;
    }

    public void setDefault(boolean aDefault) {
        isDefault = aDefault;
    }
}
