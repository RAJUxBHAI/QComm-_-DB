# Zepto-_-DB
# Quick Commerce Database System (DBMS Project)
---

## Project Overview

This system represents a practical implementation of core DBMS principles—normalization, relational integrity, foreign key constraints, and modular schema design.

The database mirrors how real-world instant-delivery platforms (e.g., Zepto, Blinkit, Dunzo) function behind the scenes:

* Customers browse items and place orders
* The system determines availability based on warehouse inventory
* A delivery rider is assigned to fulfill the order
* Orders move through lifecycle stages until completion
* Items are billed individually with stored purchase-time prices
* Warehouses maintain stock levels across multiple categories

This backend design ensures fast lookups, consistent data integrity, and scalability for high-volume operations.

---

## Database Schema

The schema is divided into **four functional modules**, covering **7 interdependent tables**. Each module reflects a responsibility within the quick-commerce ecosystem.

---

### 1. **Customer & Rider Operations**

This module manages the two primary human-facing components: the customers who place orders and the riders who deliver them.

* **Customers:**
  Stores user identity, contact information, saved addresses, and account creation timestamp. Ensures each customer is uniquely identifiable via phone numbers, mirroring real-world login methods.

* **Delivery_Riders:**
  Maintains rider identity, contact numbers, and live availability status (*Available*, *Busy*, *Offline*).
  This enables real-time dispatching logic where orders can be assigned only to available riders.

Together, these tables power user interactions and order delivery assignment.

---

### 2. **Products & Storage**

This module defines what the platform sells and where the products are stored.

* **Products:**
  A catalog of all items available for purchase, including names, pricing, categories, and image references.
  Designed to scale with thousands of product listings.

* **Warehouses:**
  Represents geographically distributed fulfillment hubs from which orders are shipped.
  Each warehouse is assigned a physical location (pincode), enabling hyperlocal delivery routing.

This forms the foundation of the platform's inventory and product discovery capabilities.

---

### 3. **Inventory & Stock Management**

A crucial module that links products to warehouses.

* **Inventory:**
  Tracks stock availability of each product at every warehouse.
  This many-to-many relationship allows:

  * the same product to exist in multiple warehouses
  * each warehouse to stock a wide range of products
  * real-time inventory deduction and refill mechanisms

This structure ensures orders are only placed from warehouses with adequate stock and enables dynamic routing based on proximity and availability.

---

### 4. **Ordering & Transaction Flow**

This module manages the entire lifecycle of a customer order.

* **Orders:**
  Records customer identity, assigned rider, timestamps, total pricing, and order status (*Placed*, *Packing*, *Out for Delivery*, *Delivered*, *Cancelled*).
  Acts as the central transaction anchor connecting customers, riders, and order items.

* **Order_Items:**
  Represents itemized entries within each order, capturing product ID, quantity, and price at the moment of purchase.
  This ensures that historical billing remains accurate even if product prices change later.

Together, they simulate real-world e-commerce checkout, itemization, and order delivery workflows.

---

## Summary

The seven interconnected tables collectively simulate the full backend logic of a modern quick-commerce platform. The system ensures:

* Reliable customer management
* Accurate, multi-location product stock control
* Real-time coordination between warehouses and riders
* Consistent tracking of order states and financial records
* Infrastructure suitable for scaling to thousands of orders and products

This schema serves as a strong foundation for academic DBMS projects or as a starting point for a real-world microservice-oriented delivery platform.

---

## Group 15 – Member Details
* **341066 – Ramanjan Dutta**
* **341090 – Nandini Singh**
* **341077 – Mohammed Sarshad**

---
