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
      appBar: AppBar(title: const Text('Single product list'), actions: []),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
            fit: BoxFit.fill,
            height: 400,
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
                Chip(
                  elevation: 4,
                  label: const Text('M'),
                  labelStyle: const TextStyle(color: Colors.white),
                  backgroundColor: Colors.blue,
                  shadowColor: Colors.grey[50],
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            child: Text(widget.product['title'],
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),

          //product discription


          //Rating and cost
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                '£ ${widget.product['price'].toString()}',
                style: const TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),


          //add to cart and buy no
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {}, child: Text('Add to Cart')),
              ElevatedButton(onPressed: () {}, child: Text('Buy Now')),
            ],
          ),
        ],
      ),


    );
  }
}