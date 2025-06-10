part of 'product_detail.bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object?> get props => [];
}

class GetProductDetail extends ProductDetailEvent {
  final int id;

  const GetProductDetail({required this.id});

  @override
  List<Object?> get props => [id];
}
