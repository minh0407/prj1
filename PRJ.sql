															/* ============================= */
/*      CREATE DATABASE          */
/* ============================= */
/*USE master;
GO

ALTER DATABASE HomeElectroDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

DROP DATABASE HomeElectroDB;
*/


CREATE DATABASE HomeElectroDB;
GO

USE HomeElectroDB;
GO


/* ============================= */
/*            USERS              */
/* ============================= */

CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullname NVARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    avatar VARCHAR(255),
    role VARCHAR(20) DEFAULT 'user',
    status BIT DEFAULT 1,
    createdDate DATETIME DEFAULT GETDATE()
);


/* ============================= */
/*     USER ADDRESSES            */
/* ============================= */

CREATE TABLE UserAddresses (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    fullAddress NVARCHAR(255) NOT NULL,
    receiverName NVARCHAR(100),
    receiverPhone VARCHAR(20),
    isDefault BIT DEFAULT 0,

    FOREIGN KEY (userId) REFERENCES Users(id)
);


/* ============================= */
/*          CATEGORIES           */
/* ============================= */

CREATE TABLE Categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    slug VARCHAR(150),
    icon VARCHAR(255),
    status BIT DEFAULT 1
);


/* ============================= */
/*            BRANDS             */
/* ============================= */

CREATE TABLE Brands (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    logo VARCHAR(255),
    country NVARCHAR(100),
    status BIT DEFAULT 1
);


/* ============================= */
/*            PRODUCTS           */
/* ============================= */

CREATE TABLE Products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(200) NOT NULL,
    slug VARCHAR(255),
    description NVARCHAR(MAX),
    price DECIMAL(18,2) NOT NULL,
    stock INT DEFAULT 0,
    sold INT DEFAULT 0,
    image VARCHAR(255),
    discount DECIMAL(5,2) DEFAULT 0,
    warranty INT DEFAULT 0,
    isFeatured BIT DEFAULT 0,
    status BIT DEFAULT 1,
    createdDate DATETIME DEFAULT GETDATE(),
    categoryId INT,
    brandId INT,

    FOREIGN KEY (categoryId) REFERENCES Categories(id),
    FOREIGN KEY (brandId) REFERENCES Brands(id)
);


/* ============================= */
/*        PRODUCT IMAGES         */
/* ============================= */

CREATE TABLE ProductImages (
    id INT IDENTITY(1,1) PRIMARY KEY,
    productId INT NOT NULL,
    imageUrl VARCHAR(255) NOT NULL,
    sortOrder INT DEFAULT 0,

    FOREIGN KEY (productId) REFERENCES Products(id)
);


/* ============================= */
/*             CART              */
/* ============================= */

CREATE TABLE Cart (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    productId INT NOT NULL,
    quantity INT DEFAULT 1,
    addedDate DATETIME DEFAULT GETDATE(),

    CONSTRAINT UQ_Cart_UserProduct UNIQUE (userId, productId),
    FOREIGN KEY (userId) REFERENCES Users(id),
    FOREIGN KEY (productId) REFERENCES Products(id)
);


/* ============================= */
/*           WISHLIST            */
/* ============================= */

CREATE TABLE Wishlist (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    productId INT NOT NULL,
    addedDate DATETIME DEFAULT GETDATE(),

    CONSTRAINT UQ_Wishlist_UserProduct UNIQUE (userId, productId),
    FOREIGN KEY (userId) REFERENCES Users(id),
    FOREIGN KEY (productId) REFERENCES Products(id)
);


/* ============================= */
/*         COUPONS / VOUCHER     */
/* ============================= */

CREATE TABLE Coupons (
    id INT IDENTITY(1,1) PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    discountType VARCHAR(20) DEFAULT 'percent', -- percent / fixed
    discountValue DECIMAL(18,2) NOT NULL,
    minOrderAmount DECIMAL(18,2) DEFAULT 0,
    maxUsage INT DEFAULT 1,
    usedCount INT DEFAULT 0,
    startDate DATETIME,
    endDate DATETIME,
    status BIT DEFAULT 1
);


/* ============================= */
/*             ORDERS            */
/* ============================= */

CREATE TABLE Orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    couponId INT NULL,                          -- NEW
    discountAmount DECIMAL(18,2) DEFAULT 0,     -- NEW
    orderDate DATETIME DEFAULT GETDATE(),
    totalAmount DECIMAL(18,2),
    shippingAddress NVARCHAR(255),
    phoneReceiver VARCHAR(20),
    receiverName NVARCHAR(100),
    note NVARCHAR(500),
    paymentMethod VARCHAR(50),
    paymentStatus VARCHAR(50) DEFAULT 'Unpaid',
    status NVARCHAR(50) DEFAULT 'Pending',
    updatedDate DATETIME,

    FOREIGN KEY (userId) REFERENCES Users(id),
    FOREIGN KEY (couponId) REFERENCES Coupons(id)
);


/* ============================= */
/*         ORDER DETAILS         */
/* ============================= */

CREATE TABLE OrderDetails (
    id INT IDENTITY(1,1) PRIMARY KEY,
    orderId INT NOT NULL,
    productId INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(18,2) NOT NULL,
    discount DECIMAL(5,2) DEFAULT 0,

    FOREIGN KEY (orderId) REFERENCES Orders(id),
    FOREIGN KEY (productId) REFERENCES Products(id)
);


/* ============================= */
/*            REVIEWS            */
/* ============================= */

CREATE TABLE Reviews (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    productId INT NOT NULL,
    orderId INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment NVARCHAR(500),
    status BIT DEFAULT 1,
    createdDate DATETIME DEFAULT GETDATE(),

    CONSTRAINT UQ_Review_UserProduct UNIQUE (userId, productId),
    FOREIGN KEY (userId) REFERENCES Users(id),
    FOREIGN KEY (productId) REFERENCES Products(id),
    FOREIGN KEY (orderId) REFERENCES Orders(id)
);
GO

