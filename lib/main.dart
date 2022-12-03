import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'Address.dart';
import 'HiveCURDPage.dart';
import 'Person.dart';

late Box addressBox;
late Box personTable;
late var database;
Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  
  final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  //await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  Hive.registerAdapter(AddressAdapter());
  personTable = await Hive.openBox<Person>('personTable');
  addressBox = await Hive.openBox<Address>('addressTable');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HiveCURDPage(),
    );
  }
}
