import 'package:flutter/material.dart';

import './screens/category_meal_screen.dart';
import './screens/categories_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 18,
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
              headline6: TextStyle(
                fontSize: 25,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
      },
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     case CategoryMealsScreen.routeName:
      //       return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen());
      //     case MealDetailScreen.routeName:
      //       return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen());
      //   }
      // },
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
    );
  }
}
