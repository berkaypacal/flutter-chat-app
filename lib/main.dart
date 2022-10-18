import 'package:flutter/material.dart';
import 'package:signalr_mobile/src/view/home/home_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SignalR',
      home: HomeView(),
    );
  }
}
