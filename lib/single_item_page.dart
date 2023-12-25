import 'package:flutter/material.dart';

class SingleItemPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const SingleItemPage({super.key, required this.product});

  @override
  State<SingleItemPage> createState() => _SingleItemPageState();
}

class _SingleItemPageState extends State<SingleItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Single product list'), actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
      ]),
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.product['image'],
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),

              //divider
              const Divider(
                height: 20,
                color: Colors.black,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),

              //size selectors
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Chip(
                      elevation: 4,
                      label: const Text('S'),
                      labelStyle: const TextStyle(color: Colors.white),
                      backgroundColor: Colors.blue,
                      shadowColor: Colors.grey[50],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Chip(
                      elevation: 4,
                      label: const Text('M'),
                      labelStyle: const TextStyle(color: Colors.white),
                      backgroundColor: Colors.blue,
                      shadowColor: Colors.grey[50],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Chip(
                      elevation: 4,
                      label: const Text('L'),
                      labelStyle: const TextStyle(color: Colors.white),
                      backgroundColor: Colors.blue,
                      shadowColor: Colors.grey[50],
                    ),
                  ],
                ),
              ),

              //Product title
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                child: Text(widget.product['title'],
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
              ),

              const SizedBox(
                height: 15,
              ),


              //product Description heading
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              //product description
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                child: Text(widget.product['description'],
                    style: const TextStyle(
                      fontSize: 20,
                    )),
              ),

              //Rating and cost
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 30,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.product['rating']['rate'].toString(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    '£ ${widget.product['price'].toString()}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),

              //add to cart and buy now
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: BeveledRectangleBorder(),
                          minimumSize: Size(150, 50),
                          elevation: 4),
                      child: const Text('Add to Cart'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: BeveledRectangleBorder(),
                        minimumSize: Size(150, 50),
                        elevation: 4,
                      ),
                      child: const Text('Buy Now'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
