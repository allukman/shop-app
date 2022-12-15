import 'package:flutter/material.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';

import './product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavs;

  ProductGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products =
        showFavs ? productsData.favoritesItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        // create: (c) => products[i],
        child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl
            ),
      ),
    );
  }
}
