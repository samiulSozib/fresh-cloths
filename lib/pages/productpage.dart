import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:phone_auth/pages/product_details.dart';

class ProductPage extends StatelessWidget {
  String categoryName;

  ProductPage({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub-collection data'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("allcategories")
            .doc(categoryName)
            .collection("products")
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot != null) {
            if (snapshot.data!.docs.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    Map<String, dynamic> docData =
                        snapshot.data!.docs[index].data();

                    if (docData.isEmpty) {
                      return Center(child: Text("Loading...."));
                    }
                    String name = docData["productName"];
                    String image = docData["image_url"];
                    String price = docData["price"];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ProductDetails(
                              productname: name,
                              image_url: image,
                              productPrice: price,
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.lightBlue,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 100,
                              width: 100,
                              child: Image.network(
                                image,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "$price -tk",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                ),
              );
            } else {
              return Center(child: Text("Loading...."));
            }
          } else {
            return Center(child: Text("Loading...."));
          }
        },
      ),
    );
  }
}
