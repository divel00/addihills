import 'package:addhills_app/PAGE/login_page.dart';
import 'package:addhills_app/SERVICES/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _myController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  String _password = '';
  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _myController.dispose();
    _birthdayController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  void signUpUser() async {
      await AuthService(FirebaseAuth.instance).signUp(
      // lastName: _lastNameController.text, 
      // firstName: _firstNameController.text,
      email: _emailController.text, 
      // phoneNumber: _phoneController.text, 
      // address: _addressController.text, 
      // birthday: _birthdayController.text, 
      password: _passwordController.text, 
      context: context);
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Select your birthday'),
        actions: <Widget>[
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() {
                  _birthdayController.text = newDateTime
                      .toLocal()
                      .toString()
                      .split(' ')[0]; // Format as YYYY-MM-DD
                });
              },
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 80,
                width: double.infinity,
                child: Text(
                  textAlign: TextAlign.center,
                  'RequEase',
                  style: /*GoogleFonts.poppins(
                      textStyle: const */TextStyle(
                    color: Color(0xff0a0a0a),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                width: double.infinity,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Sign up',
                        style: /*GoogleFonts.poppins(
                            textStyle: const */TextStyle(
                                fontSize: 32,
                                color: Color(0xff0a0a0a),
                                fontWeight: FontWeight.w600),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: /*GoogleFonts.poppins(
                              textStyle: const*/ TextStyle(
                                  color: Color(0xff0a0a0a), fontSize: 14,
                              fontWeight: FontWeight.normal)
                        ),
                        TextSpan(
                          text: 'Sign in',
                          style: /*GoogleFonts.poppins(
                              textStyle: const */TextStyle(
                                  color: Color(0xff0a0a0a), fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
                            },
                        ),
                      ])),
                    )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                height: 600,
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // WithoutIconTextfield(
                        //   hintText: 'Last Name',
                        //   labelText: 'Last Name',
                        //   controller: _lastNameController,
                        //   validator: (val) {
                        //     if (val != null && val.isValidLastName) {
                        //       return "Enter a valid last name";
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // WithoutIconTextfield(
                        //   hintText: 'First Name',
                        //   labelText: 'First Name',
                        //   controller: _firstNameController,
                        //   validator: (val) {
                        //     if (val!.isEmpty && val.isValidName) {
                        //       return "Enter a valid first name";
                        //     }
                        //     return null;
                        //   },
                        // ),
                        WithoutIconTextfield(
                          hintText: 'Email',
                          labelText: 'Email',
                          controller: _emailController,
                          validator: (val) {
                            if (val != null && !val.isValidEmail) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                        // WithoutIconTextfield(
                        //   hintText: 'Phone Number',
                        //   labelText: 'Phone Number',
                        //   controller: _phoneController,
                        //   validator: (val) {
                        //     if (val != null && !val.isValidPhone) {
                        //       return "Enter a valid phone number";
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // WithoutIconTextfield(
                        //   hintText: 'Barangay/City/Province',
                        //   labelText: 'Address',
                        //   controller: _addressController,
                        // ),
                        // Container(
                        //   margin: const EdgeInsets.symmetric(vertical: 4),
                        //   child: TextFormField(
                        //     controller: _birthdayController,
                        //     readOnly: true,
                        //     decoration: InputDecoration(
                        //         hintText: 'Birthday',
                        //         labelText: 'Birthday',
                        //         focusedBorder: const OutlineInputBorder(
                        //             borderSide: BorderSide(
                        //                 color: Color(0xff0a0a0a), width: 1.5)),
                        //         border: const OutlineInputBorder(),
                        //         contentPadding: const EdgeInsets.symmetric(
                        //             horizontal: 4, vertical: 10),
                        //         enabledBorder: const OutlineInputBorder(
                        //             borderSide: BorderSide(
                        //                 color: Color(0xff0a0a0a), width: 1)),
                        //         suffixIcon: InkWell(
                        //           onTap: _showDatePicker,
                        //           child:
                        //               const Icon(Icons.calendar_month_rounded),
                        //         )),
                        //   ),
                        // ),
                        PasswordTextfield(
                          controller: _passwordController,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16, bottom: 4),
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'By signing up, you agree to our ',
                                    style: TextStyle(
                                      color: Color(0xff0a0a0a),
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                    )),
                                TextSpan(
                                    text: 'Terms of Service ',
                                    style: TextStyle(
                                            color: Color(0xff0a0a0a),
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline)),
                                TextSpan(
                                    text: '\nand that you have read our ',
                                    style: TextStyle(
                                      color: Color(0xff0a0a0a),
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                    )),
                                TextSpan(
                                    text: 'Privacy Policy. ',
                                    style: TextStyle(
                                            color: Color(0xff0a0a0a),
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline))
                              ])),
                        ),
                        InkWell(
                          onTap: () async {
                            await AuthService(FirebaseAuth.instance).signUp(
                            // lastName: _lastNameController.text, 
                            // firstName: _firstNameController.text,
                            email: _emailController.text, 
                            // phoneNumber: _phoneController.text, 
                            // address: _addressController.text, 
                            // birthday: _birthdayController.text, 
                            password: _passwordController.text, 
                            context: context);
                            
                            
                            //signUpUser();
                            // debugPrint(_birthdayController.text);
                            //_formKey.currentState!.validate();
                            // Make sure _fname is not null
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            height: 40,
                            alignment: Alignment.center,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Color(0xff0a0a0a),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Text(
                              'Sign up',
                              style: /*GoogleFonts.poppins(
                                  textStyle: const*/ TextStyle(
                                      fontSize: 16,
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class WithoutIconTextfield extends StatefulWidget {
  const WithoutIconTextfield(
      {super.key,
      required this.hintText,
      required this.labelText,
      this.controller,
      this.validator});

  final String? Function(String?)? validator;
  final String hintText;
  final String labelText;
  final TextEditingController? controller;

  @override
  State<WithoutIconTextfield> createState() => _WithoutIconTextfieldState();
}

class _WithoutIconTextfieldState extends State<WithoutIconTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
            hintText: widget.hintText,
            labelText: widget.labelText,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff0a0a0a), width: 1.5)),
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff0a0a0a), width: 1))),
        validator: widget.validator,
      ),
    );
  }
}

extension StringExtension on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
    return nameRegExp.hasMatch(this);
  }

  bool get isValidLastName {
    final lastNameRegExp = RegExp(r'^[A-Z][a-z]+(?: [A-Z][a-z]+)*$');
    return lastNameRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp =
        RegExp(r"((\+63)|0)[.\- ]?9[0-9]{2}[.\- ]?[0-9]{3}[.\- ]?[0-9]{4}$");
    return phoneRegExp.hasMatch(this);
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
        validator: (value) =>
            (value == null || value.length < 6) ? "Password too short." : null,
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