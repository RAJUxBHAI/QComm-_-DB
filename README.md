# DBMS Project – ERR Based Database Design

**Course:** DBMS (ETB – Term 2)
**Project Title:** 
QComm Lite – Quick Commerce Database System

**Group ID:** 15
**Members:**

* 341066 – Ramanjan Dutta
* 341090 – Nandini Singh
* 341077 – Mohammed Sarshad

---

## Project Overview

**QComm Lite** is a relational database system designed to model the core operations of a **quick commerce platform** such as Zepto, Blinkit, or Swiggy Instamart.
This version of the project focuses on a **clean, normalized ERR-based schema** that captures the essential workflows of instant delivery systems, including customers, products, warehouses, orders, payments, and delivery partners.

Compared to the earlier enterprise-heavy design, this schema is **simplified, structured, and academically optimized**, while still reflecting real-world business logic.

---

## Key Features

* Customer onboarding with multi-address support
* Hierarchical product categorization
* Store (warehouse) level inventory tracking
* Order lifecycle with item-level details
* Delivery partner assignment
* Payment and wallet integration
* Strong referential integrity using foreign keys

This design demonstrates practical DBMS concepts such as **normalization, entity relationships, indexing, and transactional consistency**.

---

## Database Design Philosophy

The schema is designed with the following goals:

* **Clarity over complexity** – Easy-to-understand entities and relations
* **Normalization** – Reduced redundancy and clean dependencies
* **Scalability-ready** – Can be extended to enterprise-level systems
* **Real-world alignment** – Mirrors actual quick-commerce workflows
* **ERR-first approach** – All tables derived directly from the ER diagram

---

## Database Schema Overview

The database consists of **core business entities**, interconnected through primary and foreign keys as shown in the ERR diagram.

---

## 1. Customers & Addresses

This module manages customer identity and delivery locations.

### Customers

* Stores basic customer details such as name, email, phone number
* Automatically tracks account creation timestamp

### Customer Addresses

* Supports multiple addresses per customer
* Each address includes city and pincode
* Used directly during order placement

### Customer Wallets

* Digital wallet linked to each customer
* Stores balance and currency
* Integrated with payment transactions

---

## 2. Product Catalog

Handles product classification and item management.

### Product Categories

* Supports parent–child category hierarchy
* Enables structured browsing (e.g., Groceries → Snacks)

### Products

* Linked to a specific category
* Stores product name and identifiers
* Used across inventory and order items

---

## 3. Warehouses & Inventory

Manages store-level fulfillment operations.

### Warehouse (Store)

* Represents fulfillment centers
* Includes pincode and operating status
* Linked to orders and inventory

### Store Inventory

* Maps products to warehouses
* Tracks stock quantity and selling price
* Enables store-specific availability

---

## 4. Orders & Order Items

Core transaction workflow of the system.

### Orders

* Connects customers, stores, delivery partners, and addresses
* Stores total order amount and current order status
* Acts as the parent entity for payments and order items

### Order Items

* Line-level breakup of products within an order
* Tracks quantity and unit price at purchase time
* Enables accurate billing and reporting

---

## 5. Delivery Partners

Handles last-mile delivery workforce.

### Delivery Partners

* Stores rider details such as name, phone number, and vehicle type
* Each order can be assigned to a delivery partner

This reflects basic logistics assignment in quick commerce systems.

---

## 6. Payments & Transactions

Manages financial flow of orders.

### Payments

* Stores payment method (UPI, Card, Wallet, etc.)
* Tracks transaction status and timestamps
* Links orders with customer wallets when applicable

This module ensures transparency and traceability of financial operations.

---

## Relationships & Integrity

* One customer → many addresses
* One customer → one wallet
* One order → many order items
* One product → many order items
* One warehouse → many orders
* One order → one payment
* One delivery partner → many orders

All relationships are enforced using **primary keys, foreign keys, and indexed attributes**, as depicted in the ERR diagram.

---

## Learning Outcomes

This project demonstrates:

* ER to Relational Mapping
* Proper use of primary and foreign keys
* Normalized schema design (up to 3NF)
* Realistic modeling of commerce workflows
* Use of ENUMs, timestamps, and indexing
* Practical DBMS design for academic evaluation

---

## Conclusion

The **QComm Lite Database System** provides a **well-structured, ERR-driven DBMS design** that balances realism with academic clarity.
It serves as a strong foundation for understanding how quick-commerce platforms manage customers, products, inventory, orders, deliveries, and payments within a relational database framework.


