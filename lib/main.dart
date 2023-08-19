import 'package:flutter/material.dart';
import 'package:olx_demo/pages/bloc/car_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CarPage(),

      // home: ChangeNotifierProvider(
      //   create: (context) => CarProvider(CarApi()),
      //   builder: (context, child) => const CarPage(),
      // ),

    );
  }
}
