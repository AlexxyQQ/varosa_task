// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_info.bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeviceInfoState {

 bool get isLoading; AppErrorModel? get error; DeviceInfo? get deviceInfo;
/// Create a copy of DeviceInfoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceInfoStateCopyWith<DeviceInfoState> get copyWith => _$DeviceInfoStateCopyWithImpl<DeviceInfoState>(this as DeviceInfoState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceInfoState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.deviceInfo, deviceInfo) || other.deviceInfo == deviceInfo));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,deviceInfo);

@override
String toString() {
  return 'DeviceInfoState(isLoading: $isLoading, error: $error, deviceInfo: $deviceInfo)';
}


}

/// @nodoc
abstract mixin class $DeviceInfoStateCopyWith<$Res>  {
  factory $DeviceInfoStateCopyWith(DeviceInfoState value, $Res Function(DeviceInfoState) _then) = _$DeviceInfoStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, AppErrorModel? error, DeviceInfo? deviceInfo
});


$AppErrorModelCopyWith<$Res>? get error;

}
/// @nodoc
class _$DeviceInfoStateCopyWithImpl<$Res>
    implements $DeviceInfoStateCopyWith<$Res> {
  _$DeviceInfoStateCopyWithImpl(this._self, this._then);

  final DeviceInfoState _self;
  final $Res Function(DeviceInfoState) _then;

/// Create a copy of DeviceInfoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = freezed,Object? deviceInfo = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppErrorModel?,deviceInfo: freezed == deviceInfo ? _self.deviceInfo : deviceInfo // ignore: cast_nullable_to_non_nullable
as DeviceInfo?,
  ));
}
/// Create a copy of DeviceInfoState
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


class _DeviceInfoState extends DeviceInfoState {
  const _DeviceInfoState({this.isLoading = false, this.error, this.deviceInfo}): super._();
  

@override@JsonKey() final  bool isLoading;
@override final  AppErrorModel? error;
@override final  DeviceInfo? deviceInfo;

/// Create a copy of DeviceInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceInfoStateCopyWith<_DeviceInfoState> get copyWith => __$DeviceInfoStateCopyWithImpl<_DeviceInfoState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceInfoState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.deviceInfo, deviceInfo) || other.deviceInfo == deviceInfo));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,deviceInfo);

@override
String toString() {
  return 'DeviceInfoState(isLoading: $isLoading, error: $error, deviceInfo: $deviceInfo)';
}


}

/// @nodoc
abstract mixin class _$DeviceInfoStateCopyWith<$Res> implements $DeviceInfoStateCopyWith<$Res> {
  factory _$DeviceInfoStateCopyWith(_DeviceInfoState value, $Res Function(_DeviceInfoState) _then) = __$DeviceInfoStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, AppErrorModel? error, DeviceInfo? deviceInfo
});


@override $AppErrorModelCopyWith<$Res>? get error;

}
/// @nodoc
class __$DeviceInfoStateCopyWithImpl<$Res>
    implements _$DeviceInfoStateCopyWith<$Res> {
  __$DeviceInfoStateCopyWithImpl(this._self, this._then);

  final _DeviceInfoState _self;
  final $Res Function(_DeviceInfoState) _then;

/// Create a copy of DeviceInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = freezed,Object? deviceInfo = freezed,}) {
  return _then(_DeviceInfoState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppErrorModel?,deviceInfo: freezed == deviceInfo ? _self.deviceInfo : deviceInfo // ignore: cast_nullable_to_non_nullable
as DeviceInfo?,
  ));
}

/// Create a copy of DeviceInfoState
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
