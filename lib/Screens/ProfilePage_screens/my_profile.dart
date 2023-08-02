import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:wadi_shop/Widgets/profile_widgets/back_icon.dart';
import 'package:wadi_shop/constants.dart';

import '../../Widgets/login_button.dart';
import '../../Widgets/snakbar.dart';
import '../auth_screen.dart';

final auth = FirebaseAuth.instance;

class MyProfile extends StatefulWidget {
  const MyProfile({
    super.key,
  });

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  File? _selectedPic;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _pickImage() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        content: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: () async {
                    final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: 50,
                      maxWidth: 150,
                    );
                    setState(() {
                      _selectedPic = File(image!.path);
                    });
                  },
                  child: const Text(
                    'Pick Image',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )),
              TextButton(
                onPressed: () async {
                  final image = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 50,
                    maxWidth: 150,
                  );
                  setState(() {
                    _selectedPic = File(image!.path);
                  });
                },
                child: const Text(
                  'Gallery',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            width: double.infinity,
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (_selectedPic == null) {
                  return;
                }
                // widget.pickedPic(_selectedPic!);
              },
              child: const Text('Okay'),
            ),
          ),
        ],
      ),
    );
  }

  // Step 1: Retrieve the existing document
  void updateImage() async {
    DocumentReference documentRef = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid);

    DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists) {
      // Step 2: Upload the updated image to Firebase Storage
      String updatedImageUrl = await uploadImageToFirebaseStorage();

      // Step 3: Update the image URL in Firestore
      await documentRef.update({'image_url': updatedImageUrl}).then((value) =>
          showSnackBar(context: context, content: 'Updated it succssfully'));
    }
  }

// Step 2: Upload the updated image to Firebase Storage
  Future<String> uploadImageToFirebaseStorage() async {
    File imageFile = File(_selectedPic!.path);

    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('Image_Picker')
        .child('${auth.currentUser!.uid}.jpg');

    firebase_storage.UploadTask uploadTask = storageRef.putFile(imageFile);

    // Wait for the upload to complete and get the URL
    firebase_storage.TaskSnapshot storageSnapshot =
        await uploadTask.whenComplete(() => null);

    String downloadUrl = await storageSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  @override
  @override
  Widget build(BuildContext context) {
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

    final DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserId);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kprimaryColor,
          automaticallyImplyLeading: false,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'بياناتي',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (_textController.text.trim().isNotEmpty ||
                  _emailController.text.isNotEmpty ||
                  _emailController.text.contains('@') ||
                  _selectedPic != null) {
                if (_textController.text.trim().isNotEmpty) {
                  final Map<String, dynamic> updatedData = {
                    'username': _textController.text,
                  };
                  userRef
                      .update(updatedData)
                      .then((value) => showSnackBar(
                          content: 'Username updated successfully!',
                          context: context))
                      .catchError((error) => showSnackBar(
                          content: 'Failed to update username: $error',
                          context: context));
                }

                if (_emailController.text.isNotEmpty ||
                    _emailController.text.contains('@')) {
                  final Map<String, dynamic> updatedData2 = {
                    'email': _emailController.text,
                  };
                  userRef
                      .update(updatedData2)
                      .then((value) => showSnackBar(
                          content: 'email updated successfully!',
                          context: context))
                      .catchError((error) => showSnackBar(
                          content: 'Failed to update email: $error',
                          context: context));
                }
                if (_selectedPic != null) {
                  updateImage();
                }
              } else {
                return showSnackBar(
                    context: context, content: 'There is nothing to update');
              }
            },
            icon: const Icon(Icons.save),
          ),
          actions: const [BackIcon()],
        ),
        body: currentUserId != null
            ? StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUserId)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: kprimaryColor),
                    );
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Text('User not found');
                  }

                  Map<String, dynamic> userData =
                      snapshot.data!.data() as Map<String, dynamic>;

                  return SingleChildScrollView(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    blurRadius: 20.0, // soften the shadow
                                    spreadRadius: 0.0, //extend the shadow
                                    offset: const Offset(
                                      5.0, // Move to right 10  horizontally
                                      5.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          backgroundImage: _selectedPic != null
                                              ? FileImage(_selectedPic!)
                                              : NetworkImage(
                                                      userData['image_url'])
                                                  as ImageProvider,
                                          radius: 50,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: _pickImage,
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 35),
                                            foregroundColor: kprimaryColor,
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                color: kprimaryColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: const Text('تغيير'),
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      Text(
                                        userData['username'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        userData['email'],
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'تعديل بياناتي',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 19,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    blurRadius: 20.0, // soften the shadow
                                    spreadRadius: 0.0, //extend the shadow
                                    offset: const Offset(
                                      5.0, // Move to right 10  horizontally
                                      5.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('تغيير الإسم'),
                                      TextField(
                                        controller: _textController,
                                        decoration: InputDecoration(
                                          hintText: userData['username'],
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      const Text('تغيير عنوان البريد'),
                                      TextField(
                                        controller: _emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          hintText: userData['email'],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    blurRadius: 20.0, // soften the shadow
                                    spreadRadius: 0.0, //extend the shadow
                                    offset: const Offset(
                                      5.0, // Move to right 10  horizontally
                                      5.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    FirebaseAuth.instance.signOut();
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => const AuthScreen(),
                                    ));
                                  },
                                  leading: const Icon(Icons.remove_circle),
                                  title: const Text(
                                    'تسجيل خروج',
                                    style: TextStyle(color: ksecoundaryColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : const LoginButton());
  }
}










































/**
 * 
 *  
 */