import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/chat_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
                title: 'Chatting Karlo',
                theme: ThemeData(
                  primarySwatch: Colors.pink,
                  backgroundColor: Colors.pink,
                  accentColor: Colors.deepPurple,
                  accentColorBrightness: Brightness.dark,
                  buttonTheme: ButtonTheme.of(context).copyWith(
                    buttonColor: Colors.pink,
                    textTheme: ButtonTextTheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                home: StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx, userState) {
                    if (userState.connectionState == ConnectionState.waiting) {
                      return SplashScreen();
                    }
                    if (userState.hasData) {
                      return ChatScreen();
                    }
                    return AuthScreen();
                  },
                ));
          }
          return CircularProgressIndicator();
        });
  }
}
