import 'package:database/Screens/home/Screen_home.dart';
import 'package:flutter/material.dart';


class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _){
        return BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey ,
          currentIndex: updatedIndex,
          onTap: (newIndex){
            ScreenHome.selectIndexNotifier.value = newIndex;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Transactions'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Categories',
            ),

          ],);
      },
    );
  }
}
