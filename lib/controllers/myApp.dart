import 'package:flutter/material.dart';

import '../views/contactPage.dart';
import '../views/homePage.dart';
import '../views/initialPage.dart';
import '../views/loginPage.dart';
import '../views/singupPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Final',
      theme: ThemeData(
        primarySwatch: Colors.cyan
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) =>  const MyInitialPage(),
        '/login': (context) =>  const MyLoginPage(),
        '/home': (context) =>  const MyHomePage(),
        '/singup': (context) =>  const MySingupPage(),
        '/contact': (context) =>  MyContactsPage(),
      },
    );
  }
}