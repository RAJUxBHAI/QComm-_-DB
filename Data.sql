USE qcomm_enterprise;

SET FOREIGN_KEY_CHECKS = 0;

-- 1. GEOGRAPHY & USERS
INSERT INTO cities (city_id, city_name, state_name) VALUES 
('CITY_01', 'Mumbai', 'Maharashtra'),
('CITY_02', 'Bangalore', 'Karnataka'),
('CITY_03', 'Delhi', 'Delhi'),
('CITY_04', 'Wasseypur', 'Jharkhand'),
('CITY_05', 'Dholakpur', 'Unknown'),
('CITY_06', 'Phulera', 'Uttar Pradesh'),
('CITY_07', 'Mahishmati', 'Ancient India');

INSERT INTO users (user_id, phone_number, full_name, email, is_prime_member) VALUES 
('USR_001', '9999911111', 'Babu Rao Apte', 'star@fish.com', TRUE),
('USR_002', '9898989898', 'Jethalal Gada', 'jetha@elec.com', TRUE),
('USR_003', '9000050000', 'Monisha Sarabhai', 'bargain@sobo.com', FALSE),
('USR_004', '9123456789', 'Kaleen Bhaiya', 'katta@mirzapur.com', TRUE),
('USR_005', '9988776655', 'Sima Taparia', 'rishta@match.com', FALSE),
('USR_006', '8880008880', 'Crime Master Gogo', 'gogo@andaz.com', FALSE),
('USR_007', '9111122222', 'Chatur Ramalingam', 'silencer@iit.edu', TRUE),
('USR_008', '9996669999', 'Kabir Singh', 'preeti@med.com', TRUE),
('USR_009', '9090909090', 'Sachiv Ji', 'sachiv@phulera.com', FALSE),
('USR_010', '9876543210', 'Binod', 'binod@yt.com', FALSE),
('USR_011', '9555544444', 'Sonam Gupta', 'sonam@notes.com', FALSE),
('USR_012', '9222233333', 'Majnu Bhai', 'painter@welcome.com', TRUE),
('USR_013', '9100010000', 'Uday Shetty', 'control@welcome.com', TRUE),
('USR_014', '9900990099', 'Anjali Sharma', 'tomboy@summer.com', FALSE),
('USR_015', '9000000007', 'Don', 'don@chase.com', TRUE);

INSERT INTO user_addresses (address_id, user_id, city_id, address_line_1, pincode, address_type) VALUES 
('ADR_001', 'USR_001', 'CITY_01', 'Star Garage, Khopdi Tod Gali', '400001', 'Home'),
('ADR_002', 'USR_002', 'CITY_01', 'B-202, Gokuldham Society', '400063', 'Home'),
('ADR_003', 'USR_003', 'CITY_01', 'Rugby House, Colaba', '400005', 'Home'),
('ADR_004', 'USR_004', 'CITY_04', 'Tripathi Kothi, Mirzapur', '826001', 'Work'),
('ADR_005', 'USR_006', 'CITY_01', 'Crime Master Den', '400053', 'Other'),
('ADR_006', 'USR_007', 'CITY_03', 'Library, Top Floor', '110016', 'Work'),
('ADR_007', 'USR_008', 'CITY_03', 'Boys Hostel, Room 404', '110007', 'Home'),
('ADR_008', 'USR_009', 'CITY_06', 'Panchayat Office', '200001', 'Work'),
('ADR_009', 'USR_012', 'CITY_01', 'Welcome Shetty House', '400050', 'Home'),
('ADR_010', 'USR_015', 'CITY_02', 'Secret Hideout', '560001', 'Other');

-- 2. CATALOG
INSERT INTO categories (category_id, name) VALUES 
('CAT_001', 'Midnight Cravings'),
('CAT_002', 'Survival Essentials'),
('CAT_003', 'Pharma (Dawaa)'),
('CAT_004', 'Chai-Sutta'),
('CAT_005', 'Mummy Ki Demand');

INSERT INTO brands (brand_id, name) VALUES 
('BRD_01', 'Amul'), ('BRD_02', 'Lays'), ('BRD_03', 'Durex'), ('BRD_04', 'Dolo'), ('BRD_05', 'Maggi'),
('BRD_06', 'Old Monk'), ('BRD_07', 'Parle'), ('BRD_08', 'Haldiram'), ('BRD_09', 'Vimal'), ('BRD_10', 'Santoor');

INSERT INTO taxes (tax_id, tax_name, percentage) VALUES 
('TAX_01', 'GST 5%', 5.00), ('TAX_02', 'GST 12%', 12.00), ('TAX_03', 'GST 18%', 18.00), ('TAX_04', 'Sin Tax', 28.00);

INSERT INTO products (product_id, brand_id, category_id, name, tax_id) VALUES 
('PRD_001', 'BRD_02', 'CAT_001', 'Lays Blue', 'TAX_02'),
('PRD_002', 'BRD_05', 'CAT_002', 'Maggi Noodles', 'TAX_02'),
('PRD_003', 'BRD_04', 'CAT_003', 'Dolo 650', 'TAX_02'),
('PRD_004', 'BRD_03', 'CAT_003', 'Protection Kit', 'TAX_03'),
('PRD_005', 'BRD_01', 'CAT_005', 'Amul Taaza Milk', 'TAX_01'),
('PRD_006', 'BRD_06', 'CAT_004', 'Cough Syrup', 'TAX_04'),
('PRD_007', 'BRD_07', 'CAT_004', 'Parle-G', 'TAX_01'),
('PRD_008', 'BRD_08', 'CAT_001', 'Aloo Bhujia', 'TAX_02'),
('PRD_009', 'BRD_09', 'CAT_004', 'Vimal Elaichi', 'TAX_04'),
('PRD_010', 'BRD_10', 'CAT_005', 'Santoor Soap', 'TAX_03'),
('PRD_011', 'BRD_01', 'CAT_001', 'Amul Butter', 'TAX_02'),
('PRD_012', 'BRD_02', 'CAT_001', 'Lays Green', 'TAX_02');

INSERT INTO product_variants (variant_id, product_id, sku_code, weight_volume, mrp, selling_price) VALUES 
('VAR_001', 'PRD_001', 'SKU_LAYS_S', '30g', 10.00, 10.00),
('VAR_002', 'PRD_001', 'SKU_LAYS_L', '90g', 40.00, 35.00),
('VAR_003', 'PRD_002', 'SKU_MAG_S', 'Single', 14.00, 12.00),
('VAR_004', 'PRD_002', 'SKU_MAG_F', 'Family', 90.00, 85.00),
('VAR_005', 'PRD_003', 'SKU_DOLO', 'Strip', 30.00, 30.00),
('VAR_006', 'PRD_005', 'SKU_MILK', '500ml', 27.00, 27.00),
('VAR_007', 'PRD_006', 'SKU_MONK_Q', '180ml', 180.00, 180.00),
('VAR_008', 'PRD_006', 'SKU_MONK_F', '750ml', 750.00, 700.00),
('VAR_009', 'PRD_007', 'SKU_PARLE', 'Std', 5.00, 5.00),
('VAR_010', 'PRD_009', 'SKU_ZUBAN', 'Sachet', 10.00, 10.00),
('VAR_011', 'PRD_011', 'SKU_BUT_S', '100g', 56.00, 50.00),
('VAR_012', 'PRD_011', 'SKU_BUT_L', '500g', 275.00, 260.00);

-- 3. INVENTORY
INSERT INTO warehouses (warehouse_id, city_id, name, location_pin) VALUES 
('WH_001', 'CITY_02', 'Silk Board Hub', '560068'),
('WH_002', 'CITY_01', 'Dadar Depot', '400014'),
('WH_003', 'CITY_01', 'Andheri Hub', '400069'),
('WH_004', 'CITY_03', 'Rajiv Chowk', '110001'),
('WH_005', 'CITY_06', 'Phulera Tank', '200001');

INSERT INTO suppliers (supplier_id, name, contact_info) VALUES 
('SUP_001', 'Laxmi Chit Fund', 'Anuradha'),
('SUP_002', 'Gada Electronics', 'Nattu Kaka'),
('SUP_003', 'Kachra Seth', '150 Rupiya'),
('SUP_004', 'Heisenberg Chem', 'Walter');

INSERT INTO purchase_orders (po_id, supplier_id, warehouse_id, status) VALUES 
('PO_001', 'SUP_002', 'WH_001', 'Received'),
('PO_002', 'SUP_001', 'WH_002', 'Received'),
('PO_003', 'SUP_003', 'WH_003', 'Created'),
('PO_004', 'SUP_002', 'WH_005', 'Received');

INSERT INTO inventory_batches (batch_id, warehouse_id, variant_id, po_id, quantity_available, expiry_date, aisle_number) VALUES 
('BAT_001', 'WH_001', 'VAR_001', 'PO_001', 500, '2025-12-01', 'A1'),
('BAT_002', 'WH_001', 'VAR_002', 'PO_001', 200, '2025-11-15', 'A1'),
('BAT_003', 'WH_002', 'VAR_005', 'PO_002', 1000, '2026-01-01', 'M1'),
('BAT_004', 'WH_002', 'VAR_006', 'PO_002', 50, '2023-12-05', 'D1'),
('BAT_005', 'WH_003', 'VAR_007', 'PO_002', 100, '2028-12-31', 'L1'),
('BAT_006', 'WH_005', 'VAR_009', 'PO_004', 5000, '2024-06-01', 'P1'),
('BAT_007', 'WH_005', 'VAR_010', 'PO_004', 2000, '2025-05-05', 'V1'),
('BAT_008', 'WH_001', 'VAR_006', 'PO_001', 0, '2023-12-01', 'D1');

-- 4. RIDERS
INSERT INTO delivery_partners (rider_id, warehouse_id, full_name, vehicle_type) VALUES 
('RID_001', 'WH_001', 'Dhoom Ali', 'Bike'),
('RID_002', 'WH_001', 'Salmon Bhai', 'EV_Scooter'),
('RID_003', 'WH_002', 'Rocky Bhai', 'Bike'),
('RID_004', 'WH_002', 'Late Lateef', 'Cycle'),
('RID_005', 'WH_003', 'Flying Jatt', 'EV_Scooter'),
('RID_006', 'WH_003', 'Radhe Bhaiya', 'Bike'),
('RID_007', 'WH_004', 'Circuit', 'Bike'),
('RID_008', 'WH_005', 'Prahlad Cha', 'Cycle'),
('RID_009', 'WH_001', 'Minion 1', 'EV_Scooter'),
('RID_010', 'WH_002', 'Spidey Ind', 'Bike');

INSERT INTO shifts (shift_id, shift_name, start_time, end_time) VALUES 
('SH_01', 'Morning Rush', '06:00:00', '10:00:00'),
('SH_02', 'Lunch Peak', '12:00:00', '15:00:00'),
('SH_03', 'Evening Snac', '17:00:00', '21:00:00'),
('SH_04', 'Midnight', '22:00:00', '02:00:00');

INSERT INTO rider_shifts (rider_shift_id, rider_id, shift_id, date, login_time) VALUES 
('RS_001', 'RID_001', 'SH_01', '2023-10-25', '2023-10-25 06:05:00'),
('RS_002', 'RID_002', 'SH_01', '2023-10-25', '2023-10-25 06:10:00'),
('RS_003', 'RID_003', 'SH_02', '2023-10-25', '2023-10-25 12:00:00'),
('RS_004', 'RID_004', 'SH_02', '2023-10-25', '2023-10-25 12:30:00'),
('RS_005', 'RID_008', 'SH_03', '2023-10-25', '2023-10-25 17:00:00');

-- 5. ORDERS
INSERT INTO coupons (coupon_id, code, discount_value) VALUES 
('CPN_01', 'WELCOME50', 50.00),
('CPN_02', 'SORRY100', 100.00),
('CPN_03', 'DIWALI20', 20.00),
('CPN_04', 'NODISCOUNT', 0.00);

INSERT INTO orders (order_id, user_id, warehouse_id, rider_id, address_id, final_amount, order_status) VALUES 
('ORD_001', 'USR_001', 'WH_002', 'RID_003', 'ADR_001', 150.00, 'Delivered'),
('ORD_002', 'USR_002', 'WH_003', 'RID_005', 'ADR_002', 500.00, 'Out_For_Delivery'),
('ORD_003', 'USR_004', 'WH_004', 'RID_007', 'ADR_004', 2000.00, 'Delivered'),
('ORD_004', 'USR_008', 'WH_001', 'RID_002', 'ADR_007', 750.00, 'Cancelled'),
('ORD_005', 'USR_009', 'WH_005', 'RID_008', 'ADR_008', 20.00, 'Placed'),
('ORD_006', 'USR_012', 'WH_001', 'RID_001', 'ADR_009', 100.00, 'Delivered'),
('ORD_007', 'USR_001', 'WH_002', 'RID_003', 'ADR_001', 40.00, 'Packing'),
('ORD_008', 'USR_006', 'WH_003', 'RID_006', 'ADR_005', 30.00, 'Delivered'),
('ORD_009', 'USR_015', 'WH_001', NULL, 'ADR_010', 5000.00, 'Placed'),
('ORD_010', 'USR_003', 'WH_001', 'RID_001', 'ADR_003', 95.00, 'Delivered');

INSERT INTO order_items (order_item_id, order_id, variant_id, batch_id, quantity, price_at_time_of_order) VALUES 
('ITM_001', 'ORD_001', 'VAR_005', 'BAT_003', 5, 30.00),
('ITM_002', 'ORD_002', 'VAR_011', 'BAT_005', 2, 260.00),
('ITM_003', 'ORD_003', 'VAR_007', 'BAT_005', 4, 180.00),
('ITM_004', 'ORD_004', 'VAR_008', 'BAT_005', 1, 700.00),
('ITM_005', 'ORD_005', 'VAR_009', 'BAT_006', 4, 5.00),
('ITM_006', 'ORD_006', 'VAR_001', 'BAT_001', 10, 10.00),
('ITM_007', 'ORD_010', 'VAR_002', 'BAT_002', 1, 35.00);

-- 6. FINANCE
INSERT INTO user_wallets (wallet_id, user_id, balance) VALUES 
('WAL_001', 'USR_001', 5.00),
('WAL_002', 'USR_002', 50000.00),
('WAL_003', 'USR_004', 100000.00),
('WAL_004', 'USR_008', 0.00),
('WAL_005', 'USR_003', 150.50);

INSERT INTO wallet_transactions (transaction_id, wallet_id, amount, type, description) VALUES 
('TXN_001', 'WAL_001', 100.00, 'Debit', 'Order ORD_001'),
('TXN_002', 'WAL_002', 5000.00, 'Credit', 'Cashback'),
('TXN_003', 'WAL_004', 750.00, 'Credit', 'Refund'),
('TXN_004', 'WAL_001', 10.00, 'Debit', 'Penalty'),
('TXN_005', 'WAL_003', 2000.00, 'Debit', 'Party Supplies');

INSERT INTO support_tickets (ticket_id, user_id, order_id, category, status) VALUES 
('TKT_001', 'USR_001', 'ORD_001', 'Quality Issue', 'Open'),
('TKT_002', 'USR_003', 'ORD_010', 'Missing Item', 'Resolved'),
('TKT_003', 'USR_008', 'ORD_004', 'Delivery Delay', 'Resolved'),
('TKT_004', 'USR_002', NULL, 'Other', 'Open'),
('TKT_005', 'USR_006', NULL, 'Other', 'In_Progress');

INSERT INTO product_reviews (review_id, user_id, product_id, rating, comment) VALUES 
('REV_001', 'USR_001', 'PRD_003', 5, 'Mast hai baba'),
('REV_002', 'USR_003', 'PRD_001', 1, 'Too expensive'),
('REV_003', 'USR_008', 'PRD_006', 5, 'Meri Preeti wapas laa do'),
('REV_004', 'USR_010', 'PRD_001', 5, 'Binod'),
('REV_005', 'USR_004', 'PRD_004', 1, 'Hum karte hain prabandh');

SET FOREIGN_KEY_CHECKS = 1;