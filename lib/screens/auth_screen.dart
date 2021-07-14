import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitAuthForm(
    String userEmail,
    String userName,
    String userPassword,
    File userImage,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
        print(true);
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: userEmail, password: userPassword);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: userEmail, password: userPassword);

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user!.uid + '.jpg');
        await ref.putFile(userImage);
        final userImageUrl= await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('user')
            .doc(authResult.user!.uid)
            .set({
          'username': userName,
          'email': userEmail,
          'image_url':userImageUrl,
        });
      }
    } on PlatformException catch (error) {
      var message = "PLease enter correct Login Credentials";

      if (error.message != null) {
        message = error.message.toString();
      }

      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
      ));

      print(error.message);

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.black,
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
