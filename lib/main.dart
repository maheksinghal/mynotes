import 'package:flutter/material.dart';
import 'package:mynotes/Views/Screens/AddNotesPage.dart';
import 'Views/Screens/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFFfad2e1),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xffd6e2e9),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/add': (context) => AddNotes(),
      },
    );
  }
}
