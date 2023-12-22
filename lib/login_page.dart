import 'package:e_commerce_app/firebase_auth_services.dart';
import 'package:e_commerce_app/item_list_page.dart';
import 'package:e_commerce_app/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //password visibility
  bool _obscureText = true;

  //firebase
  final FirebaseAuthService _auth = FirebaseAuthService();

  //controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //disposing
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      //body
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              //center text
              child: Text(
                'Login',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),

            //gap between
            const  SizedBox(
              height: 10.0,
            ),

            //enter email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.blue),
                ),
                child: TextField(
                  controller: _emailController,
                  style:const TextStyle(color: Colors.blue),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Colors.blue),
                    labelText: 'Enter email',
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Colors.blue),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),

            //gap between
            const  SizedBox(
              height: 10.0,
            ),

            //Enter Password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.blue),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  style: const TextStyle(color: Colors.blue),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent, // Set the fill color

                    prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                    suffixIcon: GestureDetector(

                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },

                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.blue,
                      ),
                    ),

                    labelText: 'Enter password',
                    labelStyle: const TextStyle(color: Colors.blue),
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.blue),

                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),

            //gap between
            const  SizedBox(
              height: 20.0,
            ),

            //login Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue),
                child: ClipRRect(
                  child: TextButton(onPressed: _signin,
                    child: const Text('Login',style: TextStyle( color: Colors.white,fontWeight: FontWeight.bold),),),
                ),
              ),
            ),

            //gap between
            const  SizedBox(
              height: 20.0,
            ),

           //Register page
            Center(
              child: GestureDetector(
                onTap: () {
                  //goes to ItemListPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  RegisterPage()),
                  );
                },
                child: const Text(
                  'New here? Create account now!',
                  style: TextStyle(
                   //decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  void _signin() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print('User is successfully signed in!');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ItemListPage()));
    } else {
      print('Some error occurred during signing ');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to login. Please try again.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

}
