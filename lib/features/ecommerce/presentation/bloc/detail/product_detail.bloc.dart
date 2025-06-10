import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/common/data/models/error/app_error.model.dart';
import '../../../data/models/product.model.dart';
import '../../../domain/repository/product.repository.dart';

part 'product_detail.state.dart';
part 'product_detail.event.dart';

part 'product_detail.bloc.freezed.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final IProductRepository _productRepository;

  ProductDetailBloc({required IProductRepository productRepository})
    : _productRepository = productRepository,
      super(ProductDetailState.initial()) {
    on<GetProductDetail>(_onGetProductDetail);
  }

  Future<void> _onGetProductDetail(
    GetProductDetail event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _productRepository.getProductById(id: event.id);
    result.fold(
      (error) => emit(state.copyWith(error: error, isLoading: false)),
      (product) => emit(state.copyWith(product: product, isLoading: false)),
    );
  }
}
