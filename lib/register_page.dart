  import 'package:e_commerce_app/item_list_page.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:e_commerce_app/firebase_auth_services.dart';
  import 'login_page.dart';

  class RegisterPage extends StatefulWidget {
    const RegisterPage({super.key});
    @override
    State<RegisterPage> createState() => _RegisterPageState();
  }

  class _RegisterPageState extends State<RegisterPage> {
    //password visibility
    bool _obscureText = true;

    //firebase service
    final FirebaseAuthService _auth = FirebaseAuthService();

    //controllers
     TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordFirstController = TextEditingController();
     TextEditingController _passwordController = TextEditingController();

    //to avoid memory leak
    @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

          //center text
            const Center(
            child:  Text(
            'Signup',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),

            //gap between
            const  SizedBox(
              height: 20.0,
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
                  style: const TextStyle(color: Colors.blue),
                  decoration: const InputDecoration(
                    prefixIcon:  Icon(Icons.person, color: Colors.blue),
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
                  controller: _passwordFirstController,
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

                    labelText: 'Enter password again!',
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

            //signup Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue, // Set the border color here
                      width: 2.0, // Set the border width
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: ClipRRect(
                  child: TextButton(
                    onPressed: (){
                      if(passwordMatch()){
                        _signup();
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password didn't match try again"),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: const Text('Signup',style: TextStyle( color: Colors.blue,fontWeight: FontWeight.bold),),),
                ),
              ),
            ),

            //gap between
            const  SizedBox(
              height: 10.0,
            ),

            //goes to login page
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                child: const Text(
                  'Already have account? login now!',
                  style: TextStyle(
                    //decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),


          ],
        ),
      );
    }

    //password match logic
    bool passwordMatch(){
      if(_passwordFirstController.text == _passwordController.text){
         return true;
      }else{
        return false;
      }
    }


    //signup function
    void _signup() async {
      String email = _emailController.text;
      String password = _passwordController.text;

      User? user = await _auth.signupWithEmailAndPassword(email, password);

      if (user != null) {
        print('User is successfully created!');
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ItemListPage()));
      } else {
        print('Some error occurred during signup!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to create user. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
