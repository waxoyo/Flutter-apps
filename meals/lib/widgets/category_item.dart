import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';
//import './category_meals_screen.dart'; not needed due to us calling it via route

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final borderRadiousValue = 30.0;

  CategoryItem(this.title, this.color, this.id);

  //by passing the parameters as route
  void selectCategory(ctx) {
    Navigator.of(ctx).pushNamed(
      CatgoryMealsScreen.routeName,
      arguments: {'id': id, 'title': title},
    );
  }
// by insanciating the widgdet in a "normal" fashion:
  // void selectCategory(ctx) {
  //   Navigator.of(ctx).push(
  //     MaterialPageRoute(//CupertinoPageRoute(
  //       builder: (_) {
  //         return CatgoryMealsScreen(id,title,);
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(borderRadiousValue),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(borderRadiousValue),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }
}
