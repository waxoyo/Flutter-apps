import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CatgoryMealsScreen extends StatefulWidget {
  //not used since route
  // final String categoryId;
  // final String categoryTitle;
  // CatgoryMealsScreen(this.categoryId,this.categoryTitle);
  static const routeName = '/category-meals';
  final  List<Meal> availableMeals;

  CatgoryMealsScreen(this.availableMeals);

  @override
  _CatgoryMealsScreenState createState() => _CatgoryMealsScreenState();
}

class _CatgoryMealsScreenState extends State<CatgoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  bool _loadedInitDate = false;

  @override
  //instead of init state
  void didChangeDependencies() {
    if (!_loadedInitDate) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((i) {
        return i.categories.contains(categoryId);
      }).toList();
      _loadedInitDate = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealID) {
    setState(() {
      displayedMeals.removeWhere((i) => i.id == mealID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemCount: displayedMeals.length,
        itemBuilder: (ctx, i) {
          return MealItem(
            id: displayedMeals[i].id,
            title: displayedMeals[i].title,
            imageUrl: displayedMeals[i].imageUrl,
            duration: displayedMeals[i].duration,
            complexity: displayedMeals[i].complexity,
            affordability: displayedMeals[i].affordability,
          );
        },
      ),
    );
  }
}
