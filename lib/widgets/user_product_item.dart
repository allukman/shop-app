import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: id);
            },
            icon: Icon(Icons.edit),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you sure want to remove item in the cart?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop(true);
                        try {
                          await Provider.of<ProductsProvider>(context,
                                  listen: false)
                              .deleteProduct(id);
                        } catch (error) {
                          scaffold.showSnackBar(
                            SnackBar(
                              content: Text(
                                'Deleting item failed!',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text('Yes'),
                    )
                  ],
                ),
              );
            },
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          )
        ]),
      ),
    );
  }
}
