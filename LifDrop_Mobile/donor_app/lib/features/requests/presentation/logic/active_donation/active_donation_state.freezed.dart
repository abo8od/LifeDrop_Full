// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_donation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActiveDonationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveDonationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActiveDonationState()';
}


}

/// @nodoc
class $ActiveDonationStateCopyWith<$Res>  {
$ActiveDonationStateCopyWith(ActiveDonationState _, $Res Function(ActiveDonationState) __);
}


/// Adds pattern-matching-related methods to [ActiveDonationState].
extension ActiveDonationStatePatterns on ActiveDonationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ActiveDonationInitial value)?  initial,TResult Function( ActiveDonationLoading value)?  loading,TResult Function( ActiveDonationSuccess value)?  success,TResult Function( ActiveDonationEmpty value)?  empty,TResult Function( ActiveDonationError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveDonationInitial() when initial != null:
return initial(_that);case ActiveDonationLoading() when loading != null:
return loading(_that);case ActiveDonationSuccess() when success != null:
return success(_that);case ActiveDonationEmpty() when empty != null:
return empty(_that);case ActiveDonationError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ActiveDonationInitial value)  initial,required TResult Function( ActiveDonationLoading value)  loading,required TResult Function( ActiveDonationSuccess value)  success,required TResult Function( ActiveDonationEmpty value)  empty,required TResult Function( ActiveDonationError value)  error,}){
final _that = this;
switch (_that) {
case _ActiveDonationInitial():
return initial(_that);case ActiveDonationLoading():
return loading(_that);case ActiveDonationSuccess():
return success(_that);case ActiveDonationEmpty():
return empty(_that);case ActiveDonationError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ActiveDonationInitial value)?  initial,TResult? Function( ActiveDonationLoading value)?  loading,TResult? Function( ActiveDonationSuccess value)?  success,TResult? Function( ActiveDonationEmpty value)?  empty,TResult? Function( ActiveDonationError value)?  error,}){
final _that = this;
switch (_that) {
case _ActiveDonationInitial() when initial != null:
return initial(_that);case ActiveDonationLoading() when loading != null:
return loading(_that);case ActiveDonationSuccess() when success != null:
return success(_that);case ActiveDonationEmpty() when empty != null:
return empty(_that);case ActiveDonationError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ActiveDonationEntity donation)?  success,TResult Function()?  empty,TResult Function( ApiErrorModel error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveDonationInitial() when initial != null:
return initial();case ActiveDonationLoading() when loading != null:
return loading();case ActiveDonationSuccess() when success != null:
return success(_that.donation);case ActiveDonationEmpty() when empty != null:
return empty();case ActiveDonationError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ActiveDonationEntity donation)  success,required TResult Function()  empty,required TResult Function( ApiErrorModel error)  error,}) {final _that = this;
switch (_that) {
case _ActiveDonationInitial():
return initial();case ActiveDonationLoading():
return loading();case ActiveDonationSuccess():
return success(_that.donation);case ActiveDonationEmpty():
return empty();case ActiveDonationError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ActiveDonationEntity donation)?  success,TResult? Function()?  empty,TResult? Function( ApiErrorModel error)?  error,}) {final _that = this;
switch (_that) {
case _ActiveDonationInitial() when initial != null:
return initial();case ActiveDonationLoading() when loading != null:
return loading();case ActiveDonationSuccess() when success != null:
return success(_that.donation);case ActiveDonationEmpty() when empty != null:
return empty();case ActiveDonationError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ActiveDonationInitial implements ActiveDonationState {
  const _ActiveDonationInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveDonationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActiveDonationState.initial()';
}


}




/// @nodoc


class ActiveDonationLoading implements ActiveDonationState {
  const ActiveDonationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveDonationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActiveDonationState.loading()';
}


}




/// @nodoc


class ActiveDonationSuccess implements ActiveDonationState {
  const ActiveDonationSuccess(this.donation);
  

 final  ActiveDonationEntity donation;

/// Create a copy of ActiveDonationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveDonationSuccessCopyWith<ActiveDonationSuccess> get copyWith => _$ActiveDonationSuccessCopyWithImpl<ActiveDonationSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveDonationSuccess&&(identical(other.donation, donation) || other.donation == donation));
}


@override
int get hashCode => Object.hash(runtimeType,donation);

@override
String toString() {
  return 'ActiveDonationState.success(donation: $donation)';
}


}

/// @nodoc
abstract mixin class $ActiveDonationSuccessCopyWith<$Res> implements $ActiveDonationStateCopyWith<$Res> {
  factory $ActiveDonationSuccessCopyWith(ActiveDonationSuccess value, $Res Function(ActiveDonationSuccess) _then) = _$ActiveDonationSuccessCopyWithImpl;
@useResult
$Res call({
 ActiveDonationEntity donation
});




}
/// @nodoc
class _$ActiveDonationSuccessCopyWithImpl<$Res>
    implements $ActiveDonationSuccessCopyWith<$Res> {
  _$ActiveDonationSuccessCopyWithImpl(this._self, this._then);

  final ActiveDonationSuccess _self;
  final $Res Function(ActiveDonationSuccess) _then;

/// Create a copy of ActiveDonationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? donation = null,}) {
  return _then(ActiveDonationSuccess(
null == donation ? _self.donation : donation // ignore: cast_nullable_to_non_nullable
as ActiveDonationEntity,
  ));
}


}

/// @nodoc


class ActiveDonationEmpty implements ActiveDonationState {
  const ActiveDonationEmpty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveDonationEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActiveDonationState.empty()';
}


}




/// @nodoc


class ActiveDonationError implements ActiveDonationState {
  const ActiveDonationError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of ActiveDonationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveDonationErrorCopyWith<ActiveDonationError> get copyWith => _$ActiveDonationErrorCopyWithImpl<ActiveDonationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveDonationError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ActiveDonationState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ActiveDonationErrorCopyWith<$Res> implements $ActiveDonationStateCopyWith<$Res> {
  factory $ActiveDonationErrorCopyWith(ActiveDonationError value, $Res Function(ActiveDonationError) _then) = _$ActiveDonationErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$ActiveDonationErrorCopyWithImpl<$Res>
    implements $ActiveDonationErrorCopyWith<$Res> {
  _$ActiveDonationErrorCopyWithImpl(this._self, this._then);

  final ActiveDonationError _self;
  final $Res Function(ActiveDonationError) _then;

/// Create a copy of ActiveDonationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ActiveDonationError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
