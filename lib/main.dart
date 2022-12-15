import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_overview_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';
import '../providers/products_provider.dart';
import '../providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            secondaryHeaderColor: Colors.greenAccent,
            fontFamily: 'Lato'),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
