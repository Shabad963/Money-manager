import 'package:database/Screens/add%20transaction/screen_add_transaction.dart';
import 'package:database/Screens/category/category_add_popup.dart';
import 'package:database/Screens/category/screen_category.dart';
import 'package:database/Screens/home/widgets/bottom_navigation.dart';
import 'package:database/Screens/transactions/screen_transactions.dart';
import 'package:database/db/category/category_db..dart';
import 'package:database/models/category/category_model.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectIndexNotifier = ValueNotifier(0);

  final _pages = const [
    ScreenTransaction(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('MoneyManager'),
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(child: ValueListenableBuilder(
        valueListenable: selectIndexNotifier,
        builder: (BuildContext context, int updateIndex, _) {
        return _pages[updateIndex];
        },
      )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        if(selectIndexNotifier.value==0)
          {
            print('Add transaction');
            Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
          }else{
             print('Add Category');

             showCategoryAddPopup(context);
        //   final _sample = CategoryModel(
        //       id: DateTime.now().millisecondsSinceEpoch.toString(),
        //       name: 'Travel',
        //       type: CategoryType.expense,
        //   );
        //       CategoryDB().insertCategory(_sample);
        //
          //
          }
      },
      child: Icon(Icons.add),
      ),
    );
  }
}
