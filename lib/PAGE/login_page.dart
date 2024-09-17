import 'package:addhills_app/PAGE/signup_page.dart';
import 'package:addhills_app/SERVICES/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class LoginPage extends StatelessWidget {
  // const LoginPage({super.key});

  void onPressed() => {};

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Padding(
        padding: const EdgeInsets.all(44.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 80),
                child: Text(
                  'RequEase',
                  style: /*GoogleFonts.poppins(*/
                      /*textStyle: const */TextStyle(
                          fontSize: 32,
                          color: Color(0xff0a0a0a),
                          fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 100),
                child: const Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.email_rounded,
                          color: Color(0xFF0A0A0A),
                        ),
                      )),
                  controller: _emailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: PasswordTextfield(
                  controller: _passwordController,
                ),
                
                // TextFormField(
                  
                //   decoration: const InputDecoration(
                //       hintText: 'Password',
                //       border: OutlineInputBorder(),
                //       suffixIcon: Icon(Icons.visibility_off_rounded),
                //       prefixIcon: Padding(
                //         padding: EdgeInsets.all(8),
                //         child: Icon(
                //           Icons.key_rounded,
                //           color: Color(0xFF0A0A0A),
                //         ),
                //       )),
                //   controller: _passwordController,
                // ),
              ),
              Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: const Text('Forgot Password?')),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff0a0a0a),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                      onPressed: () async {
                        await AuthService().signin(
                          email: _emailController.text,
                          password: _passwordController.text,
                          context: context
                        );
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(color: Color(0xffFAFAFA)),
                      )),
                ),
              ),
              Text.rich(TextSpan(
                children: [
                  const TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(
                        color: Color(0xff0a0a0a),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
                  TextSpan(
                      text: 'Sign up',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff0a0a0a),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (BuildContext context) => SignupPage()));
                        }),
                ],
              ))
            ], // End of children
          ),
        ),
      ),
    );
  }
}


class PasswordTextfield extends StatefulWidget {
  const PasswordTextfield({super.key, required this.controller});

  final TextEditingController controller;
  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText; // Toggle the state of obscuring text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'Password',
          labelText: 'Password',
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff0a0a0a), width: 1.5),
          ),
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff0a0a0a), width: 1),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.key_rounded,
              color: Color(0xFF0A0A0A),
            ),
          ),
          suffixIcon: GestureDetector(
            onTap:
                _togglePasswordVisibility, // Call the method to toggle visibility
            child: Icon(
              _obscureText
                  ? Icons.visibility_off
                  : Icons.visibility, // Switch icons based on state
            ),
          ),
        ),
        obscureText: _obscureText,
        // validator: (value) =>
        //     (value == null || value.length < 6) ? "Password too short." : null,
      ),
    );
  }
}


//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
//there are still some issues, will fix later
