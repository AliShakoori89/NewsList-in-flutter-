import 'package:flutter/material.dart';
import 'package:news_with_bloc/view/categories_detail.dart';
import 'package:news_with_bloc/view/categories_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flurest',
      home: NewsScreen(),
    );
  }
}
