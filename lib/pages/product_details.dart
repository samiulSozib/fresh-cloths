import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  String productname;
  String image_url;
  String productPrice;
  ProductDetails({
    required this.productname,
    required this.image_url,
    required this.productPrice,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  TextEditingController qnController = TextEditingController();
  int totalPrice = 70;

  // String initialQnty = "";
  @override
  void initState() {
    super.initState();
    qnController.text = "1"; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text("${widget.productname}"),
            Image.network(
              widget.image_url,
              height: 250,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                " Per Unit Price :  ${widget.productPrice.toString()} /= tk",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Offer : For Free Delivery charge order at least 10 products ",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.red,
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
              indent: 20,
              endIndent: 20,
            ),
            Container(
              height: 100,
              width: screenWidth,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Qnty :",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          controller: qnController,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                int currentValue = int.parse(qnController.text);
                                setState(() {
                                  currentValue++;
                                  qnController.text = currentValue.toString();
                                });
                                // print(currentValue);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                int currentValue = int.parse(qnController.text);
                                setState(() {
                                  if (currentValue == 1) {
                                    print("object");
                                  } else {
                                    currentValue--;
                                    qnController.text = currentValue.toString();
                                  }
                                });
                                // print(currentValue);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 2,
                      child: Text(
                        // totalPrice.toString(),
                        "   Total :${totalPrice * int.parse(qnController.text)}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                height: 50,
                width: screenWidth,
                color: Colors.black,
                child: Center(
                    child: Text(
                  "Add to Cart",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
