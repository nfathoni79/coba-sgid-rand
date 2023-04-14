BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;  -- rollback any error in the transaction
    RESIGNAL;  -- raise again the sql exception to the caller
  END;

  SET sql_mode = '';

  START TRANSACTION;

  INSERT INTO ps_customer
    (id_shop_group, id_shop, id_gender, id_default_group, id_lang, id_risk,
    company, siret, ape, firstname, lastname, email, passwd, last_passwd_gen,
    birthday, newsletter, ip_registration_newsletter, newsletter_date_add,
    optin, website, outstanding_allow_amount, show_public_prices,
    max_payment_days, secure_key, note, active, is_guest, deleted,
    date_add, date_upd, reset_password_token, reset_password_validity)
    VALUES
    (1, 1, gender, 2, 1, 0, '', '', '', first_name, last_name,
    email, '$2y$10$UH6Jm9fzHvh/Js4dHZvdZeRlSfSh6DdeSh4E/AWZ/MoV7et5itWOy',
    date, '0000-00-00', 0, '', '0000-00-00 00:00:00', 0, '', 0.000000, 0,
    0, '9b7241a664b8d3aa5c570576dc751878', '', 1, 1, 0, date, date, '',
    '0000-00-00 00:00:00');

  SET @customer_id = LAST_INSERT_ID();

  INSERT INTO ps_address
    (id_country, id_state, id_customer, id_manufacturer, id_supplier,
    id_warehouse, alias, company, lastname, firstname, address1, address2,
    postcode, city, other, phone, phone_mobile, vat_number, dni, date_add,
    date_upd, active, deleted)
    VALUES
    (111, 241, @customer_id, 0, 0, 0, 'Alamat Saya', '', last_name,
    first_name, address, '', '', city, '', phone, '', '',
    '', date, date, 1, 0);

  SET @address_id = LAST_INSERT_ID();

  INSERT INTO ps_guest
    (id_operating_system, id_web_browser, id_customer, javascript,
    screen_resolution_x, screen_resolution_y, screen_color, sun_java,
    adobe_flash, adobe_director, apple_quicktime, real_player,
    windows_media, accept_language, mobile_theme)
    VALUES
    (6, 11, @customer_id, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'en', 0);

  SET @guest_id = LAST_INSERT_ID();

  INSERT INTO ps_cart
    (id_shop_group, id_shop, id_carrier, delivery_option, id_lang,
    id_address_delivery, id_address_invoice, id_currency, id_customer,
    id_guest, secure_key, recyclable, gift, gift_message, mobile_theme,
    allow_seperated_package, date_add, date_upd, checkout_session_data)
    VALUES
    (1, 1, 114, CONCAT('{"', @address_id, '":"114,"}'), 1, @address_id, @address_id,
    1, @customer_id, @guest_id, '9b7241a664b8d3aa5c570576dc751878', 0, 0,
    '', 0, 0, date, date, NULL);

  SET @cart_id = LAST_INSERT_ID();

  INSERT INTO ps_cart_product
    (id_cart, id_product, id_address_delivery, id_shop, id_product_attribute,
    id_customization, quantity, date_add)
    VALUES
    (@cart_id, product_id_1, @address_id, 1, 0, 0, quantity_1, date),
    (@cart_id, product_id_2, @address_id, 1, 0, 0, quantity_2, date);

  INSERT INTO ps_mail
    (recipient, template, subject, id_lang, date_add)
    VALUES
    (email, 'bankwire', '[Sahabat Gemarikan.id] Menunggu pembayaran via transfer bank', 1, date),
    (email, 'order_conf', '[Sahabat Gemarikan.id] Konfirmasi Pembelian', 1, date),
    (email, 'preparation', '[Sahabat Gemarikan.id] Barang tengah disiapkan', 1, date);

  INSERT INTO ps_myshipping_cart_position
    (id_cart, outlet, distance, latitude, longitude)
    VALUES
    (@cart_id, outlet, distance, latitude, longitude);

  INSERT INTO ps_myshipping_cart_shipping_cost
    (id_cart, shipping_cost)
    VALUES
    (@cart_id, shipping_cost);

  INSERT INTO ps_orders
    (reference, id_shop_group, id_shop, id_carrier, id_lang, id_customer,
    id_cart, id_currency, id_address_delivery, id_address_invoice,
    current_state, secure_key, payment, conversion_rate, module, recyclable,
    gift, gift_message, mobile_theme, shipping_number, total_discounts,
    total_discounts_tax_incl, total_discounts_tax_excl, total_paid,
    total_paid_tax_incl, total_paid_tax_excl, total_paid_real, total_products,
    total_products_wt, total_shipping, total_shipping_tax_incl,
    total_shipping_tax_excl, carrier_tax_rate, total_wrapping,
    total_wrapping_tax_incl, total_wrapping_tax_excl, round_mode, round_type,
    invoice_number, delivery_number, invoice_date, delivery_date, valid,
    date_add, date_upd)
    VALUES
    (reference, 1, 1, 114, 1, @customer_id, @cart_id, 1, @address_id, @address_id,
    5, '9b7241a664b8d3aa5c570576dc751878', 'Transfer', 1.000000, 'ps_wirepayment',
    0, 0, '', 0, '', 0.000000, 0.000000, 0.000000, total_price, total_price,
    total_price, total_price, total_products, total_products, shipping_cost,
    shipping_cost, shipping_cost, 0.000, 0.000000, 0.000000, 0.000000, 2, 2,
    invoice_number, delivery_number, date, date, 1, date, date);

  SET @order_id = LAST_INSERT_ID();

  INSERT INTO ps_order_invoice
    (id_order, number, delivery_number, delivery_date, total_discount_tax_excl,
    total_discount_tax_incl, total_paid_tax_excl, total_paid_tax_incl,
    total_products, total_products_wt, total_shipping_tax_excl,
    total_shipping_tax_incl, shipping_tax_computation_method,
    total_wrapping_tax_excl, total_wrapping_tax_incl, shop_address, note, date_add)
    VALUES
    (@order_id, invoice_number, delivery_number, date, 0.000000, 0.000000,
    total_price, total_price, total_products, total_products, shipping_cost, shipping_cost,
    '', 0.000000, 0.000000, 'Sahabat Gemarikan.id<br />Jl. Puri Marina Raya No. 5, RT 09 RW 11,<br />Ancol Barat, Pademangan, Jakarta Utara, DKI Jakarta<br />14430 Jakarta Utara<br />Indonesia<br />+62 8111 496 887',
    '', date);

  SET @order_invoice_id = LAST_INSERT_ID();

  INSERT INTO ps_order_carrier
    (id_order, id_carrier, id_order_invoice, weight, shipping_cost_tax_excl,
    shipping_cost_tax_incl, tracking_number, date_add)
    VALUES
    (@order_id, 114, @order_invoice_id, 0.000000, shipping_cost, shipping_cost,
    '', date);

  INSERT INTO ps_order_detail
    (id_order, id_order_invoice, id_warehouse, id_shop, product_id,
    product_attribute_id, id_customization, product_name, product_quantity,
    product_quantity_in_stock, product_quantity_refunded, product_quantity_return,
    product_quantity_reinjected, product_price, reduction_percent, reduction_amount,
    reduction_amount_tax_incl, reduction_amount_tax_excl, group_reduction,
    product_quantity_discount, product_ean13, product_isbn, product_upc,
    product_mpn, product_reference, product_supplier_reference, product_weight,
    id_tax_rules_group, tax_computation_method, tax_name, tax_rate, ecotax,
    ecotax_tax_rate, discount_quantity_applied, download_hash, download_nb,
    download_deadline, total_price_tax_incl, total_price_tax_excl, unit_price_tax_incl,
    unit_price_tax_excl, total_shipping_price_tax_incl, total_shipping_price_tax_excl,
    purchase_supplier_price, original_product_price, original_wholesale_price,
    total_refunded_tax_excl, total_refunded_tax_incl)
    VALUES
    (@order_id, @order_invoice_id, 0, 1, product_id_1, 0, 0, product_name_1,
    quantity_1, quantity_1, 0, 0, 0, product_price_1, 0.00, 0.000000, 0.000000, 0.000000,
    0.00, 0.000000, '', '', '', '', '', '', 0.000000, 0, 0, '', 0.000, 0.000000,
    0.000, 0, '', 0, '0000-00-00 00:00:00', product_price_1 * quantity_1,
    product_price_1 * quantity_1, product_price_1, product_price_1,
    0.000000, 0.000000, 0.000000, product_price_1, 0.000000, 0.000000, 0.000000),
    (@order_id, @order_invoice_id, 0, 1, product_id_2, 0, 0, product_name_2,
    quantity_2, quantity_2, 0, 0, 0, product_price_2, 0.00, 0.000000, 0.000000, 0.000000,
    0.00, 0.000000, '', '', '', '', '', '', 0.000000, 0, 0, '', 0.000, 0.000000,
    0.000, 0, '', 0, '0000-00-00 00:00:00', product_price_2 * quantity_2,
    product_price_2 * quantity_2, product_price_2, product_price_2,
    0.000000, 0.000000, 0.000000, product_price_2, 0.000000, 0.000000, 0.000000);

  INSERT INTO ps_order_history
    (id_employee, id_order, id_order_state, date_add)
    VALUES
    (0, @order_id, 10, date),
    (1, @order_id, 3, date),
    (1, @order_id, 5, date);

  INSERT INTO ps_order_payment
    (order_reference, id_currency, amount, payment_method, conversion_rate,
    transaction_id, card_number, card_brand, card_expiration, card_holder, date_add)
    VALUES
    (reference, 1, total_price, 'Transfer', 1.000000, '', '', '', '', '', date);

  SET @order_payment_id = LAST_INSERT_ID();

  INSERT INTO ps_order_invoice_payment
    (id_order_invoice, id_order_payment, id_order)
    VALUES
    (@order_invoice_id, @order_payment_id, @order_id);

  INSERT INTO ps_psgdpr_log
    (id_customer, id_guest, client_name, id_module, request_type, date_add, date_upd)
    VALUES
    (@customer_id, 0, CONCAT(first_name, ' ', last_name), 0, 1, date, date);

  COMMIT; -- this will not be executed
END
