import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  const SearchPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),

      appBar: AppBar(
        // Search bar
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          child: Form(
            key: controller.formKey,
            child: TextFormField(
              controller: controller.keywordController,
              onEditingComplete: () {
                controller.searchProducts();
              },
              decoration: InputDecoration(
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                }

                return null;
              },
            ),
          ),
        ),

        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 8),
        actions: [
          IconButton(
            onPressed: () => controller.searchProducts(),
            icon: Icon(
              Icons.search_rounded,
              color: Colors.green[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
        backgroundColor: Colors.amber,
      ),

      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator(color: Colors.amber))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: const Text(
                        'Kategori Produk',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                        ),
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.categories.length,
                        itemBuilder: (context, index) {
                          final item = controller.categories[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  Get.toNamed(
                                    '/search-result',
                                    arguments: {
                                      'category': true,
                                      'category_name': item['nama_kategori'],
                                    },
                                  );
                                },
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.green.shade500,
                                        Colors.green.shade700,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 18,
                                      horizontal: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        // Icon(
                                        //   Icons.category_rounded,
                                        //   color: Colors.white,
                                        // ),
                                        const SizedBox(width: 12),

                                        Expanded(
                                          child: Text(
                                            item["nama_kategori"],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),

                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                          color: Colors.amber,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
