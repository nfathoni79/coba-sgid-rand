<template>
  <div class="p-4">
    <button @click="printOneOrder()" class="px-4 py-2 bg-green-400">One Order</button>
    <button @click="printDayOrder()" class="ml-4 px-4 py-2 bg-green-400">Update Day Order</button>
    <button @click="printMonthOrder()" class="ml-4 px-4 py-2 bg-green-400">Update Month Order</button>
    <button @click="getRandomFullname()" class="ml-4 px-4 py-2 bg-green-400">Random Name</button>
    <button @click="randomReference()" class="ml-4 px-4 py-2 bg-green-400">Random Reference</button>

    <div class="prose" v-html="oneOrder"></div>

    <div class="mt-8">
      <p class="font-semibold">Total One Day: {{ dayOrder }}</p>
      <p class="font-semibold">Total One Month: {{ monthOrder }}</p>
    </div>

    <div class="mt-8 flex space-x-2">
      <div>
        <label for="month" class="block">Month</label>
        <select id="month" v-model="month"
          class="rounded-md border border-gray-300 bg-white py-2 pl-3 pr-8 shadow-sm
          focus:border-indigo-500 focus:outline-none focus:ring-indigo-500">
          <!-- <option value="09">Sep</option>
          <option value="10">Oct</option> -->
          <option value="11">Nov</option>
          <option value="12">Dec</option>
          <option value="01">Jan</option>
          <option value="02">Feb</option>
        </select>
      </div>

      <div>
        <label for="day" class="block">Day</label>
        <select id="day" v-model="day"
          class="rounded-md border border-gray-300 bg-white py-2 pl-3 pr-8 shadow-sm
          focus:border-indigo-500 focus:outline-none focus:ring-indigo-500">
          <option v-for="index in 31" :key="index" :value="padZero(index, 2)">{{ padZero(index, 2) }}</option>
        </select>
      </div>

      <div>
        <label for="time" class="block">Time</label>
        <select id="time" v-model="timeNo"
          class="rounded-md border border-gray-300 bg-white py-2 pl-3 pr-8 shadow-sm
          focus:border-indigo-500 focus:outline-none focus:ring-indigo-500">
          <option v-for="index in 15" :key="index" :value="index">{{ index }}</option>
        </select>
      </div>

      <div>
        <label for="invoice" class="block">Invoice</label>
        <input id="invoice" type="number" v-model="invoiceNo"
          class="rounded-md border border-gray-300 bg-white py-2 px-3 shadow-sm
          focus:border-indigo-500 focus:outline-none focus:ring-indigo-500" />
      </div>
    </div>

    <button @click="generateVariables()" class="mt-4 px-4 py-2 bg-green-400">Generate Variables</button>
    <button @click="generateQueries()" class="mt-4 ml-4 px-4 py-2 bg-green-400">Generate Queries</button>
    <button @click="generateProcedureCall()" class="mt-4 ml-4 px-4 py-2 bg-green-400">Generate Procedure Call</button>
    <button @click="generateProcedureQueries()" class="mt-4 ml-4 px-4 py-2 bg-green-400">Generate Procedure Queries</button>

    <pre>{{ variables }}</pre>
    <textarea id="procedure" rows="6" v-model="procedure"
     class="mt-4 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"></textarea>
    <textarea id="queries" rows="16" v-model="queries"
     class="mt-4 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"></textarea>
  </div>
</template>

<script>
import times from './data/times'
import names from './data/names'
import cities from './data/cities'
import products from './data/products'
import outlets from './data/outlets'

export default {
  data() {
    return {
      times,
      products,
      names,
      cities,
      outlets,
      aaaaaaaaaaaaaaaaaa: '',
      month: '02',
      day: '03',
      maxDay: '28',
      timeNo: 1,
      maxTimeNo: 9,
      invoiceNo: 2016,
      bbbbbbbbbbbbbbbbbb: '',
      oneOrder: '',
      dayOrder: '-',
      monthOrder: '-',
      variables: '',
      procedure: '',
      queries: '',
    }
  },
  computed: {

  },
  methods: {
    generateVariables() {
      let vars = ''

      const time = this.times[this.timeNo - 1]

      let year = '2022'
      if (this.month != '11' && this.month != '12') year = '2023'
      const date = `${year}-${this.month}-${this.day} ${time}`

      const gender = this.randomInt(1, 2)
      const firstName = this.randomName()
      const lastName = this.randomName()
      const email = firstName.toLowerCase() + '.' + lastName.toLowerCase() + '@gmail.com'
      const phone = this.randomPhone()
      const address = 'Jakarta'
      const city = this.randomCity()

      let products = [...this.products]
      const product1 = this.randomProduct(products)
      const product2 = this.randomProduct(products)
      const quantity1 = this.randomQuantity()
      const quantity2 = this.randomQuantity()
      const totalProducts = product1.price * quantity1 + product2.price * quantity2
      const distance = this.randomDistance()
      const shippingCost = this.calculateOngkir(distance)
      const totalPrice = totalProducts + shippingCost

      const outlet = this.randomOutlet()
      const latitude = this.randomLat()
      const longitude = this.randomLon()
      const reference = this.randomReference()
      const invoiceNumber = this.invoiceNo
      const deliveryNumber = invoiceNumber - 1

      vars += 'date: ' + date
      vars += '\ngender: ' + gender
      vars += '\nfirstName: ' + firstName
      vars += '\nlastName: ' + lastName
      vars += '\nemail: ' + email
      vars += '\nphone: ' + phone
      vars += '\naddress: ' + address
      vars += '\ncity: ' + city
      vars += '\nproduct1: ' + product1.name + ': ' + product1.price
      vars += '\nproduct2: ' + product2.name + ': ' + product1.price
      vars += '\nquantity1: ' + quantity1
      vars += '\nquantity2: ' + quantity2
      vars += '\ntotalProducts: ' + totalProducts
      vars += '\ndistance: ' + distance
      vars += '\nshippingCost: ' + shippingCost
      vars += '\ntotalPrice: ' + totalPrice
      vars += '\noutlet: ' + outlet
      vars += '\nlatitude: ' + latitude
      vars += '\nlongitude: ' + longitude
      vars += '\nreference: ' + reference
      vars += '\ninvoiceNumber: ' + invoiceNumber
      vars += '\ndeliveryNumber: ' + deliveryNumber

      this.invoiceNo++

      this.variables = vars
    },
    generateQueries() {
      let q = ''

      const time = this.times[this.timeNo - 1]

      let year = '2022'
      if (this.month != '11' && this.month != '12') year = '2023'
      const date = `${year}-${this.month}-${this.day} ${time}`

      const gender = this.randomInt(1, 2)
      const firstName = this.randomName()
      const lastName = this.randomName()
      const email = firstName.toLowerCase() + '.' + lastName.toLowerCase() + '@gmail.com'
      const phone = this.randomPhone()
      const address = 'Jakarta'
      const city = this.randomCity()

      let products = [...this.products]
      const product1 = this.randomProduct(products)
      const product2 = this.randomProduct(products)
      const quantity1 = this.randomQuantity()
      const quantity2 = this.randomQuantity()
      const totalProducts = product1.price * quantity1 + product2.price * quantity2
      const distance = this.randomDistance()
      const shippingCost = this.calculateOngkir(distance)
      const totalPrice = totalProducts + shippingCost

      const outlet = this.randomOutlet()
      const latitude = this.randomLat()
      const longitude = this.randomLon()
      const reference = this.randomReference()
      const invoiceNumber = this.invoiceNo
      const deliveryNumber = invoiceNumber - 1

      q += `SET sql_mode = '';\n`
      q += `START TRANSACTION;\n`

      q += `INSERT INTO ps_customer
        (id_shop_group, id_shop, id_gender, id_default_group, id_lang, id_risk,
        company, siret, ape, firstname, lastname, email, passwd, last_passwd_gen,
        birthday, newsletter, ip_registration_newsletter, newsletter_date_add,
        optin, website, outstanding_allow_amount, show_public_prices,
        max_payment_days, secure_key, note, active, is_guest, deleted,
        date_add, date_upd, reset_password_token, reset_password_validity)
        VALUES
        (1, 1, ${gender}, 2, 1, 0, '', '', '', '${firstName}', '${lastName}',
        ${email}, '$2y$10$UH6Jm9fzHvh/Js4dHZvdZeRlSfSh6DdeSh4E/AWZ/MoV7et5itWOy',
        '${date}', '0000-00-00', 0, '', '0000-00-00 00:00:00', 0, '', 0.000000, 0,
        0, '9b7241a664b8d3aa5c570576dc751878', '', 1, 1, 0, '${date}', '${date}', '',
        '0000-00-00 00:00:00');\n`

      q += `SET @idcustomer = LAST_INSERT_ID();\n`

      q += `INSERT INTO ps_address
        (id_country, id_state, id_customer, id_manufacturer, id_supplier,
        id_warehouse, alias, company, lastname, firstname, address1, address2,
        postcode, city, other, phone, phone_mobile, vat_number, dni, date_add,
        date_upd, active, deleted)
        VALUES
        (111, 241, @idcustomer, 0, 0, 0, 'Alamat Saya', '', '${lastName}',
        '${firstName}', '${address}', '', '', '${city}', '', '${phone}', '', '',
        '', '${date}', '${date}', 1, 0);\n`

      this.queries = q
    },
    generateProcedureCall() {
      const time = this.times[this.timeNo - 1]

      let year = '2022'
      if (this.month != '11' && this.month != '12') year = '2023'
      const date = `${year}-${this.month}-${this.day} ${time}`

      const gender = this.randomInt(1, 2)
      const firstName = this.randomName()
      const lastName = this.randomName()
      const email = firstName.toLowerCase() + '.' + lastName.toLowerCase() + '@gmail.com'
      const phone = this.randomPhone()
      const address = 'Jakarta'
      const city = this.randomCity()

      let products = [...this.products]
      const product1 = this.randomProduct(products)
      const product2 = this.randomProduct(products)
      const quantity1 = this.randomQuantity()
      const quantity2 = this.randomQuantity()
      const totalProducts = product1.price * quantity1 + product2.price * quantity2
      const distance = this.randomDistance()
      const shippingCost = this.calculateOngkir(distance)
      const totalPrice = totalProducts + shippingCost

      const outlet = this.randomOutlet()
      const latitude = this.randomLat()
      const longitude = this.randomLon()
      const reference = this.randomReference()
      const invoiceNumber = this.invoiceNo
      const deliveryNumber = invoiceNumber - 1

      this.procedure = `CALL sgid_rand('${date}', ${gender}, '${firstName}',
        '${lastName}', '${email}', '${phone}', '${address}', '${city}',
        ${product1.id}, ${product2.id}, '${product1.name}', '${product2.name}',
        ${product1.price}, ${product2.price}, ${quantity1}, ${quantity2},
        ${totalProducts}, ${distance}, ${shippingCost}, ${totalPrice},
        '${outlet}', ${latitude}, ${longitude}, '${reference}',
        ${invoiceNumber}, ${deliveryNumber});`

      this.invoiceNo++

      if (this.timeNo < this.maxTimeNo) {
        this.timeNo++
      } else if (this.day != this.maxDay) {
        this.timeNo = 1
        let intDay = parseInt(this.day)
        intDay++
        this.day = this.padZero(intDay, 2)
      } else {
        this.day = '01'
      }
    },
    generateProcedureQueries() {
      let q = ''

      q += `INSERT INTO ps_customer
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
        '0000-00-00 00:00:00');\n`

      q += `SET @customer_id = LAST_INSERT_ID();\n`

      q += `INSERT INTO ps_address
        (id_country, id_state, id_customer, id_manufacturer, id_supplier,
        id_warehouse, alias, company, lastname, firstname, address1, address2,
        postcode, city, other, phone, phone_mobile, vat_number, dni, date_add,
        date_upd, active, deleted)
        VALUES
        (111, 241, @customer_id, 0, 0, 0, 'Alamat Saya', '', last_name,
        first_name, address, '', '', city, '', phone, '', '',
        '', date, date, 1, 0);\n`

      q += `SET @address_id = LAST_INSERT_ID();\n`

      q += `INSERT INTO ps_guest
        (id_operating_system, id_web_browser, id_customer, javascript,
        screen_resolution_x, screen_resolution_y, screen_color, sun_java,
        adobe_flash, adobe_director, apple_quicktime, real_player,
        windows_media, accept_language, mobile_theme)
        VALUES
        (6, 11, @customer_id, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'en', 0);\n`

      q += `SET @guest_id = LAST_INSERT_ID();\n`

      q += `INSERT INTO ps_cart
        (id_shop_group, id_shop, id_carrier, delivery_option, id_lang,
        id_address_delivery, id_address_invoice, id_currency, id_customer,
        id_guest, secure_key, recyclable, gift, gift_message, mobile_theme,
        allow_seperated_package, date_add, date_upd, checkout_session_data)
        VALUES
        (1, 1, 114, CONCAT('{"', @address_id, '":"114,"}'), 1, @address_id, @address_id,
        1, @customer_id, @guest_id, '9b7241a664b8d3aa5c570576dc751878', 0, 0,
        '', 0, 0, date, date, NULL);\n`

      q += `SET @cart_id = LAST_INSERT_ID();\n`

      q += `INSERT INTO ps_cart_product
        (id_cart, id_product, id_address_delivery, id_shop, id_product_attribute,
        id_customization, quantity, date_add)
        VALUES
        (@cart_id, product_id_1, @address_id, 1, 0, 0, quantity_1, date),
        (@cart_id, product_id_2, @address_id, 1, 0, 0, quantity_2, date);\n`

      q += `INSERT INTO ps_mail
        (recipient, template, subject, id_lang, date_add)
        VALUES
        (email, 'bankwire', '[Sahabat Gemarikan.id] Menunggu pembayaran via transfer bank', 1, date),
        (email, 'order_conf', '[Sahabat Gemarikan.id] Konfirmasi Pembelian', 1, date),
        (email, 'preparation', '[Sahabat Gemarikan.id] Barang tengah disiapkan', 1, date);\n`

      q += `INSERT INTO ps_myshipping_cart_position
        (id_cart, outlet, distance, latitude, longitude)
        VALUES
        (@cart_id, outlet, distance, latitude, longitude);\n`

      q += `INSERT INTO ps_myshipping_cart_shipping_cost
        (id_cart, shipping_cost)
        VALUES
        (@cart_id, shipping_cost);\n`

      q += `INSERT INTO ps_orders
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
        invoice_number, delivery_number, date, date, 1, date, date);\n`

      q += `SET @order_id = LAST_INSERT_ID();\n`

      q += `INSERT INTO ps_order_invoice
        (id_order, number, delivery_number, delivery_date, total_discount_tax_excl,
        total_discount_tax_incl, total_paid_tax_excl, total_paid_tax_incl,
        total_products, total_products_wt, total_shipping_tax_excl,
        total_shipping_tax_incl, shipping_tax_computation_method,
        total_wrapping_tax_excl, total_wrapping_tax_incl, shop_address, note, date_add)
        VALUES
        (@order_id, invoice_number, delivery_number, date, 0.000000, 0.000000,
        total_price, total_price, total_products, total_products, shipping_cost, shipping_cost,
        '', 0.000000, 0.000000, 'Sahabat Gemarikan.id<br />Jl. Puri Marina Raya No. 5, RT 09 RW 11,<br />Ancol Barat, Pademangan, Jakarta Utara, DKI Jakarta<br />14430 Jakarta Utara<br />Indonesia<br />+62 8111 496 887',
        '', date);\n`

      q += `SET @order_invoice_id = LAST_INSERT_ID();\n`

      q += `INSERT INTO ps_order_carrier
        (id_order, id_carrier, id_order_invoice, weight, shipping_cost_tax_excl,
        shipping_cost_tax_incl, tracking_number, date_add)
        VALUES
        (@order_id, 114, @order_invoice_id, 0.000000, shipping_cost, shipping_cost,
        '', date);\n`

      q += `INSERT INTO ps_order_detail
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
        0.000000, 0.000000, 0.000000, product_price_2, 0.000000, 0.000000, 0.000000);\n`

      q += `INSERT INTO ps_order_history
        (id_employee, id_order, id_order_state, date_add)
        VALUES
        (0, @order_id, 10, date),
        (1, @order_id, 3, date),
        (1, @order_id, 5, date);\n`

      q += `INSERT INTO ps_order_payment
        (order_reference, id_currency, amount, payment_method, conversion_rate,
        transaction_id, card_number, card_brand, card_expiration, card_holder, date_add)
        VALUES
        (reference, 1, total_price, 'Transfer', 1.000000, '', '', '', '', '', date);\n`

      q += `SET @order_payment_id = LAST_INSERT_ID();\n`

      q += `INSERT INTO ps_order_invoice_payment
        (id_order_invoice, id_order_payment, id_order)
        VALUES
        (@order_invoice_id, @order_payment_id, @order_id);\n`

      q += `INSERT INTO ps_psgdpr_log
        (id_customer, id_guest, client_name, id_module, request_type, date_add, date_upd)
        VALUES
        (@customer_id, 0, CONCAT(first_name, ' ', last_name), 0, 1, date, date);\n`

      this.queries = q
    },
    padZero(number, digit) {
      return String(number).padStart(digit, '0')
    },
    randomInt(min, max) {
      // console.log(Math.floor(Math.random() * (max - min + 1)) + min)
      return Math.floor(Math.random() * (max - min + 1)) + min
    },
    randomFloat(min, max) {
      // console.log(Math.random() * (max - min) + min)
      return Math.random() * (max - min) + min
    },
    randomName() {
      // console.log(this.names[this.randomInt(0, this.names.length - 1)])
      return this.names[this.randomInt(0, this.names.length - 1)]
    },
    randomPhone() {
      let phone = '08888'
      let random = String(this.randomInt(0, 999999)).padStart(6, '0')

      console.log(phone + random)
      return phone + random
    },
    randomCity() {
      // console.log(this.cities[this.randomInt(0, this.cities.length - 1)])
      return this.cities[this.randomInt(0, this.cities.length - 1)]
    },
    randomProduct(products) {
      const index = this.randomInt(0, products.length - 1)
      const selectedProduct = products[index]
      products.splice(index, 1)

      console.log(selectedProduct.name)
      return selectedProduct
    },
    randomQuantity() {
      // Original 1-4
      console.log(this.randomInt(1, 3))
      return this.randomInt(1, 3)
    },
    randomOutlet() {
      console.log(this.outlets[this.randomInt(0, this.outlets.length - 1)])
      return this.outlets[this.randomInt(0, this.outlets.length - 1)]
    },
    randomLat() {
      console.log(this.randomFloat(-6.5, -6.1).toFixed(6))
      return this.randomFloat(-6.5, -6.1).toFixed(6)
    },
    randomLon() {
      console.log(this.randomFloat(106.6, 107.3).toFixed(6))
      return this.randomFloat(106.6, 107.3).toFixed(6)
    },
    randomDistance() {
      return this.randomFloat(0.8, 19.3).toFixed(6)
    },
    calculateOngkir(distance) {
      const minCost = 13000
      const perKmUnder10 = 2815
      const perKmAbove10 = 3000
      let total = 0

      if (distance <= 1) {
        total = 0
      } else if (distance > 1 && distance <= 10) {
        total = Math.round((minCost + (distance - 1) * perKmUnder10) / 1000) * 1000
      } else if (distance > 10) {
        total = Math.round((minCost + 9 * (perKmUnder10) + (distance - 10) * perKmAbove10) / 1000) * 1000
      }

      console.log(total)
      return total
    },
    randomReference() {
      const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      let reference = ''

      for (let i = 0; i < 9; i++) {
        reference += characters.charAt(this.randomInt(0, characters.length - 1))
      }

      console.log(reference)
      return reference
    },
    getRandomFullname() {
      const firstNameIndex = Math.floor(Math.random() * (this.names.length - 1))
      const lastNameIndex = Math.floor(Math.random() * (this.names.length - 1))

      console.log(this.names[firstNameIndex] + ' ' + this.names[lastNameIndex])
      console.log(this.names[firstNameIndex].toLowerCase() + '.' + this.names[lastNameIndex].toLowerCase() + '@gmail.com')
    },
    calculateOneOrder() {
      let products = [...this.products]
      const product1 = this.randomProduct(products)
      const product2 = this.randomProduct(products)
      const quantity1 = this.randomQuantity()
      const quantity2 = this.randomQuantity()

      return product1.price * quantity1 + product2.price * quantity2

      // let fish = [...this.fish]
      // const fish1 = this.getRandomFish(fish)
      // const fish2 = this.getRandomFish(fish)
      // const quantity1 = this.getRandomQuantity()
      // const quantity2 = this.getRandomQuantity()

      // return fish1.price * quantity1 + fish2.price * quantity2
    },
    calculateDayOrder() {
      let total = 0

      // max 12 or 14
      for (let i = 0; i < 9; i++) {
        total += this.calculateOneOrder()
      }

      return total
    },
    calculateMonthOrder() {
      let total = 0

      for (let i = 0; i < 30; i++) {
        total += this.calculateDayOrder()
      }

      return total
    },
    printDayOrder() {
      this.dayOrder = this.calculateDayOrder().toLocaleString()
    },
    printMonthOrder() {
      this.monthOrder = this.calculateMonthOrder().toLocaleString()
    },
    printOneOrder() {
      let products = [...this.products]
      const product1 = this.randomProduct(products)
      const product2 = this.randomProduct(products)
      const quantity1 = this.randomQuantity()
      const quantity2 = this.randomQuantity()

      const total = product1.price * quantity1 + product2.price * quantity2

      let text = '<hr><p>'
      text += `${product1.name}: ${product1.price} x ${quantity1} = ${product1.price * quantity1}<br>`
      text += `${product2.name}: ${product2.price} x ${quantity2} = ${product2.price * quantity2}<br>`
      text += `Total = ${total.toLocaleString()}</p>`

      this.oneOrder = text

      // let fish = [...this.fish]
      // const fish1 = this.getRandomFish(fish)
      // const fish2 = this.getRandomFish(fish)
      // const quantity1 = this.getRandomQuantity()
      // const quantity2 = this.getRandomQuantity()

      // const total = fish1.price * quantity1 + fish2.price * quantity2

      // let text = '<hr><p>'
      // text += `${fish1.name}: ${fish1.price} x ${quantity1} = ${fish1.price * quantity1}<br>`
      // text += `${fish2.name}: ${fish2.price} x ${quantity2} = ${fish2.price * quantity2}<br>`
      // text += `Total = ${total.toLocaleString()}</p>`

      // this.oneOrder = text
    },
    main() {
      let fish = [...this.fish]
      const fish1 = this.getRandomFish(fish)
      const fish2 = this.getRandomFish(fish)
      const fish3 = this.getRandomFish(fish)

      console.log('--------')
      console.log('ori fish length:', this.fish.length)
      console.log('fish length:', fish.length)
      console.log(`${fish1.name}: ${fish1.price}`)
      console.log(`${fish2.name}: ${fish2.price}`)
      console.log(`${fish3.name}: ${fish3.price}`)
    },
  }
}
</script>
