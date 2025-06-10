import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/abstract/presentation/bloc/pagination/mixins/both_side_pagination.bloc.dart';
import '../../../../core/abstract/presentation/bloc/pagination/pagination.bloc.dart';
import '../../../../core/common/data/models/error/app_error.model.dart';
import '../../data/models/product.model.dart';
import '../../domain/repository/product.repository.dart';

class ProductBloc extends PaginationBloc<ProductModel>
    with BothSidePaginationBloc<ProductModel> {
  final IProductRepository _productRepository;

  ProductBloc({required IProductRepository productRepository})
    : _productRepository = productRepository,
      super(useCursorPagination: false) {
    on<AddToFavoriteEvent>(_onAddToFavoriteEvent);
  }

  Future<void> _onAddToFavoriteEvent(
    AddToFavoriteEvent event,
    Emitter<PaginationState<ProductModel>> emit,
  ) async {
    final result = await _productRepository.toggleFavorite(
      id: event.product.id ?? 0,
    );
    log('result: $result', name: 'ProductBlocasas');
    result.fold(
      (error) =>
          log('toggleFavorite error: ${error.message}', name: 'CursorBloc'),
      (response) {
        final currentItems = state.items;
        final updatedItems = currentItems.map((item) {
          if (item.id == response.id) {
            return response;
          }
          return item;
        }).toList();
        emit(state.copyWith(items: updatedItems));
      },
    );
  }

  @override
  Future<Either<AppErrorModel, PaginationResponse<ProductModel>>> fetchItems({
    int? page,
    int? limit,
    String? nextToken,
    String? previousToken,
    Map<String, dynamic>? filters,
  }) async {
    final result = await _productRepository.getProducts(
      limit: limit,
      skip: (page ?? 1) * (limit ?? 10),
    );

    result.fold(
      (error) => log('fetchItems error: ${error.message}', name: 'CursorBloc'),
      (response) => log(
        'fetchItems success: ${response.items.length} items, nextToken="${response.nextToken}", hasReachedEnd=${response.hasReachedEnd}',
        name: 'CursorBloc',
      ),
    );

    return result;
  }
}

class AddToFavoriteEvent extends PaginationEvent {
  final ProductModel product;

  const AddToFavoriteEvent({required this.product});

  @override
  List<Object?> get props => [product];
}
