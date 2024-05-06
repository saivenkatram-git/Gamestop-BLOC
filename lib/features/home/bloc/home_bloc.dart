// ignore_for_file: avoid_print

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_/data/cart_items.dart';
import 'package:flutter_bloc_/data/games_data.dart';
import 'package:flutter_bloc_/data/wishlist_items.dart';
import 'package:flutter_bloc_/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);

    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);

    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);

    on<HomeWishlistButtonNavigateClickedEvent>(
        homeWishlistButtonNavigateClickedEvent);

    on<HomeCartButtonNavigateClickedEvent>(homeCartButtonNavigateClickedEvent);
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Wishlist product clicked');
    wishlistItems.add(event.clickedProduct);
    emit(HomeProductWishlistButtonClickedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Cart product clicked');
    cartItems.add(event.clickedProduct);
    print(cartItems.length);
    emit(HomeProductCartButtonClickedActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateClickedEvent(
      HomeWishlistButtonNavigateClickedEvent event, Emitter<HomeState> emit) {
    print('Wishlist clicked');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateClickedEvent(
      HomeCartButtonNavigateClickedEvent event, Emitter<HomeState> emit) {
    print('Cart clicked');
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
      GamesData.ps4Games.map((game) {
        return ProductDataModel(
            id: game['id'],
            name: game['name'],
            description: game['description'],
            price: game['price'],
            imageUrl: game['image']);
      }).toList(),
    ));
  }
}
