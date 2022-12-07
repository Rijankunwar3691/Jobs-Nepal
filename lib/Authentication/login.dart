import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screen/hompage.dart';
import 'reset_password.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool _obscuretext = true;

  //validate functiom to check for validation and jump on next page--------------
  void validate() async {
    if (formkey.currentState!.validate()) {
      try {
        // ignore: unused_local_variable
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        // ignore: use_build_context_synchronously
        Fluttertoast.showToast(
            msg: 'Logged in',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0);

        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HomePage(), //naviagte to homepage after validation
            ));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(
              msg: 'No user found for that email.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(
              msg: 'Wrong password provided for that user.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    }
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //login page widget builder---------------------------------
    return Scaffold(
        backgroundColor: Colors.purple,
        body: Center(
          child: SizedBox(
            height: 450.0,
            width: 400.0,
            child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              margin: const EdgeInsets.all(20.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            // login text on top of form---------------------
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                  letterSpacing: 1.0),
                            ),
                          ),
                          const Divider(
                            height: 15.0,
                            thickness: 2,
                            color: Color.fromRGBO(0, 0, 0, 0.63),
                          ),
                          //User name input field section--------------------
                          TextFormField(
                            onChanged: (value) => email = value,
                            controller: emailcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Email.';
                              } else if (!value.contains('@')) {
                                return 'Invalid Email';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(letterSpacing: 1.0),
                            ),
                          ),
                          //user name input section closed------------------
                          const SizedBox(
                            height: 10.0,
                          ),
                          // password input section------------------------
                          TextFormField(
                            onChanged: (value) => password = value,
                            controller: passwordcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter paswword.';
                              }
                              return null;
                            },
                            autocorrect: false,
                            enableSuggestions: false,
                            obscureText: _obscuretext,
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscuretext = !_obscuretext;
                                    });
                                  },
                                  child: Icon(_obscuretext
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                labelText: 'Password',
                                labelStyle:
                                    const TextStyle(letterSpacing: 1.0)),
                          ),
                          //password section closed-----------------------
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ResetPassword(),
                                    ));
                              },
                              child: const Text(
                                'forgot password ?',
                                style: TextStyle(letterSpacing: 1.0),
                              )),
                          Center(
                              child: SizedBox(
                            width: 150.0,
                            //login elevated button----------------------
                            child: ElevatedButton(
                              onPressed: validate, //validate,
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0))),
                              child: const Text(
                                "Login",
                                style:
                                    TextStyle(letterSpacing: 1.0, fontSize: 20),
                              ),
                            ),
                            //login elevated button closed------------------
                          )),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Not a member?',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey,
                                    letterSpacing: 1.0),
                              ),
                              //text button for signup----------------
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUp(), //navigates to signup page------
                                        ));
                                  },
                                  child: const Text(
                                    'SignUp',
                                    style: TextStyle(letterSpacing: 1.0),
                                  )),
                              //text button closed-------------------
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
