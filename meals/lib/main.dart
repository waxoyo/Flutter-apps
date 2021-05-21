import 'package:flutter/material.dart';
import './screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availablaMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availablaMeals = DUMMY_MEALS.where((i) {
        if (_filters['gluten'] && !i.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !i.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !i.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !i.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final exisitngIndex = _favoriteMeals.indexWhere((i) {
      return i.id == mealId;
    });
    if (exisitngIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(exisitngIndex);
      });
    } else
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((i) => i.id == mealId));
      });
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((i) => i.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deli meals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Colors.white, //fromRGBO(225, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold)),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/', //not needed, is the value by default
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals), //default home
        CatgoryMealsScreen.routeName: (ctx) =>
            CatgoryMealsScreen(_availablaMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        //to be used for routes not declared above
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        //last resort for unknown routes
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Deli Meals'),
//       ),
//       body: Center(
//         child: Text('Navigation Time'),
//       ),
//     );
//   }
// }
