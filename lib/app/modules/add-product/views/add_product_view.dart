import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      backgroundColor: Color.fromRGBO(240, 240, 240, 1),

      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // Category Dropdown
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(16),
                      child: Obx(() {
                        return DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Kategori Produk',
                            border: OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          initialValue:
                              controller.selectedCategoryId.value.isEmpty
                              ? null
                              : controller.selectedCategoryId.value,
                          items: controller.productCategories.map((item) {
                            return DropdownMenuItem(
                              value: item['id_kategori_produk'].toString(),
                              child: Text(item['nama_kategori']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.selectedCategoryId.value = value ?? "";
                          },
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Product Name
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        controller: controller.productNameController,
                        decoration: const InputDecoration(
                          label: Text('Nama produk'),
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Nama produk tidak boleh kosong'
                            : null,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Product Weight, Minimal Order, Price, and stock
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Product Weight
                          TextFormField(
                            controller: controller.productWeightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text('Berat Produk (gram)'),
                              border: OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Berat produk tidak boleh kosong';
                              }
                              if (int.tryParse(value)! <= 0) {
                                return 'Berat tidak boleh kurang dari 0';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 7.5),

                          // Product Minimal Order
                          TextFormField(
                            controller: controller.productMinOrderController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text('Minimal order'),
                              border: OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Minimal order tidak boleh kosong';
                              }
                              if (int.tryParse(value)! <= 0) {
                                return 'Minimal order harus lebih dari 0';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 7.5),

                          // Product Price
                          TextFormField(
                            controller: controller.productPriceController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text('Harga produk'),
                              border: OutlineInputBorder(),
                              prefixText: 'Rp. ',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Harga produk tidak boleh kosong'
                                : null,
                          ),

                          const SizedBox(height: 7.5),

                          // Product Stock
                          TextFormField(
                            controller: controller.productStockController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text('Stok Produk'),
                              border: OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Stok produk tidak boleh kosong'
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // SKU (Optional)
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        controller: controller.productSKUController,
                        decoration: const InputDecoration(
                          label: Text('Stock Keeping Unit (opsional)'),
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Product Description
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        maxLines: 3,
                        controller: controller.productDescriptionController,
                        decoration: const InputDecoration(
                          label: Text('Deskripsi Produk'),
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Deskripsi tidak boleh kosong'
                            : null,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Is Product Preorder?
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DropdownButtonFormField<bool>(
                        decoration: const InputDecoration(
                          labelText: 'Pre order',
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        initialValue: controller.isPreOrder.value,
                        items: const [
                          DropdownMenuItem(value: false, child: Text('Tidak')),
                          DropdownMenuItem(value: true, child: Text('Ya')),
                        ],
                        onChanged: (value) =>
                            controller.isPreOrder.value = value ?? false,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// PRE ORDER ESTIMATION
                  Obx(() {
                    if (!controller.isPreOrder.value) {
                      return const SizedBox.shrink();
                    }
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: controller.productEstimationController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            label: Text('Estimasi Produk (hari)'),
                            border: OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Estimasi tidak boleh kosong';
                            }
                            if (int.tryParse(value)! <= 0) {
                              return 'Estimasi harus lebih dari 0';
                            }
                            return null;
                          },
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 10),

                  // Variations
                  Obx(() {
                    return Column(
                      children: List.generate(
                        controller.productVariations.length,
                        (index) => VariationItem(index: index),
                      ),
                    );
                  }),

                  const SizedBox(height: 10),

                  /// ADD VARIATION BUTTON
                  TextButton.icon(
                    onPressed: controller.addVariation,
                    icon: const Icon(Icons.add_circle, color: Colors.green),
                    label: const Text('Tambah Varian'),
                  ),

                  const SizedBox(height: 20),

                  /// SUBMIT BUTTON
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton(
                      onPressed: () => controller.addProduct(),
                      child: const Text('Tambah Produk'),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VariationItem extends GetView<AddProductController> {
  final int index;
  const VariationItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (index >= controller.productVariations.length) {
        return const SizedBox.shrink();
      }

      final varModel = controller.productVariations[index];
      final options = varModel.options;

      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ========= Variation Name + Delete Button =========
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: varModel.name,
                    decoration: const InputDecoration(
                      labelText: "Nama Variasi",
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return "Nama variasi tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => controller.removeVariation(index),
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),

            const SizedBox(height: 14),

            /// ================= Option list (Input 1, Input 2, etc) =================
            Column(
              children: List.generate(options.length, (optIndex) {
                final opt = options[optIndex];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: opt.name,
                          decoration: InputDecoration(
                            labelText: "Input ${optIndex + 1}",
                            border: const OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 120,
                        child: TextFormField(
                          controller: opt.price,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Harga",
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: options.length > 1
                            ? () => controller.removeOption(index, optIndex)
                            : null,
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            /// =============== Add Option Button ===============
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => controller.addOption(index),
                icon: const Icon(Icons.add_circle, color: Colors.green),
                label: const Text("Tambah Baris"),
              ),
            ),
          ],
        ),
      );
    });
  }
}
