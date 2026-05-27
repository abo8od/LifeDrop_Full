// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_token_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeviceTokenState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceTokenState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DeviceTokenState()';
}


}

/// @nodoc
class $DeviceTokenStateCopyWith<$Res>  {
$DeviceTokenStateCopyWith(DeviceTokenState _, $Res Function(DeviceTokenState) __);
}


/// Adds pattern-matching-related methods to [DeviceTokenState].
extension DeviceTokenStatePatterns on DeviceTokenState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _DeviceTokenInitial value)?  initial,TResult Function( DeviceTokenLoading value)?  loading,TResult Function( DeviceTokenRegistered value)?  registered,TResult Function( DeviceTokenUnregistered value)?  unregistered,TResult Function( DeviceTokenError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceTokenInitial() when initial != null:
return initial(_that);case DeviceTokenLoading() when loading != null:
return loading(_that);case DeviceTokenRegistered() when registered != null:
return registered(_that);case DeviceTokenUnregistered() when unregistered != null:
return unregistered(_that);case DeviceTokenError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _DeviceTokenInitial value)  initial,required TResult Function( DeviceTokenLoading value)  loading,required TResult Function( DeviceTokenRegistered value)  registered,required TResult Function( DeviceTokenUnregistered value)  unregistered,required TResult Function( DeviceTokenError value)  error,}){
final _that = this;
switch (_that) {
case _DeviceTokenInitial():
return initial(_that);case DeviceTokenLoading():
return loading(_that);case DeviceTokenRegistered():
return registered(_that);case DeviceTokenUnregistered():
return unregistered(_that);case DeviceTokenError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _DeviceTokenInitial value)?  initial,TResult? Function( DeviceTokenLoading value)?  loading,TResult? Function( DeviceTokenRegistered value)?  registered,TResult? Function( DeviceTokenUnregistered value)?  unregistered,TResult? Function( DeviceTokenError value)?  error,}){
final _that = this;
switch (_that) {
case _DeviceTokenInitial() when initial != null:
return initial(_that);case DeviceTokenLoading() when loading != null:
return loading(_that);case DeviceTokenRegistered() when registered != null:
return registered(_that);case DeviceTokenUnregistered() when unregistered != null:
return unregistered(_that);case DeviceTokenError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  registered,TResult Function()?  unregistered,TResult Function( ApiErrorModel error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceTokenInitial() when initial != null:
return initial();case DeviceTokenLoading() when loading != null:
return loading();case DeviceTokenRegistered() when registered != null:
return registered();case DeviceTokenUnregistered() when unregistered != null:
return unregistered();case DeviceTokenError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  registered,required TResult Function()  unregistered,required TResult Function( ApiErrorModel error)  error,}) {final _that = this;
switch (_that) {
case _DeviceTokenInitial():
return initial();case DeviceTokenLoading():
return loading();case DeviceTokenRegistered():
return registered();case DeviceTokenUnregistered():
return unregistered();case DeviceTokenError():
return error(_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  registered,TResult? Function()?  unregistered,TResult? Function( ApiErrorModel error)?  error,}) {final _that = this;
switch (_that) {
case _DeviceTokenInitial() when initial != null:
return initial();case DeviceTokenLoading() when loading != null:
return loading();case DeviceTokenRegistered() when registered != null:
return registered();case DeviceTokenUnregistered() when unregistered != null:
return unregistered();case DeviceTokenError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _DeviceTokenInitial implements DeviceTokenState {
  const _DeviceTokenInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceTokenInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DeviceTokenState.initial()';
}


}




/// @nodoc


class DeviceTokenLoading implements DeviceTokenState {
  const DeviceTokenLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceTokenLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DeviceTokenState.loading()';
}


}




/// @nodoc


class DeviceTokenRegistered implements DeviceTokenState {
  const DeviceTokenRegistered();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceTokenRegistered);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DeviceTokenState.registered()';
}


}




/// @nodoc


class DeviceTokenUnregistered implements DeviceTokenState {
  const DeviceTokenUnregistered();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceTokenUnregistered);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DeviceTokenState.unregistered()';
}


}




/// @nodoc


class DeviceTokenError implements DeviceTokenState {
  const DeviceTokenError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of DeviceTokenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceTokenErrorCopyWith<DeviceTokenError> get copyWith => _$DeviceTokenErrorCopyWithImpl<DeviceTokenError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceTokenError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'DeviceTokenState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $DeviceTokenErrorCopyWith<$Res> implements $DeviceTokenStateCopyWith<$Res> {
  factory $DeviceTokenErrorCopyWith(DeviceTokenError value, $Res Function(DeviceTokenError) _then) = _$DeviceTokenErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$DeviceTokenErrorCopyWithImpl<$Res>
    implements $DeviceTokenErrorCopyWith<$Res> {
  _$DeviceTokenErrorCopyWithImpl(this._self, this._then);

  final DeviceTokenError _self;
  final $Res Function(DeviceTokenError) _then;

/// Create a copy of DeviceTokenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(DeviceTokenError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
