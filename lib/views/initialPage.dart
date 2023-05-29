import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyInitialPage extends StatefulWidget {
  const MyInitialPage({super.key});

  @override
  State<MyInitialPage> createState() => _MyInitialPageState();
}

class _MyInitialPageState extends State<MyInitialPage> {

  @override
  void initState() {
    super.initState();
    verificaToken().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<bool> verificaToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString('token') != null) {
      return true;
    } else {
      return false;
    }
  }
}