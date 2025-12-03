DROP DATABASE IF EXISTS qcomm_enterprise;
CREATE DATABASE qcomm_enterprise;
USE qcomm_enterprise;


-- MODULE 1: USERS & GEOGRAPHY


CREATE TABLE cities (
    city_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    city_name VARCHAR(100),
    state_name VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE users (
    user_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    full_name VARCHAR(100),
    email VARCHAR(150),
    is_prime_member BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_addresses (
    address_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    user_id CHAR(10),
    city_id CHAR(10),
    address_line_1 TEXT,
    address_line_2 TEXT,
    landmark VARCHAR(150),
    pincode VARCHAR(10),
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    address_type ENUM('Home', 'Work', 'Other'),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

CREATE TABLE user_wallets (
    wallet_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    user_id CHAR(10) UNIQUE,
    balance DECIMAL(10, 2) DEFAULT 0.00,
    currency VARCHAR(5) DEFAULT 'INR',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


-- MODULE 2: CATALOG & PRODUCTS


CREATE TABLE categories (
    category_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    parent_category_id CHAR(10) NULL, 
    name VARCHAR(100),
    image_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE brands (
    brand_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    name VARCHAR(100),
    logo_url VARCHAR(255)
);

CREATE TABLE taxes (
    tax_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    tax_name VARCHAR(50), 
    percentage DECIMAL(5, 2)
);

CREATE TABLE products (
    product_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    brand_id CHAR(10),
    category_id CHAR(10),
    name VARCHAR(200),
    description TEXT,
    base_image_url VARCHAR(255),
    tax_id CHAR(10),
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (tax_id) REFERENCES taxes(tax_id)
);

CREATE TABLE product_variants (
    variant_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    product_id CHAR(10),
    sku_code VARCHAR(50) UNIQUE, 
    weight_volume VARCHAR(50), 
    mrp DECIMAL(10, 2),
    selling_price DECIMAL(10, 2),
    max_allowed_qty INT DEFAULT 5, 
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- MODULE 3: WAREHOUSING & INVENTORY 


CREATE TABLE warehouses (
    warehouse_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    city_id CHAR(10),
    name VARCHAR(100),
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    service_radius_km DECIMAL(5, 2),
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

CREATE TABLE suppliers (
    supplier_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    name VARCHAR(150),
    contact_info VARCHAR(150),
    gstin VARCHAR(20)
);

CREATE TABLE purchase_orders (
    po_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    supplier_id CHAR(10),
    warehouse_id CHAR(10),
    status ENUM('Created', 'Received', 'Cancelled'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE inventory_batches (
    batch_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    warehouse_id CHAR(10),
    variant_id CHAR(10),
    po_id CHAR(10), 
    quantity_available INT,
    manufacturing_date DATE,
    expiry_date DATE NOT NULL,
    batch_number VARCHAR(50),
    aisle_number VARCHAR(10), 
    rack_number VARCHAR(10),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id),
    FOREIGN KEY (variant_id) REFERENCES product_variants(variant_id),
    FOREIGN KEY (po_id) REFERENCES purchase_orders(po_id)
);


-- MODULE 4: LOGISTICS & RIDERS


CREATE TABLE delivery_partners (
    rider_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    warehouse_id CHAR(10), 
    full_name VARCHAR(100),
    phone_number VARCHAR(15),
    dl_number VARCHAR(50),
    vehicle_type ENUM('Bike', 'EV_Scooter', 'Cycle'),
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE shifts (
    shift_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    shift_name VARCHAR(50), 
    start_time TIME,
    end_time TIME
);

CREATE TABLE rider_shifts (
    rider_shift_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    rider_id CHAR(10),
    shift_id CHAR(10),
    date DATE,
    login_time DATETIME,
    logout_time DATETIME,
    FOREIGN KEY (rider_id) REFERENCES delivery_partners(rider_id),
    FOREIGN KEY (shift_id) REFERENCES shifts(shift_id)
);


-- MODULE 5: ORDERS & TRANSACTIONS


CREATE TABLE coupons (
    coupon_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    code VARCHAR(20) UNIQUE,
    description VARCHAR(200),
    discount_type ENUM('Percentage', 'Flat'),
    discount_value DECIMAL(10, 2),
    min_order_value DECIMAL(10, 2),
    max_discount_amount DECIMAL(10, 2),
    valid_till DATETIME
);

CREATE TABLE orders (
    order_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    user_id CHAR(10),
    warehouse_id CHAR(10), 
    rider_id CHAR(10) NULL,
    address_id CHAR(10),
    coupon_id CHAR(10) NULL,
    total_mrp DECIMAL(10, 2),
    total_discount DECIMAL(10, 2),
    delivery_fee DECIMAL(10, 2),
    platform_fee DECIMAL(10, 2),
    final_amount DECIMAL(10, 2),
    payment_method ENUM('UPI', 'CreditCard', 'COD', 'Wallet'),
    order_status ENUM('Placed', 'Accepted', 'Packing', 'Ready', 'Out_For_Delivery', 'Delivered', 'Cancelled') DEFAULT 'Placed',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    delivery_time_slot_start DATETIME, 
    delivery_time_slot_end DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id),
    FOREIGN KEY (rider_id) REFERENCES delivery_partners(rider_id),
    FOREIGN KEY (address_id) REFERENCES user_addresses(address_id),
    FOREIGN KEY (coupon_id) REFERENCES coupons(coupon_id)
);

CREATE TABLE order_items (
    order_item_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    order_id CHAR(10),
    variant_id CHAR(10),
    batch_id CHAR(10), 
    quantity INT,
    price_at_time_of_order DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (variant_id) REFERENCES product_variants(variant_id),
    FOREIGN KEY (batch_id) REFERENCES inventory_batches(batch_id)
);


-- MODULE 6: FINANCE & SUPPORT


CREATE TABLE wallet_transactions (
    transaction_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    wallet_id CHAR(10),
    order_id CHAR(10) NULL,
    amount DECIMAL(10, 2),
    type ENUM('Credit', 'Debit'),
    description VARCHAR(255), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (wallet_id) REFERENCES user_wallets(wallet_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE support_tickets (
    ticket_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    user_id CHAR(10),
    order_id CHAR(10) NULL,
    category ENUM('Missing Item', 'Quality Issue', 'Delivery Delay', 'Other'),
    status ENUM('Open', 'In_Progress', 'Resolved'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE product_reviews (
    review_id CHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    user_id CHAR(10),
    product_id CHAR(10),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);