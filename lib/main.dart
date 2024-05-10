// ignore_for_file: unused_import, duplicate_import

import 'package:flutter/material.dart';
import 'package:petani_30/models/petani_model.dart';
import 'package:petani_30/models/petani_model.dart';
import 'package:petani_30/screens/home_page.dart';
import 'package:petani_30/screens/home_page.dart';
import 'package:petani_30/screens/detail_page_petani.dart';
import 'package:petani_30/services/petani_service.dart';
import 'package:petani_30/screens/form_petani.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late Future<List<Petani>> futurePetani;
  // final APiService apiService = APiService();

  @override
  void initState() {
    super.initState();
    // futurePetani = apiService.fetchPetani();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tugas API'),
        ),
        body: const HomePage(),
      ),
    );
  }
}
