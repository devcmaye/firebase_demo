import 'package:firebase_demo/screen/home.dart';
import 'package:firebase_demo/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> signInWithEmailPassword() async {

    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

   

      Navigator.pushReplacementNamed(context, '/home');
    
    } catch (e) {
      print('Error: $e');
    } finally{
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            labelText: 'Email', border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder()),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(246, 130, 13, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              signInWithEmailPassword();
                            }
                          },
                          child: const Text('Sign In'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()),
                            );
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'Don\'t have an account?  ',
                              children: [
                                WidgetSpan(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        bottom:
                                            0.5), // Adjust this value for the desired space
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.red,
                                            width: 1.0), // Underline settings
                                      ),
                                    ),
                                    child: const Text(
                                      'Register',
                                      style: TextStyle(
                                        color: Colors.red,
                                        decoration: TextDecoration
                                            .none, // Remove the default underline
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ]))));
  }
}
