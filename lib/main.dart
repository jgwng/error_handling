import 'package:error_handling_either/binding/post_binding.dart';
import 'package:error_handling_either/ui/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Material App',
      getPages: [
        GetPage(
          name: '/home',
          page: () => const Home(),
          binding: PostBinding(),
        ),
      ],
      initialRoute: '/home',
    );
  }
}
