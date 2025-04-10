import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentro/product_management.dart';
import 'package:zentro/service.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;
  ProductBloc(this.repository) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      
      try {
        final products = await repository.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
