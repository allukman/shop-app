// ignore_for_file: missing_required_param

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/product_overview_screen.dart';

import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/user_product_screen.dart';
import '../screens/edit_product_screen.dart';
import '../screens/auth_screen.dart';
import '../screens/splash_screen.dart';

import '../providers/products_provider.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';
import '../providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, ProductsProvider>(
            update: (ctx, auth, previousProducts) => ProductsProvider(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items,
            ),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrders) => Orders(
              auth.token,
              auth.userId,
              previousOrders == null ? [] : previousOrders.orders,
            ),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                secondaryHeaderColor: Colors.greenAccent,
                fontFamily: 'Lato'),
            home: auth.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductScreen.routeName: (ctx) => UserProductScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
              AuthScreen.routeName: (ctx) => AuthScreen()
            },
          ),
        ));
  }
}
