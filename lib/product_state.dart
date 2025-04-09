// src/bloc/product/product_state.dart
import 'package:equatable/equatable.dart';
import 'package:zentro/product_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductLoaded extends ProductState {
  final List<Product> products;
  ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}
class ProductError extends ProductState {
  final String message;
  ProductError(this.message);

  @override
  List<Object> get props => [message];
}

