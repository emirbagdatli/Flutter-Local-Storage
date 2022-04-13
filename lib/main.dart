import 'package:flutter/material.dart';
import 'package:flutter_storage/services/seruce_storage.dart';
import 'package:flutter_storage/shared_pref.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  //locator.registerSingleton<SecureStorageServices>(SecureStorageServices());
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Storage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Storage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const SharedPref())));
                },
                child: const Text('Shared Pref/Secure Storage/File Storage')),
          ),
        ],
      ),
    );
  }
}
