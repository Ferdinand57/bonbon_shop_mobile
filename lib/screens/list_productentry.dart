import 'package:flutter/material.dart';
import 'package:bonbon_shop/models/product_entry.dart';
import 'package:bonbon_shop/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bonbon_shop/screens/product_detail.dart';

class ProductEntryPage extends StatefulWidget {
  const ProductEntryPage({super.key});
  @override
  State<ProductEntryPage> createState() => _ProductEntryPageState();
}
class _ProductEntryPageState extends State<ProductEntryPage> {
  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    // TODO: Don't forget to add the trailing slash (/) at the end of the URL!
    final response = await request.get('http://127.0.0.1:8000/json/');
    // Decoding the response into JSON
    var data = response;
    // Convert json data to a ProductEntry object
    List<ProductEntry> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }
    return listProduct;
  }
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Entry List'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData || snapshot.data!.isEmpty) { 
              return const Column(
                children: [
                  Text(
                    'There is no product data in bonbon shop.',
                    style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  var product = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the product detail page when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: product,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Top orange section for the name
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Text(
                              "${product.fields.name}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Bottom orange section for the rest of the information
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: const BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${product.fields.description}",
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Price: ${product.fields.price}",
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Date Added: ${product.fields.time}",
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
