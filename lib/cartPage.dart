import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const CartPage({super.key, required this.product});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),

      //body
      body: Column(
        children: [
          //one item
          SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 3,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      //item image
                      Image.network(
                        widget.product['image'],
                        fit: BoxFit.cover,
                        height: 200,
                        // width: double.infinity
                      ),
                      //item name
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //item name
                            SizedBox(
                              width: 200, // Set a specific width for the container
                              child: Text(
                                widget.product['title'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            //gap
                            const SizedBox(
                              height: 10,
                            ),

                            //add more or less icon
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add)),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.shopping_cart)),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.remove)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
