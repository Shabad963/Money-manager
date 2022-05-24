import 'package:database/Screens/add%20transaction/screen_add_transaction.dart';
import 'package:database/Screens/home/Screen_home.dart';
import 'package:database/models/category/category_model.dart';
import 'package:database/models/transaction/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'db/category/category_db..dart';

  Future<void> main() async{

   final obj1 = CategoryDB();
   final obj2 = CategoryDB();
   // print('objects comparing');
   // print(obj1 == obj2);

   WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if(Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if(Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
    Hive.registerAdapter(CategoryModelAdapter());
  }

   if(Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
     Hive.registerAdapter(TransactionModelAdapter());
   }

    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScreenHome(),
      routes: {
        ScreenaddTransaction.routeName: (ctx) => const ScreenaddTransaction(),
      },
    );
  }
}

