import 'package:flutter/material.dart';
import 'package:flutter_bloc_/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_/features/home/models/home_product_data_model.dart';

class CartTile extends StatelessWidget {
  final ProductDataModel product;
  final CartBloc cartBloc;

  const CartTile({super.key, required this.product, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(
              product.imageUrl,
              width: 200,
              height: 200,
            ),
            Text(product.name,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(
              product.description,
              textAlign: TextAlign.center,
            ),
            Text(product.price.toString()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    cartBloc.add(CartRemoveFromCartEvent(product: product));
                  },
                  child: const Text('Remove from cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
