// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_/data/cart_items.dart';
import 'package:flutter_bloc_/features/cart/cart.dart';
import 'package:flutter_bloc_/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_/features/home/components/product_tile.dart';
import 'package:flutter_bloc_/features/wishlist/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (context, state) {
        return state is HomeActionState;
      },
      buildWhen: (context, state) {
        return state is! HomeActionState;
      },
      listener: (context, state) {
        if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        }

        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        }

        if (state is HomeProductWishlistButtonClickedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product added to wishlist'),
            ),
          );
        }

        if (state is HomeProductCartButtonClickedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product added to cart'),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Gamestop'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonNavigateClickedEvent());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateClickedEvent());
                    },
                  ),
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTile(
                      product: successState.products[index],
                      homeBloc: homeBloc,
                    );
                  }),
            );

          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error loading products'),
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
