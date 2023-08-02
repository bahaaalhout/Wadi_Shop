import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wadi_shop/Screens/auth_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:wadi_shop/Screens/tabs_screen.dart';
import 'package:wadi_shop/constants.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WADI SHOP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: kprimaryColor),
          useMaterial3: true,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 2,
            selectedLabelStyle: const TextStyle(color: kprimaryColor),
            selectedItemColor: kprimaryColor,
            selectedIconTheme: const IconThemeData(color: kprimaryColor),
            unselectedLabelStyle: TextStyle(color: Colors.grey[700]),
            unselectedIconTheme: IconThemeData(color: Colors.grey[700]),
          ),
          scaffoldBackgroundColor: Colors.grey[200],
          cardColor: Colors.white,
        ),
        home: AnimatedSplashScreen(
          splash: Image.asset('assets/images/wadi_market.png'),
          nextScreen: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kprimaryColor,
                  ),
                );
              }
              if (snapshot.hasData) {
                return const Directionality(
                    textDirection: TextDirection.rtl, child: TabScreen());
              }
              return const Directionality(
                  textDirection: TextDirection.rtl, child: AuthScreen());
            },
          ),
        ));
  }
}
