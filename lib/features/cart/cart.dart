// ignore_for_file: type_literal_in_constant_pattern

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_bloc_/features/cart/bloc/cart_bloc.dart";
import "package:flutter_bloc_/features/cart/components/cart_tile.dart";

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: BlocConsumer<CartBloc, CartState>(
          bloc: cartBloc,
          listenWhen: (context, state) => state is CartActionState,
          buildWhen: (context, state) => state is! CartActionState,
          listener: (context, state) {
            null;
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case CartSuccessState:
                final successState = state as CartSuccessState;

                return Scaffold(
                  body: ListView.builder(
                    itemCount: successState.cartItemList.length,
                    itemBuilder: (context, index) {
                      return CartTile(
                        product: successState.cartItemList[index],
                        cartBloc: cartBloc,
                      );
                    },
                  ),
                );

              default:
                const SizedBox();
            }

            return const SizedBox();
          },
        ));
  }
}
