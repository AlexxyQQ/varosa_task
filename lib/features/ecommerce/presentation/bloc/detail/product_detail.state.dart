part of 'product_detail.bloc.dart';

@freezed
abstract class ProductDetailState with _$ProductDetailState {
  const ProductDetailState._();

  const factory ProductDetailState({
    @Default(false) bool isLoading,
    ProductModel? product,
    AppErrorModel? error,
  }) = _ProductDetailState;

  factory ProductDetailState.initial() => const ProductDetailState();

  factory ProductDetailState.error(AppErrorModel error) =>
      ProductDetailState(error: error);
}
