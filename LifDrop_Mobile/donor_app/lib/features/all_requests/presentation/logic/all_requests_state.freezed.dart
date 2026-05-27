// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_requests_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AllRequestsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllRequestsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllRequestsState()';
}


}

/// @nodoc
class $AllRequestsStateCopyWith<$Res>  {
$AllRequestsStateCopyWith(AllRequestsState _, $Res Function(AllRequestsState) __);
}


/// Adds pattern-matching-related methods to [AllRequestsState].
extension AllRequestsStatePatterns on AllRequestsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AllRequestsInitial value)?  initial,TResult Function( AllRequestsLoading value)?  loading,TResult Function( AllRequestsSuccess value)?  success,TResult Function( AllRequestsEmpty value)?  empty,TResult Function( AllRequestsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AllRequestsInitial() when initial != null:
return initial(_that);case AllRequestsLoading() when loading != null:
return loading(_that);case AllRequestsSuccess() when success != null:
return success(_that);case AllRequestsEmpty() when empty != null:
return empty(_that);case AllRequestsError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AllRequestsInitial value)  initial,required TResult Function( AllRequestsLoading value)  loading,required TResult Function( AllRequestsSuccess value)  success,required TResult Function( AllRequestsEmpty value)  empty,required TResult Function( AllRequestsError value)  error,}){
final _that = this;
switch (_that) {
case AllRequestsInitial():
return initial(_that);case AllRequestsLoading():
return loading(_that);case AllRequestsSuccess():
return success(_that);case AllRequestsEmpty():
return empty(_that);case AllRequestsError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AllRequestsInitial value)?  initial,TResult? Function( AllRequestsLoading value)?  loading,TResult? Function( AllRequestsSuccess value)?  success,TResult? Function( AllRequestsEmpty value)?  empty,TResult? Function( AllRequestsError value)?  error,}){
final _that = this;
switch (_that) {
case AllRequestsInitial() when initial != null:
return initial(_that);case AllRequestsLoading() when loading != null:
return loading(_that);case AllRequestsSuccess() when success != null:
return success(_that);case AllRequestsEmpty() when empty != null:
return empty(_that);case AllRequestsError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( PagedResponse<DonationRequestFeedEntity> page,  String searchTerm,  int? urgency,  bool isLoadingMore)?  success,TResult Function( String searchTerm,  int? urgency)?  empty,TResult Function( ApiErrorModel error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AllRequestsInitial() when initial != null:
return initial();case AllRequestsLoading() when loading != null:
return loading();case AllRequestsSuccess() when success != null:
return success(_that.page,_that.searchTerm,_that.urgency,_that.isLoadingMore);case AllRequestsEmpty() when empty != null:
return empty(_that.searchTerm,_that.urgency);case AllRequestsError() when error != null:
return error(_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( PagedResponse<DonationRequestFeedEntity> page,  String searchTerm,  int? urgency,  bool isLoadingMore)  success,required TResult Function( String searchTerm,  int? urgency)  empty,required TResult Function( ApiErrorModel error)  error,}) {final _that = this;
switch (_that) {
case AllRequestsInitial():
return initial();case AllRequestsLoading():
return loading();case AllRequestsSuccess():
return success(_that.page,_that.searchTerm,_that.urgency,_that.isLoadingMore);case AllRequestsEmpty():
return empty(_that.searchTerm,_that.urgency);case AllRequestsError():
return error(_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( PagedResponse<DonationRequestFeedEntity> page,  String searchTerm,  int? urgency,  bool isLoadingMore)?  success,TResult? Function( String searchTerm,  int? urgency)?  empty,TResult? Function( ApiErrorModel error)?  error,}) {final _that = this;
switch (_that) {
case AllRequestsInitial() when initial != null:
return initial();case AllRequestsLoading() when loading != null:
return loading();case AllRequestsSuccess() when success != null:
return success(_that.page,_that.searchTerm,_that.urgency,_that.isLoadingMore);case AllRequestsEmpty() when empty != null:
return empty(_that.searchTerm,_that.urgency);case AllRequestsError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class AllRequestsInitial implements AllRequestsState {
  const AllRequestsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllRequestsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllRequestsState.initial()';
}


}




/// @nodoc


class AllRequestsLoading implements AllRequestsState {
  const AllRequestsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllRequestsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllRequestsState.loading()';
}


}




/// @nodoc


class AllRequestsSuccess implements AllRequestsState {
  const AllRequestsSuccess({required this.page, required this.searchTerm, required this.urgency, this.isLoadingMore = false});
  

 final  PagedResponse<DonationRequestFeedEntity> page;
 final  String searchTerm;
 final  int? urgency;
@JsonKey() final  bool isLoadingMore;

/// Create a copy of AllRequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllRequestsSuccessCopyWith<AllRequestsSuccess> get copyWith => _$AllRequestsSuccessCopyWithImpl<AllRequestsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllRequestsSuccess&&(identical(other.page, page) || other.page == page)&&(identical(other.searchTerm, searchTerm) || other.searchTerm == searchTerm)&&(identical(other.urgency, urgency) || other.urgency == urgency)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,page,searchTerm,urgency,isLoadingMore);

@override
String toString() {
  return 'AllRequestsState.success(page: $page, searchTerm: $searchTerm, urgency: $urgency, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class $AllRequestsSuccessCopyWith<$Res> implements $AllRequestsStateCopyWith<$Res> {
  factory $AllRequestsSuccessCopyWith(AllRequestsSuccess value, $Res Function(AllRequestsSuccess) _then) = _$AllRequestsSuccessCopyWithImpl;
@useResult
$Res call({
 PagedResponse<DonationRequestFeedEntity> page, String searchTerm, int? urgency, bool isLoadingMore
});




}
/// @nodoc
class _$AllRequestsSuccessCopyWithImpl<$Res>
    implements $AllRequestsSuccessCopyWith<$Res> {
  _$AllRequestsSuccessCopyWithImpl(this._self, this._then);

  final AllRequestsSuccess _self;
  final $Res Function(AllRequestsSuccess) _then;

/// Create a copy of AllRequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,Object? searchTerm = null,Object? urgency = freezed,Object? isLoadingMore = null,}) {
  return _then(AllRequestsSuccess(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as PagedResponse<DonationRequestFeedEntity>,searchTerm: null == searchTerm ? _self.searchTerm : searchTerm // ignore: cast_nullable_to_non_nullable
as String,urgency: freezed == urgency ? _self.urgency : urgency // ignore: cast_nullable_to_non_nullable
as int?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class AllRequestsEmpty implements AllRequestsState {
  const AllRequestsEmpty({required this.searchTerm, required this.urgency});
  

 final  String searchTerm;
 final  int? urgency;

/// Create a copy of AllRequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllRequestsEmptyCopyWith<AllRequestsEmpty> get copyWith => _$AllRequestsEmptyCopyWithImpl<AllRequestsEmpty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllRequestsEmpty&&(identical(other.searchTerm, searchTerm) || other.searchTerm == searchTerm)&&(identical(other.urgency, urgency) || other.urgency == urgency));
}


@override
int get hashCode => Object.hash(runtimeType,searchTerm,urgency);

@override
String toString() {
  return 'AllRequestsState.empty(searchTerm: $searchTerm, urgency: $urgency)';
}


}

/// @nodoc
abstract mixin class $AllRequestsEmptyCopyWith<$Res> implements $AllRequestsStateCopyWith<$Res> {
  factory $AllRequestsEmptyCopyWith(AllRequestsEmpty value, $Res Function(AllRequestsEmpty) _then) = _$AllRequestsEmptyCopyWithImpl;
@useResult
$Res call({
 String searchTerm, int? urgency
});




}
/// @nodoc
class _$AllRequestsEmptyCopyWithImpl<$Res>
    implements $AllRequestsEmptyCopyWith<$Res> {
  _$AllRequestsEmptyCopyWithImpl(this._self, this._then);

  final AllRequestsEmpty _self;
  final $Res Function(AllRequestsEmpty) _then;

/// Create a copy of AllRequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? searchTerm = null,Object? urgency = freezed,}) {
  return _then(AllRequestsEmpty(
searchTerm: null == searchTerm ? _self.searchTerm : searchTerm // ignore: cast_nullable_to_non_nullable
as String,urgency: freezed == urgency ? _self.urgency : urgency // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class AllRequestsError implements AllRequestsState {
  const AllRequestsError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of AllRequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllRequestsErrorCopyWith<AllRequestsError> get copyWith => _$AllRequestsErrorCopyWithImpl<AllRequestsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllRequestsError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'AllRequestsState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $AllRequestsErrorCopyWith<$Res> implements $AllRequestsStateCopyWith<$Res> {
  factory $AllRequestsErrorCopyWith(AllRequestsError value, $Res Function(AllRequestsError) _then) = _$AllRequestsErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$AllRequestsErrorCopyWithImpl<$Res>
    implements $AllRequestsErrorCopyWith<$Res> {
  _$AllRequestsErrorCopyWithImpl(this._self, this._then);

  final AllRequestsError _self;
  final $Res Function(AllRequestsError) _then;

/// Create a copy of AllRequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(AllRequestsError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
