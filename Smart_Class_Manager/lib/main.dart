import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

Future<void> main() async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var logToken = prefs.getString('logToken');
      print(logToken);
      runApp(MaterialApp(home: logToken == null ? LoginPage() : HomePage()));
    }