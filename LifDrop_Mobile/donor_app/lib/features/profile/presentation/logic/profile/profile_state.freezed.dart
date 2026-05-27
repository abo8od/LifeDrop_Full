// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState()';
}


}

/// @nodoc
class $ProfileStateCopyWith<$Res>  {
$ProfileStateCopyWith(ProfileState _, $Res Function(ProfileState) __);
}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ProfileInitial value)?  initial,TResult Function( ProfileLoading value)?  loading,TResult Function( ProfileSuccess value)?  success,TResult Function( ProfileUpdating value)?  updating,TResult Function( ProfileUpdateSuccess value)?  updateSuccess,TResult Function( ProfileError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileInitial() when initial != null:
return initial(_that);case ProfileLoading() when loading != null:
return loading(_that);case ProfileSuccess() when success != null:
return success(_that);case ProfileUpdating() when updating != null:
return updating(_that);case ProfileUpdateSuccess() when updateSuccess != null:
return updateSuccess(_that);case ProfileError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ProfileInitial value)  initial,required TResult Function( ProfileLoading value)  loading,required TResult Function( ProfileSuccess value)  success,required TResult Function( ProfileUpdating value)  updating,required TResult Function( ProfileUpdateSuccess value)  updateSuccess,required TResult Function( ProfileError value)  error,}){
final _that = this;
switch (_that) {
case _ProfileInitial():
return initial(_that);case ProfileLoading():
return loading(_that);case ProfileSuccess():
return success(_that);case ProfileUpdating():
return updating(_that);case ProfileUpdateSuccess():
return updateSuccess(_that);case ProfileError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ProfileInitial value)?  initial,TResult? Function( ProfileLoading value)?  loading,TResult? Function( ProfileSuccess value)?  success,TResult? Function( ProfileUpdating value)?  updating,TResult? Function( ProfileUpdateSuccess value)?  updateSuccess,TResult? Function( ProfileError value)?  error,}){
final _that = this;
switch (_that) {
case _ProfileInitial() when initial != null:
return initial(_that);case ProfileLoading() when loading != null:
return loading(_that);case ProfileSuccess() when success != null:
return success(_that);case ProfileUpdating() when updating != null:
return updating(_that);case ProfileUpdateSuccess() when updateSuccess != null:
return updateSuccess(_that);case ProfileError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( UserEntity user)?  success,TResult Function( UserEntity user)?  updating,TResult Function( UserEntity user,  UpdatedProfileResponseEntity response)?  updateSuccess,TResult Function( ApiErrorModel error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileInitial() when initial != null:
return initial();case ProfileLoading() when loading != null:
return loading();case ProfileSuccess() when success != null:
return success(_that.user);case ProfileUpdating() when updating != null:
return updating(_that.user);case ProfileUpdateSuccess() when updateSuccess != null:
return updateSuccess(_that.user,_that.response);case ProfileError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( UserEntity user)  success,required TResult Function( UserEntity user)  updating,required TResult Function( UserEntity user,  UpdatedProfileResponseEntity response)  updateSuccess,required TResult Function( ApiErrorModel error)  error,}) {final _that = this;
switch (_that) {
case _ProfileInitial():
return initial();case ProfileLoading():
return loading();case ProfileSuccess():
return success(_that.user);case ProfileUpdating():
return updating(_that.user);case ProfileUpdateSuccess():
return updateSuccess(_that.user,_that.response);case ProfileError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( UserEntity user)?  success,TResult? Function( UserEntity user)?  updating,TResult? Function( UserEntity user,  UpdatedProfileResponseEntity response)?  updateSuccess,TResult? Function( ApiErrorModel error)?  error,}) {final _that = this;
switch (_that) {
case _ProfileInitial() when initial != null:
return initial();case ProfileLoading() when loading != null:
return loading();case ProfileSuccess() when success != null:
return success(_that.user);case ProfileUpdating() when updating != null:
return updating(_that.user);case ProfileUpdateSuccess() when updateSuccess != null:
return updateSuccess(_that.user,_that.response);case ProfileError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileInitial implements ProfileState {
  const _ProfileInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState.initial()';
}


}




/// @nodoc


class ProfileLoading implements ProfileState {
  const ProfileLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState.loading()';
}


}




/// @nodoc


class ProfileSuccess implements ProfileState {
  const ProfileSuccess(this.user);
  

 final  UserEntity user;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSuccessCopyWith<ProfileSuccess> get copyWith => _$ProfileSuccessCopyWithImpl<ProfileSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSuccess&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'ProfileState.success(user: $user)';
}


}

/// @nodoc
abstract mixin class $ProfileSuccessCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileSuccessCopyWith(ProfileSuccess value, $Res Function(ProfileSuccess) _then) = _$ProfileSuccessCopyWithImpl;
@useResult
$Res call({
 UserEntity user
});




}
/// @nodoc
class _$ProfileSuccessCopyWithImpl<$Res>
    implements $ProfileSuccessCopyWith<$Res> {
  _$ProfileSuccessCopyWithImpl(this._self, this._then);

  final ProfileSuccess _self;
  final $Res Function(ProfileSuccess) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(ProfileSuccess(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity,
  ));
}


}

/// @nodoc


class ProfileUpdating implements ProfileState {
  const ProfileUpdating(this.user);
  

 final  UserEntity user;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileUpdatingCopyWith<ProfileUpdating> get copyWith => _$ProfileUpdatingCopyWithImpl<ProfileUpdating>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileUpdating&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'ProfileState.updating(user: $user)';
}


}

/// @nodoc
abstract mixin class $ProfileUpdatingCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileUpdatingCopyWith(ProfileUpdating value, $Res Function(ProfileUpdating) _then) = _$ProfileUpdatingCopyWithImpl;
@useResult
$Res call({
 UserEntity user
});




}
/// @nodoc
class _$ProfileUpdatingCopyWithImpl<$Res>
    implements $ProfileUpdatingCopyWith<$Res> {
  _$ProfileUpdatingCopyWithImpl(this._self, this._then);

  final ProfileUpdating _self;
  final $Res Function(ProfileUpdating) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(ProfileUpdating(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity,
  ));
}


}

/// @nodoc


class ProfileUpdateSuccess implements ProfileState {
  const ProfileUpdateSuccess(this.user, this.response);
  

 final  UserEntity user;
 final  UpdatedProfileResponseEntity response;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileUpdateSuccessCopyWith<ProfileUpdateSuccess> get copyWith => _$ProfileUpdateSuccessCopyWithImpl<ProfileUpdateSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileUpdateSuccess&&(identical(other.user, user) || other.user == user)&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,user,response);

@override
String toString() {
  return 'ProfileState.updateSuccess(user: $user, response: $response)';
}


}

/// @nodoc
abstract mixin class $ProfileUpdateSuccessCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileUpdateSuccessCopyWith(ProfileUpdateSuccess value, $Res Function(ProfileUpdateSuccess) _then) = _$ProfileUpdateSuccessCopyWithImpl;
@useResult
$Res call({
 UserEntity user, UpdatedProfileResponseEntity response
});




}
/// @nodoc
class _$ProfileUpdateSuccessCopyWithImpl<$Res>
    implements $ProfileUpdateSuccessCopyWith<$Res> {
  _$ProfileUpdateSuccessCopyWithImpl(this._self, this._then);

  final ProfileUpdateSuccess _self;
  final $Res Function(ProfileUpdateSuccess) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,Object? response = null,}) {
  return _then(ProfileUpdateSuccess(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity,null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as UpdatedProfileResponseEntity,
  ));
}


}

/// @nodoc


class ProfileError implements ProfileState {
  const ProfileError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileErrorCopyWith<ProfileError> get copyWith => _$ProfileErrorCopyWithImpl<ProfileError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ProfileState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ProfileErrorCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileErrorCopyWith(ProfileError value, $Res Function(ProfileError) _then) = _$ProfileErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$ProfileErrorCopyWithImpl<$Res>
    implements $ProfileErrorCopyWith<$Res> {
  _$ProfileErrorCopyWithImpl(this._self, this._then);

  final ProfileError _self;
  final $Res Function(ProfileError) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ProfileError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
