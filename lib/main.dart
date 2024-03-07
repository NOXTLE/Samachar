import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:news/Services/state.dart';
import 'package:news/pages/homepage.dart';
import 'package:news/richtext.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => MyState())],
        child:
            MaterialApp(debugShowCheckedModeBanner: false, home: rich_text()));
  }

//HomePage()));
}
