import 'package:calculadora_orcamento_dev/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Orçamento',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 244, 244, 244),
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
            .copyWith(secondary: Colors.indigo),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo, width: 2.0),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}
