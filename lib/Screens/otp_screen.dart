// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:wadi_shop/Screens/tabs_screen.dart';

import '../Widgets/auth_widgets/image_picker_widget.dart';
import '../Widgets/auth_widgets/input_field.dart';
import '../constants.dart';

final _auth = FirebaseAuth.instance;

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _keyState = GlobalKey<FormState>();
  String _enteredEmail = '';
  String _enteredPass = '';
  String _enteredUsername = '';
  bool isLogin = true;
  File? _pickedImage;
  bool isLoading = false;
  // This method to signin button
  // It will check if validate then with save the value in the controller
  void _signIn() async {
    FocusScope.of(context).unfocus();
    final isValid = _keyState.currentState!.validate();

    if (!isValid || !isLogin && _pickedImage == null) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    _keyState.currentState!.save();
    try {
      if (isLogin) {
        await _auth.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPass);
        await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Directionality(
                  textDirection: TextDirection.rtl, child: TabScreen()),
            ));
      } else {
        final userCredentials = await _auth.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPass,
        );
        final userStorage = FirebaseStorage.instance
            .ref()
            .child('Image_Picker')
            .child('${userCredentials.user!.uid}.jpg');
        await userStorage.putFile(_pickedImage!);
        final imageUrl = await userStorage.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': _enteredUsername,
          'email': _enteredEmail,
          'image_url': imageUrl,
        });
        await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Directionality(
                  textDirection: TextDirection.rtl, child: TabScreen()),
            ));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Unvalid authntication'),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _keyState,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/wadi_market.png',
                        width: 280,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (!isLogin)
                        ImagePickerWidget(
                          pickedPic: (image) {
                            _pickedImage = image;
                          },
                        ),
                      if (!isLogin)
                        InputField(
                          hinttext: 'اسم المستخدم',
                          textInputType: TextInputType.text,
                          focusedColor: kprimaryColor,
                          isPass: false,
                          validation: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length < 4) {
                              return 'Must be at least 4 character ';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredUsername = value!;
                          },
                        ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: InputField(
                          hinttext: 'example@gmail.com',
                          textInputType: TextInputType.emailAddress,
                          focusedColor: kprimaryColor,
                          isPass: false,
                          validation: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'This field must contain an email';
                            }

                            return null;
                          },
                          onSaved: (newValue) {
                            _enteredEmail = newValue!;
                          },
                        ),
                      ),
                      InputField(
                        hinttext: 'كلمة المرور',
                        textInputType: TextInputType.text,
                        focusedColor: kprimaryColor,
                        isPass: true,
                        validation: (value) {
                          if (value == null || value.trim().length <= 6) {
                            return isLogin
                                ? 'Enter a stronger password'
                                : 'Wrong Password';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredPass = newValue!;
                        },
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        child: ElevatedButton(
                          onPressed: _signIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kprimaryColor,
                            padding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  isLogin ? 'تسجيل دخول' : 'انشاء الحساب',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                          builder: (context) => const Directionality(
                              textDirection: TextDirection.rtl,
                              child: TabScreen()),
                        )),
                        child: const Text(
                          'تصفح كزائر',
                          style: TextStyle(color: kthirdColor, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                _keyState.currentState!.reset();
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                child: Text(
                  isLogin
                      ? 'لا تملك حساب ؟ انشاء حساب'
                      : 'تملك حساب ؟ تسجيل دخول',
                  style:
                      const TextStyle(color: Color.fromARGB(255, 96, 94, 94)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
