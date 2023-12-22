import 'dart:convert';
import 'package:e_commerce_app/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  ItemListPageState createState() => ItemListPageState();
}

class ItemListPageState extends State<ItemListPage> {
  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Fetch products when the app starts
  }

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        setState(() {
          products = json.decode(response.body);
          isLoading = false;
        });
      } else {
        // If the server did not return a 200 OK response,
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false; // Set loading to false in case of an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        title: const Text('Product List'),
      ),

      //drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            //blue drawer header
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.blue,
              ),
              child: Text(
                'Hello user!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),

            //logout button
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Logout logic goes here
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MyHomePage()), // Replace LoginPage() with your login page
                );
              },
            ),

            //gap between
            const SizedBox(height: 30),

            //Divider
            const Divider(
              color: Colors.black,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            //Made by Vaibhav Text
            const Center(
              child: Text(
                'Made by Vaibhav Golam',
                style: TextStyle(fontSize: 18),
              ),
            ),

            //logo icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      launchURL('https://twitter.com/Vaibhav_Golam');
                    },
                    icon: const Icon(FontAwesomeIcons.twitterSquare)),
                IconButton(
                    onPressed: () {
                      launchURL('https://github.com/VaibhavGolam');
                    },
                    icon: const Icon(FontAwesomeIcons.githubSquare)),
                IconButton(
                    onPressed: () {
                      launchURL('https://www.linkedin.com/in/vaibhav-golam/');
                    },
                    icon: const Icon(FontAwesomeIcons.linkedin)),
              ],
            )
          ],
        ),
      ),

      //body
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Center(
                          child: Text(
                            'Welcome to store',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              margin: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12.0),
                                    ),
                                    child: Image.network(
                                      products[index]['image'],
                                      fit: BoxFit.cover,
                                      height: 250,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          products[index]['title'],
                                          style: const TextStyle(
                                            fontSize: 28.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          products[index]['description'],
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              const TextStyle(fontSize: 16.0),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                  products[index]['rating']
                                                          ['rate']
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 26.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '£ ${products[index]['price']}',
                                              style: const TextStyle(
                                                fontSize: 26.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // Function to open the URL
  launchURL(link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
