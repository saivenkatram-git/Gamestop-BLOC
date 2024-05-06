part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

// Re-Build States

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;

  HomeLoadedSuccessState(this.products);
}

class HomeErrorState extends HomeState {}

// Action States

class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomeProductWishlistButtonClickedActionState extends HomeActionState {}

class HomeProductCartButtonClickedActionState extends HomeActionState {}
