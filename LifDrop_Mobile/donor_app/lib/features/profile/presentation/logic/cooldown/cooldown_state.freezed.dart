// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cooldown_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CooldownState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CooldownState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CooldownState()';
}


}

/// @nodoc
class $CooldownStateCopyWith<$Res>  {
$CooldownStateCopyWith(CooldownState _, $Res Function(CooldownState) __);
}


/// Adds pattern-matching-related methods to [CooldownState].
extension CooldownStatePatterns on CooldownState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CooldownInitial value)?  initial,TResult Function( CooldownLoading value)?  loading,TResult Function( CooldownSuccess value)?  success,TResult Function( CooldownError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CooldownInitial() when initial != null:
return initial(_that);case CooldownLoading() when loading != null:
return loading(_that);case CooldownSuccess() when success != null:
return success(_that);case CooldownError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CooldownInitial value)  initial,required TResult Function( CooldownLoading value)  loading,required TResult Function( CooldownSuccess value)  success,required TResult Function( CooldownError value)  error,}){
final _that = this;
switch (_that) {
case _CooldownInitial():
return initial(_that);case CooldownLoading():
return loading(_that);case CooldownSuccess():
return success(_that);case CooldownError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CooldownInitial value)?  initial,TResult? Function( CooldownLoading value)?  loading,TResult? Function( CooldownSuccess value)?  success,TResult? Function( CooldownError value)?  error,}){
final _that = this;
switch (_that) {
case _CooldownInitial() when initial != null:
return initial(_that);case CooldownLoading() when loading != null:
return loading(_that);case CooldownSuccess() when success != null:
return success(_that);case CooldownError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( CooldownEntity data)?  success,TResult Function( ApiErrorModel error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CooldownInitial() when initial != null:
return initial();case CooldownLoading() when loading != null:
return loading();case CooldownSuccess() when success != null:
return success(_that.data);case CooldownError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( CooldownEntity data)  success,required TResult Function( ApiErrorModel error)  error,}) {final _that = this;
switch (_that) {
case _CooldownInitial():
return initial();case CooldownLoading():
return loading();case CooldownSuccess():
return success(_that.data);case CooldownError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( CooldownEntity data)?  success,TResult? Function( ApiErrorModel error)?  error,}) {final _that = this;
switch (_that) {
case _CooldownInitial() when initial != null:
return initial();case CooldownLoading() when loading != null:
return loading();case CooldownSuccess() when success != null:
return success(_that.data);case CooldownError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _CooldownInitial implements CooldownState {
  const _CooldownInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CooldownInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CooldownState.initial()';
}


}




/// @nodoc


class CooldownLoading implements CooldownState {
  const CooldownLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CooldownLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CooldownState.loading()';
}


}




/// @nodoc


class CooldownSuccess implements CooldownState {
  const CooldownSuccess(this.data);
  

 final  CooldownEntity data;

/// Create a copy of CooldownState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CooldownSuccessCopyWith<CooldownSuccess> get copyWith => _$CooldownSuccessCopyWithImpl<CooldownSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CooldownSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'CooldownState.success(data: $data)';
}


}

/// @nodoc
abstract mixin class $CooldownSuccessCopyWith<$Res> implements $CooldownStateCopyWith<$Res> {
  factory $CooldownSuccessCopyWith(CooldownSuccess value, $Res Function(CooldownSuccess) _then) = _$CooldownSuccessCopyWithImpl;
@useResult
$Res call({
 CooldownEntity data
});




}
/// @nodoc
class _$CooldownSuccessCopyWithImpl<$Res>
    implements $CooldownSuccessCopyWith<$Res> {
  _$CooldownSuccessCopyWithImpl(this._self, this._then);

  final CooldownSuccess _self;
  final $Res Function(CooldownSuccess) _then;

/// Create a copy of CooldownState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(CooldownSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CooldownEntity,
  ));
}


}

/// @nodoc


class CooldownError implements CooldownState {
  const CooldownError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of CooldownState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CooldownErrorCopyWith<CooldownError> get copyWith => _$CooldownErrorCopyWithImpl<CooldownError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CooldownError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'CooldownState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $CooldownErrorCopyWith<$Res> implements $CooldownStateCopyWith<$Res> {
  factory $CooldownErrorCopyWith(CooldownError value, $Res Function(CooldownError) _then) = _$CooldownErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$CooldownErrorCopyWithImpl<$Res>
    implements $CooldownErrorCopyWith<$Res> {
  _$CooldownErrorCopyWithImpl(this._self, this._then);

  final CooldownError _self;
  final $Res Function(CooldownError) _then;

/// Create a copy of CooldownState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(CooldownError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
