// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination.bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaginationState<T> {

 bool get isLoading; bool get hasLoadedNext; bool get hasLoadedPrevious; bool get isLoadingNext; bool get isLoadingPrevious; bool get hasReachedNextEnd; bool get hasReachedPreviousEnd; List<T> get items; int get currentPage; int get nextPageSize; int get previousPageSize; String? get nextToken; String? get previousToken; int? get nextPage; int? get totalPages; Map<String, dynamic>? get filters; AppErrorModel? get error;
/// Create a copy of PaginationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationStateCopyWith<T, PaginationState<T>> get copyWith => _$PaginationStateCopyWithImpl<T, PaginationState<T>>(this as PaginationState<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationState<T>&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasLoadedNext, hasLoadedNext) || other.hasLoadedNext == hasLoadedNext)&&(identical(other.hasLoadedPrevious, hasLoadedPrevious) || other.hasLoadedPrevious == hasLoadedPrevious)&&(identical(other.isLoadingNext, isLoadingNext) || other.isLoadingNext == isLoadingNext)&&(identical(other.isLoadingPrevious, isLoadingPrevious) || other.isLoadingPrevious == isLoadingPrevious)&&(identical(other.hasReachedNextEnd, hasReachedNextEnd) || other.hasReachedNextEnd == hasReachedNextEnd)&&(identical(other.hasReachedPreviousEnd, hasReachedPreviousEnd) || other.hasReachedPreviousEnd == hasReachedPreviousEnd)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.nextPageSize, nextPageSize) || other.nextPageSize == nextPageSize)&&(identical(other.previousPageSize, previousPageSize) || other.previousPageSize == previousPageSize)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.previousToken, previousToken) || other.previousToken == previousToken)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&const DeepCollectionEquality().equals(other.filters, filters)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,hasLoadedNext,hasLoadedPrevious,isLoadingNext,isLoadingPrevious,hasReachedNextEnd,hasReachedPreviousEnd,const DeepCollectionEquality().hash(items),currentPage,nextPageSize,previousPageSize,nextToken,previousToken,nextPage,totalPages,const DeepCollectionEquality().hash(filters),error);

@override
String toString() {
  return 'PaginationState<$T>(isLoading: $isLoading, hasLoadedNext: $hasLoadedNext, hasLoadedPrevious: $hasLoadedPrevious, isLoadingNext: $isLoadingNext, isLoadingPrevious: $isLoadingPrevious, hasReachedNextEnd: $hasReachedNextEnd, hasReachedPreviousEnd: $hasReachedPreviousEnd, items: $items, currentPage: $currentPage, nextPageSize: $nextPageSize, previousPageSize: $previousPageSize, nextToken: $nextToken, previousToken: $previousToken, nextPage: $nextPage, totalPages: $totalPages, filters: $filters, error: $error)';
}


}

/// @nodoc
abstract mixin class $PaginationStateCopyWith<T,$Res>  {
  factory $PaginationStateCopyWith(PaginationState<T> value, $Res Function(PaginationState<T>) _then) = _$PaginationStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool hasLoadedNext, bool hasLoadedPrevious, bool isLoadingNext, bool isLoadingPrevious, bool hasReachedNextEnd, bool hasReachedPreviousEnd, List<T> items, int currentPage, int nextPageSize, int previousPageSize, String? nextToken, String? previousToken, int? nextPage, int? totalPages, Map<String, dynamic>? filters, AppErrorModel? error
});


$AppErrorModelCopyWith<$Res>? get error;

}
/// @nodoc
class _$PaginationStateCopyWithImpl<T,$Res>
    implements $PaginationStateCopyWith<T, $Res> {
  _$PaginationStateCopyWithImpl(this._self, this._then);

  final PaginationState<T> _self;
  final $Res Function(PaginationState<T>) _then;

/// Create a copy of PaginationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? hasLoadedNext = null,Object? hasLoadedPrevious = null,Object? isLoadingNext = null,Object? isLoadingPrevious = null,Object? hasReachedNextEnd = null,Object? hasReachedPreviousEnd = null,Object? items = null,Object? currentPage = null,Object? nextPageSize = null,Object? previousPageSize = null,Object? nextToken = freezed,Object? previousToken = freezed,Object? nextPage = freezed,Object? totalPages = freezed,Object? filters = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasLoadedNext: null == hasLoadedNext ? _self.hasLoadedNext : hasLoadedNext // ignore: cast_nullable_to_non_nullable
as bool,hasLoadedPrevious: null == hasLoadedPrevious ? _self.hasLoadedPrevious : hasLoadedPrevious // ignore: cast_nullable_to_non_nullable
as bool,isLoadingNext: null == isLoadingNext ? _self.isLoadingNext : isLoadingNext // ignore: cast_nullable_to_non_nullable
as bool,isLoadingPrevious: null == isLoadingPrevious ? _self.isLoadingPrevious : isLoadingPrevious // ignore: cast_nullable_to_non_nullable
as bool,hasReachedNextEnd: null == hasReachedNextEnd ? _self.hasReachedNextEnd : hasReachedNextEnd // ignore: cast_nullable_to_non_nullable
as bool,hasReachedPreviousEnd: null == hasReachedPreviousEnd ? _self.hasReachedPreviousEnd : hasReachedPreviousEnd // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<T>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,nextPageSize: null == nextPageSize ? _self.nextPageSize : nextPageSize // ignore: cast_nullable_to_non_nullable
as int,previousPageSize: null == previousPageSize ? _self.previousPageSize : previousPageSize // ignore: cast_nullable_to_non_nullable
as int,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,previousToken: freezed == previousToken ? _self.previousToken : previousToken // ignore: cast_nullable_to_non_nullable
as String?,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,totalPages: freezed == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int?,filters: freezed == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppErrorModel?,
  ));
}
/// Create a copy of PaginationState
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


class _PaginationState<T> extends PaginationState<T> {
  const _PaginationState({this.isLoading = false, this.hasLoadedNext = false, this.hasLoadedPrevious = false, this.isLoadingNext = false, this.isLoadingPrevious = false, this.hasReachedNextEnd = false, this.hasReachedPreviousEnd = false, final  List<T> items = const [], this.currentPage = 1, this.nextPageSize = 10, this.previousPageSize = 10, this.nextToken, this.previousToken, this.nextPage, this.totalPages, final  Map<String, dynamic>? filters, this.error}): _items = items,_filters = filters,super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool hasLoadedNext;
@override@JsonKey() final  bool hasLoadedPrevious;
@override@JsonKey() final  bool isLoadingNext;
@override@JsonKey() final  bool isLoadingPrevious;
@override@JsonKey() final  bool hasReachedNextEnd;
@override@JsonKey() final  bool hasReachedPreviousEnd;
 final  List<T> _items;
@override@JsonKey() List<T> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int nextPageSize;
@override@JsonKey() final  int previousPageSize;
@override final  String? nextToken;
@override final  String? previousToken;
@override final  int? nextPage;
@override final  int? totalPages;
 final  Map<String, dynamic>? _filters;
@override Map<String, dynamic>? get filters {
  final value = _filters;
  if (value == null) return null;
  if (_filters is EqualUnmodifiableMapView) return _filters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  AppErrorModel? error;

/// Create a copy of PaginationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginationStateCopyWith<T, _PaginationState<T>> get copyWith => __$PaginationStateCopyWithImpl<T, _PaginationState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginationState<T>&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasLoadedNext, hasLoadedNext) || other.hasLoadedNext == hasLoadedNext)&&(identical(other.hasLoadedPrevious, hasLoadedPrevious) || other.hasLoadedPrevious == hasLoadedPrevious)&&(identical(other.isLoadingNext, isLoadingNext) || other.isLoadingNext == isLoadingNext)&&(identical(other.isLoadingPrevious, isLoadingPrevious) || other.isLoadingPrevious == isLoadingPrevious)&&(identical(other.hasReachedNextEnd, hasReachedNextEnd) || other.hasReachedNextEnd == hasReachedNextEnd)&&(identical(other.hasReachedPreviousEnd, hasReachedPreviousEnd) || other.hasReachedPreviousEnd == hasReachedPreviousEnd)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.nextPageSize, nextPageSize) || other.nextPageSize == nextPageSize)&&(identical(other.previousPageSize, previousPageSize) || other.previousPageSize == previousPageSize)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.previousToken, previousToken) || other.previousToken == previousToken)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&const DeepCollectionEquality().equals(other._filters, _filters)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,hasLoadedNext,hasLoadedPrevious,isLoadingNext,isLoadingPrevious,hasReachedNextEnd,hasReachedPreviousEnd,const DeepCollectionEquality().hash(_items),currentPage,nextPageSize,previousPageSize,nextToken,previousToken,nextPage,totalPages,const DeepCollectionEquality().hash(_filters),error);

@override
String toString() {
  return 'PaginationState<$T>(isLoading: $isLoading, hasLoadedNext: $hasLoadedNext, hasLoadedPrevious: $hasLoadedPrevious, isLoadingNext: $isLoadingNext, isLoadingPrevious: $isLoadingPrevious, hasReachedNextEnd: $hasReachedNextEnd, hasReachedPreviousEnd: $hasReachedPreviousEnd, items: $items, currentPage: $currentPage, nextPageSize: $nextPageSize, previousPageSize: $previousPageSize, nextToken: $nextToken, previousToken: $previousToken, nextPage: $nextPage, totalPages: $totalPages, filters: $filters, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PaginationStateCopyWith<T,$Res> implements $PaginationStateCopyWith<T, $Res> {
  factory _$PaginationStateCopyWith(_PaginationState<T> value, $Res Function(_PaginationState<T>) _then) = __$PaginationStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool hasLoadedNext, bool hasLoadedPrevious, bool isLoadingNext, bool isLoadingPrevious, bool hasReachedNextEnd, bool hasReachedPreviousEnd, List<T> items, int currentPage, int nextPageSize, int previousPageSize, String? nextToken, String? previousToken, int? nextPage, int? totalPages, Map<String, dynamic>? filters, AppErrorModel? error
});


@override $AppErrorModelCopyWith<$Res>? get error;

}
/// @nodoc
class __$PaginationStateCopyWithImpl<T,$Res>
    implements _$PaginationStateCopyWith<T, $Res> {
  __$PaginationStateCopyWithImpl(this._self, this._then);

  final _PaginationState<T> _self;
  final $Res Function(_PaginationState<T>) _then;

/// Create a copy of PaginationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? hasLoadedNext = null,Object? hasLoadedPrevious = null,Object? isLoadingNext = null,Object? isLoadingPrevious = null,Object? hasReachedNextEnd = null,Object? hasReachedPreviousEnd = null,Object? items = null,Object? currentPage = null,Object? nextPageSize = null,Object? previousPageSize = null,Object? nextToken = freezed,Object? previousToken = freezed,Object? nextPage = freezed,Object? totalPages = freezed,Object? filters = freezed,Object? error = freezed,}) {
  return _then(_PaginationState<T>(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasLoadedNext: null == hasLoadedNext ? _self.hasLoadedNext : hasLoadedNext // ignore: cast_nullable_to_non_nullable
as bool,hasLoadedPrevious: null == hasLoadedPrevious ? _self.hasLoadedPrevious : hasLoadedPrevious // ignore: cast_nullable_to_non_nullable
as bool,isLoadingNext: null == isLoadingNext ? _self.isLoadingNext : isLoadingNext // ignore: cast_nullable_to_non_nullable
as bool,isLoadingPrevious: null == isLoadingPrevious ? _self.isLoadingPrevious : isLoadingPrevious // ignore: cast_nullable_to_non_nullable
as bool,hasReachedNextEnd: null == hasReachedNextEnd ? _self.hasReachedNextEnd : hasReachedNextEnd // ignore: cast_nullable_to_non_nullable
as bool,hasReachedPreviousEnd: null == hasReachedPreviousEnd ? _self.hasReachedPreviousEnd : hasReachedPreviousEnd // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<T>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,nextPageSize: null == nextPageSize ? _self.nextPageSize : nextPageSize // ignore: cast_nullable_to_non_nullable
as int,previousPageSize: null == previousPageSize ? _self.previousPageSize : previousPageSize // ignore: cast_nullable_to_non_nullable
as int,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,previousToken: freezed == previousToken ? _self.previousToken : previousToken // ignore: cast_nullable_to_non_nullable
as String?,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,totalPages: freezed == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int?,filters: freezed == filters ? _self._filters : filters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppErrorModel?,
  ));
}

/// Create a copy of PaginationState
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
