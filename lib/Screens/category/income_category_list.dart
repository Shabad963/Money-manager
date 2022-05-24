import 'package:database/db/category/category_db..dart';
import 'package:database/models/category/category_model.dart';
import 'package:flutter/material.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().incomeCategoryListListener,
      builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final category = newlist[index];
            return Card(
              child: ListTile(
                title: Text(category.name),
                trailing: IconButton(
                  onPressed: () {
                    CategoryDB.instance.deleteCategory(category.id);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(height: 10);
          },
          itemCount: newlist.length,
        );
      },
    );
  }
}