    package model;

    import java.util.Date;

    public class Review {

        private int id;
        private int userId;
        private int productId;
        private Integer orderId;
        private int rating;
        private String comment;
        private boolean status;
        private Date createdDate;

        public Review() {}

        public Review(int id, int userId, int productId, Integer orderId, int rating, String comment, boolean status, Date createdDate) {
            this.id = id;
            this.userId = userId;
            this.productId = productId;
            this.orderId = orderId;
            this.rating = rating;
            this.comment = comment;
            this.status = status;
            this.createdDate = createdDate;
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

        public Integer getOrderId() {
            return orderId;
        }

        public void setOrderId(Integer orderId) {
            this.orderId = orderId;
        }

        public int getRating() {
            return rating;
        }

        public void setRating(int rating) {
            this.rating = rating;
        }

        public String getComment() {
            return comment;
        }

        public void setComment(String comment) {
            this.comment = comment;
        }

        public boolean isStatus() {
            return status;
        }

        public void setStatus(boolean status) {
            this.status = status;
        }

        public Date getCreatedDate() {
            return createdDate;
        }

        public void setCreatedDate(Date createdDate) {
            this.createdDate = createdDate;
        }


    }