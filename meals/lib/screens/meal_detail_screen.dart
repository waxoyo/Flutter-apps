import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isMealFavorite;

  MealDetailScreen(this.toggleFavorite, this.isMealFavorite);

  Widget buildSectionTitle(BuildContext ctx, String text) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget widget, double height) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: height,
      width: 350,
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments;
    final slectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text('${slectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                slectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients:'),
            buildContainer(
                ListView.builder(
                  itemCount: slectedMeal.ingredients.length,
                  itemBuilder: (ctx, i) => Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 5,
                      ),
                      child: Text(slectedMeal.ingredients[i]),
                    ),
                  ),
                ),
                150),
            buildSectionTitle(context, 'Instructions:'),
            buildContainer(
                ListView.builder(
                  itemCount: slectedMeal.steps.length,
                  itemBuilder: (ctx, i) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${i + 1}'),
                        ),
                        title: Text(slectedMeal.steps[i]),
                      ),
                      Divider(),
                    ],
                  ),
                ),
                300),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:
            Icon(isMealFavorite(mealId) ? Icons.favorite : Icons.star_border),
        onPressed: (){toggleFavorite(mealId);},
      ),
    );
  }
}
