// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cancel_donation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CancelDonationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelDonationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CancelDonationState()';
}


}

/// @nodoc
class $CancelDonationStateCopyWith<$Res>  {
$CancelDonationStateCopyWith(CancelDonationState _, $Res Function(CancelDonationState) __);
}


/// Adds pattern-matching-related methods to [CancelDonationState].
extension CancelDonationStatePatterns on CancelDonationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CancelDonationInitial value)?  initial,TResult Function( CancelDonationLoading value)?  loading,TResult Function( CancelDonationSuccess value)?  success,TResult Function( CancelDonationError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CancelDonationInitial() when initial != null:
return initial(_that);case CancelDonationLoading() when loading != null:
return loading(_that);case CancelDonationSuccess() when success != null:
return success(_that);case CancelDonationError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CancelDonationInitial value)  initial,required TResult Function( CancelDonationLoading value)  loading,required TResult Function( CancelDonationSuccess value)  success,required TResult Function( CancelDonationError value)  error,}){
final _that = this;
switch (_that) {
case _CancelDonationInitial():
return initial(_that);case CancelDonationLoading():
return loading(_that);case CancelDonationSuccess():
return success(_that);case CancelDonationError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CancelDonationInitial value)?  initial,TResult? Function( CancelDonationLoading value)?  loading,TResult? Function( CancelDonationSuccess value)?  success,TResult? Function( CancelDonationError value)?  error,}){
final _that = this;
switch (_that) {
case _CancelDonationInitial() when initial != null:
return initial(_that);case CancelDonationLoading() when loading != null:
return loading(_that);case CancelDonationSuccess() when success != null:
return success(_that);case CancelDonationError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  success,TResult Function( ApiErrorModel error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CancelDonationInitial() when initial != null:
return initial();case CancelDonationLoading() when loading != null:
return loading();case CancelDonationSuccess() when success != null:
return success();case CancelDonationError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  success,required TResult Function( ApiErrorModel error)  error,}) {final _that = this;
switch (_that) {
case _CancelDonationInitial():
return initial();case CancelDonationLoading():
return loading();case CancelDonationSuccess():
return success();case CancelDonationError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function( ApiErrorModel error)?  error,}) {final _that = this;
switch (_that) {
case _CancelDonationInitial() when initial != null:
return initial();case CancelDonationLoading() when loading != null:
return loading();case CancelDonationSuccess() when success != null:
return success();case CancelDonationError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _CancelDonationInitial implements CancelDonationState {
  const _CancelDonationInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CancelDonationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CancelDonationState.initial()';
}


}




/// @nodoc


class CancelDonationLoading implements CancelDonationState {
  const CancelDonationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelDonationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CancelDonationState.loading()';
}


}




/// @nodoc


class CancelDonationSuccess implements CancelDonationState {
  const CancelDonationSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelDonationSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CancelDonationState.success()';
}


}




/// @nodoc


class CancelDonationError implements CancelDonationState {
  const CancelDonationError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of CancelDonationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CancelDonationErrorCopyWith<CancelDonationError> get copyWith => _$CancelDonationErrorCopyWithImpl<CancelDonationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelDonationError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'CancelDonationState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $CancelDonationErrorCopyWith<$Res> implements $CancelDonationStateCopyWith<$Res> {
  factory $CancelDonationErrorCopyWith(CancelDonationError value, $Res Function(CancelDonationError) _then) = _$CancelDonationErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$CancelDonationErrorCopyWithImpl<$Res>
    implements $CancelDonationErrorCopyWith<$Res> {
  _$CancelDonationErrorCopyWithImpl(this._self, this._then);

  final CancelDonationError _self;
  final $Res Function(CancelDonationError) _then;

/// Create a copy of CancelDonationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(CancelDonationError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
