import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yestech_todo/project1/add.dart';
import 'package:yestech_todo/project1/home.dart';
import 'package:yestech_todo/project1/update.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Added 'await' here
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp(); // Corrected the constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        '/add': (context) => const AddUser(),
        '/update':(context) => const UpdateDonor()
      },
      initialRoute: '/',
    );
  }
}
