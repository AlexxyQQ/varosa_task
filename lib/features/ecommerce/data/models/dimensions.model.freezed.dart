// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dimensions.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DimensionsModel {

 double? get width; double? get height; double? get depth;
/// Create a copy of DimensionsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DimensionsModelCopyWith<DimensionsModel> get copyWith => _$DimensionsModelCopyWithImpl<DimensionsModel>(this as DimensionsModel, _$identity);

  /// Serializes this DimensionsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DimensionsModel&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.depth, depth) || other.depth == depth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,width,height,depth);

@override
String toString() {
  return 'DimensionsModel(width: $width, height: $height, depth: $depth)';
}


}

/// @nodoc
abstract mixin class $DimensionsModelCopyWith<$Res>  {
  factory $DimensionsModelCopyWith(DimensionsModel value, $Res Function(DimensionsModel) _then) = _$DimensionsModelCopyWithImpl;
@useResult
$Res call({
 double? width, double? height, double? depth
});




}
/// @nodoc
class _$DimensionsModelCopyWithImpl<$Res>
    implements $DimensionsModelCopyWith<$Res> {
  _$DimensionsModelCopyWithImpl(this._self, this._then);

  final DimensionsModel _self;
  final $Res Function(DimensionsModel) _then;

/// Create a copy of DimensionsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? width = freezed,Object? height = freezed,Object? depth = freezed,}) {
  return _then(_self.copyWith(
width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DimensionsModel implements DimensionsModel {
  const _DimensionsModel({this.width, this.height, this.depth});
  factory _DimensionsModel.fromJson(Map<String, dynamic> json) => _$DimensionsModelFromJson(json);

@override final  double? width;
@override final  double? height;
@override final  double? depth;

/// Create a copy of DimensionsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DimensionsModelCopyWith<_DimensionsModel> get copyWith => __$DimensionsModelCopyWithImpl<_DimensionsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DimensionsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DimensionsModel&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.depth, depth) || other.depth == depth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,width,height,depth);

@override
String toString() {
  return 'DimensionsModel(width: $width, height: $height, depth: $depth)';
}


}

/// @nodoc
abstract mixin class _$DimensionsModelCopyWith<$Res> implements $DimensionsModelCopyWith<$Res> {
  factory _$DimensionsModelCopyWith(_DimensionsModel value, $Res Function(_DimensionsModel) _then) = __$DimensionsModelCopyWithImpl;
@override @useResult
$Res call({
 double? width, double? height, double? depth
});




}
/// @nodoc
class __$DimensionsModelCopyWithImpl<$Res>
    implements _$DimensionsModelCopyWith<$Res> {
  __$DimensionsModelCopyWithImpl(this._self, this._then);

  final _DimensionsModel _self;
  final $Res Function(_DimensionsModel) _then;

/// Create a copy of DimensionsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? width = freezed,Object? height = freezed,Object? depth = freezed,}) {
  return _then(_DimensionsModel(
width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
