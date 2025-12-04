import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AddProductView'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(height: 5),

              // Product name
              TextFormField(
                controller: controller.productNameController,
                decoration: InputDecoration(
                  label: const Text('Nama produk'),
                  // hintText: 'contoh@email.com',
                  helperText: 'Masukan nama produk',
                  // prefixIcon: const Icon(Icons.store_rounded),
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return 'Nama produk tidak boleh kosong';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  // Product weight
                  Expanded(
                    child: TextFormField(
                      controller: controller.productWeightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: const Text('Berat produk'),
                        suffixText: 'gram',
                        // hintText: 'contoh@email.com',
                        helperText: 'Masukan berat produk',
                        // prefixIcon: const Icon(Icons.store_rounded),
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Berat produk tidak boleh kosong';
                        } else if (int.tryParse(value)! <= 0) {
                          return 'Berat produk tidak boleh dibawah nol!';
                        }

                        return null;
                      },
                    ),
                  ),

                  const SizedBox(width: 15),

                  // Product initial stock
                  Expanded(
                    child: TextFormField(
                      controller: controller.productStockController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: const Text('Stok awal'),
                        // hintText: 'contoh@email.com',
                        helperText: 'Masukan stok awal produk',
                        // prefixIcon: const Icon(Icons.store_rounded),
                        border: OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Stok produk tidak boleh kosong';
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Product modal
              // TextFormField(
              //   controller: controller.productModalController,
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     label: const Text('Modal awal'),
              //     // hintText: 'contoh@email.com',
              //     // helperText: 'Masukan stok awal produk',
              //     prefixText: 'Rp. ',
              //     // prefixIcon: const Icon(Icons.store_rounded),
              //     border: OutlineInputBorder(),
              //     floatingLabelBehavior: FloatingLabelBehavior.always,
              //   ),
              //   validator: (value) {
              //     if (value!.isEmpty || value == '') {
              //       return 'Stok produk tidak boleh kosong';
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(height: 15),

              // Product price
              TextFormField(
                controller: controller.productPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('Harga produk'),
                  // hintText: 'contoh@email.com',
                  suffixText: 'Rp. ',
                  // helperText: 'Masukan stok awal produk',
                  // prefixIcon: const Icon(Icons.store_rounded),
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return 'Harga produk tidak boleh kosong';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              // Product discount
              TextFormField(
                controller: controller.productDiscountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('Stok awal'),
                  // hintText: 'contoh@email.com',
                  suffixText: 'Rp. ',
                  // helperText: 'Masukan stok awal produk',
                  // prefixIcon: const Icon(Icons.store_rounded),
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),

              const SizedBox(height: 15),

              // Product Stock keeping unit
              TextFormField(
                controller: controller.productSKUController,
                decoration: InputDecoration(
                  label: const Text('Stock Keeping Unit (opsional)'),
                  // hintText: 'contoh@email.com',
                  helperText: 'Kode unik SKU jika ingin menandai produk.',
                  // prefixIcon: const Icon(Icons.store_rounded),
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),

              const SizedBox(height: 15),

              // Product minimal order
              TextFormField(
                controller: controller.productMinOrderController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('Minimal order'),
                  // hintText: 'contoh@email.com',
                  helperText: 'Masukan stok awal produk',
                  // prefixIcon: const Icon(Icons.store_rounded),
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return 'Stok produk tidak boleh kosong';
                  } else if (int.tryParse(value)! <= 0) {
                    return 'Minimal order tidak boleh sama dengan / kurang dari 0';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              // Product Cuplikan
              // TextFormField(
              //   controller: controller.productNameController,
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     label: const Text('Stok awal'),
              //     // hintText: 'contoh@email.com',
              //     helperText: 'Masukan stok awal produk',
              //     // prefixIcon: const Icon(Icons.store_rounded),
              //     border: OutlineInputBorder(),
              //     floatingLabelBehavior: FloatingLabelBehavior.always,
              //   ),
              //   validator: (value) {
              //     if (value!.isEmpty || value == '') {
              //       return 'Stok produk tidak boleh kosong';
              //     }

              //     return null;
              //   },
              // ),
              const SizedBox(height: 15),

              // Product description
              TextFormField(
                controller: controller.productNameController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('Stok awal'),
                  // hintText: 'contoh@email.com',
                  helperText: 'Masukan stok awal produk',
                  // prefixIcon: const Icon(Icons.store_rounded),
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return 'Stok produk tidak boleh kosong';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),
              TextButton(onPressed: () {}, child: Text('Tambah produk')),
            ],
          ),
        ),
      ),
    );
  }
}
