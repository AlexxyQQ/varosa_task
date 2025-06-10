// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_detail.bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductDetailState {

 bool get isLoading; ProductModel? get product; AppErrorModel? get error;
/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailStateCopyWith<ProductDetailState> get copyWith => _$ProductDetailStateCopyWithImpl<ProductDetailState>(this as ProductDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.product, product) || other.product == product)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,product,error);

@override
String toString() {
  return 'ProductDetailState(isLoading: $isLoading, product: $product, error: $error)';
}


}

/// @nodoc
abstract mixin class $ProductDetailStateCopyWith<$Res>  {
  factory $ProductDetailStateCopyWith(ProductDetailState value, $Res Function(ProductDetailState) _then) = _$ProductDetailStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, ProductModel? product, AppErrorModel? error
});


$ProductModelCopyWith<$Res>? get product;$AppErrorModelCopyWith<$Res>? get error;

}
/// @nodoc
class _$ProductDetailStateCopyWithImpl<$Res>
    implements $ProductDetailStateCopyWith<$Res> {
  _$ProductDetailStateCopyWithImpl(this._self, this._then);

  final ProductDetailState _self;
  final $Res Function(ProductDetailState) _then;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? product = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductModel?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppErrorModel?,
  ));
}
/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductModelCopyWith<$Res>? get product {
    if (_self.product == null) {
    return null;
  }

  return $ProductModelCopyWith<$Res>(_self.product!, (value) {
    return _then(_self.copyWith(product: value));
  });
}/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppErrorModelCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $AppErrorModelCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// @nodoc


class _ProductDetailState extends ProductDetailState {
  const _ProductDetailState({this.isLoading = false, this.product, this.error}): super._();
  

@override@JsonKey() final  bool isLoading;
@override final  ProductModel? product;
@override final  AppErrorModel? error;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDetailStateCopyWith<_ProductDetailState> get copyWith => __$ProductDetailStateCopyWithImpl<_ProductDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDetailState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.product, product) || other.product == product)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,product,error);

@override
String toString() {
  return 'ProductDetailState(isLoading: $isLoading, product: $product, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ProductDetailStateCopyWith<$Res> implements $ProductDetailStateCopyWith<$Res> {
  factory _$ProductDetailStateCopyWith(_ProductDetailState value, $Res Function(_ProductDetailState) _then) = __$ProductDetailStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, ProductModel? product, AppErrorModel? error
});


@override $ProductModelCopyWith<$Res>? get product;@override $AppErrorModelCopyWith<$Res>? get error;

}
/// @nodoc
class __$ProductDetailStateCopyWithImpl<$Res>
    implements _$ProductDetailStateCopyWith<$Res> {
  __$ProductDetailStateCopyWithImpl(this._self, this._then);

  final _ProductDetailState _self;
  final $Res Function(_ProductDetailState) _then;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? product = freezed,Object? error = freezed,}) {
  return _then(_ProductDetailState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductModel?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppErrorModel?,
  ));
}

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductModelCopyWith<$Res>? get product {
    if (_self.product == null) {
    return null;
  }

  return $ProductModelCopyWith<$Res>(_self.product!, (value) {
    return _then(_self.copyWith(product: value));
  });
}/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppErrorModelCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $AppErrorModelCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

// dart format on
