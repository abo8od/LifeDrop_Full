// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'donation_request_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DonationRequestState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonationRequestState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DonationRequestState()';
}


}

/// @nodoc
class $DonationRequestStateCopyWith<$Res>  {
$DonationRequestStateCopyWith(DonationRequestState _, $Res Function(DonationRequestState) __);
}


/// Adds pattern-matching-related methods to [DonationRequestState].
extension DonationRequestStatePatterns on DonationRequestState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _DonationRequestInitial value)?  initial,TResult Function( DonationRequestDetailsLoading value)?  detailsLoading,TResult Function( DonationRequestDetailsSuccess value)?  detailsSuccess,TResult Function( DonationRequestDetailsError value)?  detailsError,TResult Function( DonationRequestAcceptLoading value)?  acceptLoading,TResult Function( DonationRequestAcceptSuccess value)?  acceptSuccess,TResult Function( DonationRequestAcceptError value)?  acceptError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DonationRequestInitial() when initial != null:
return initial(_that);case DonationRequestDetailsLoading() when detailsLoading != null:
return detailsLoading(_that);case DonationRequestDetailsSuccess() when detailsSuccess != null:
return detailsSuccess(_that);case DonationRequestDetailsError() when detailsError != null:
return detailsError(_that);case DonationRequestAcceptLoading() when acceptLoading != null:
return acceptLoading(_that);case DonationRequestAcceptSuccess() when acceptSuccess != null:
return acceptSuccess(_that);case DonationRequestAcceptError() when acceptError != null:
return acceptError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _DonationRequestInitial value)  initial,required TResult Function( DonationRequestDetailsLoading value)  detailsLoading,required TResult Function( DonationRequestDetailsSuccess value)  detailsSuccess,required TResult Function( DonationRequestDetailsError value)  detailsError,required TResult Function( DonationRequestAcceptLoading value)  acceptLoading,required TResult Function( DonationRequestAcceptSuccess value)  acceptSuccess,required TResult Function( DonationRequestAcceptError value)  acceptError,}){
final _that = this;
switch (_that) {
case _DonationRequestInitial():
return initial(_that);case DonationRequestDetailsLoading():
return detailsLoading(_that);case DonationRequestDetailsSuccess():
return detailsSuccess(_that);case DonationRequestDetailsError():
return detailsError(_that);case DonationRequestAcceptLoading():
return acceptLoading(_that);case DonationRequestAcceptSuccess():
return acceptSuccess(_that);case DonationRequestAcceptError():
return acceptError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _DonationRequestInitial value)?  initial,TResult? Function( DonationRequestDetailsLoading value)?  detailsLoading,TResult? Function( DonationRequestDetailsSuccess value)?  detailsSuccess,TResult? Function( DonationRequestDetailsError value)?  detailsError,TResult? Function( DonationRequestAcceptLoading value)?  acceptLoading,TResult? Function( DonationRequestAcceptSuccess value)?  acceptSuccess,TResult? Function( DonationRequestAcceptError value)?  acceptError,}){
final _that = this;
switch (_that) {
case _DonationRequestInitial() when initial != null:
return initial(_that);case DonationRequestDetailsLoading() when detailsLoading != null:
return detailsLoading(_that);case DonationRequestDetailsSuccess() when detailsSuccess != null:
return detailsSuccess(_that);case DonationRequestDetailsError() when detailsError != null:
return detailsError(_that);case DonationRequestAcceptLoading() when acceptLoading != null:
return acceptLoading(_that);case DonationRequestAcceptSuccess() when acceptSuccess != null:
return acceptSuccess(_that);case DonationRequestAcceptError() when acceptError != null:
return acceptError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  detailsLoading,TResult Function( RequestDetailsEntity request)?  detailsSuccess,TResult Function( ApiErrorModel error)?  detailsError,TResult Function( RequestDetailsEntity request)?  acceptLoading,TResult Function( AcceptanceEntity acceptance,  RequestDetailsEntity request)?  acceptSuccess,TResult Function( ApiErrorModel error,  RequestDetailsEntity request)?  acceptError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DonationRequestInitial() when initial != null:
return initial();case DonationRequestDetailsLoading() when detailsLoading != null:
return detailsLoading();case DonationRequestDetailsSuccess() when detailsSuccess != null:
return detailsSuccess(_that.request);case DonationRequestDetailsError() when detailsError != null:
return detailsError(_that.error);case DonationRequestAcceptLoading() when acceptLoading != null:
return acceptLoading(_that.request);case DonationRequestAcceptSuccess() when acceptSuccess != null:
return acceptSuccess(_that.acceptance,_that.request);case DonationRequestAcceptError() when acceptError != null:
return acceptError(_that.error,_that.request);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  detailsLoading,required TResult Function( RequestDetailsEntity request)  detailsSuccess,required TResult Function( ApiErrorModel error)  detailsError,required TResult Function( RequestDetailsEntity request)  acceptLoading,required TResult Function( AcceptanceEntity acceptance,  RequestDetailsEntity request)  acceptSuccess,required TResult Function( ApiErrorModel error,  RequestDetailsEntity request)  acceptError,}) {final _that = this;
switch (_that) {
case _DonationRequestInitial():
return initial();case DonationRequestDetailsLoading():
return detailsLoading();case DonationRequestDetailsSuccess():
return detailsSuccess(_that.request);case DonationRequestDetailsError():
return detailsError(_that.error);case DonationRequestAcceptLoading():
return acceptLoading(_that.request);case DonationRequestAcceptSuccess():
return acceptSuccess(_that.acceptance,_that.request);case DonationRequestAcceptError():
return acceptError(_that.error,_that.request);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  detailsLoading,TResult? Function( RequestDetailsEntity request)?  detailsSuccess,TResult? Function( ApiErrorModel error)?  detailsError,TResult? Function( RequestDetailsEntity request)?  acceptLoading,TResult? Function( AcceptanceEntity acceptance,  RequestDetailsEntity request)?  acceptSuccess,TResult? Function( ApiErrorModel error,  RequestDetailsEntity request)?  acceptError,}) {final _that = this;
switch (_that) {
case _DonationRequestInitial() when initial != null:
return initial();case DonationRequestDetailsLoading() when detailsLoading != null:
return detailsLoading();case DonationRequestDetailsSuccess() when detailsSuccess != null:
return detailsSuccess(_that.request);case DonationRequestDetailsError() when detailsError != null:
return detailsError(_that.error);case DonationRequestAcceptLoading() when acceptLoading != null:
return acceptLoading(_that.request);case DonationRequestAcceptSuccess() when acceptSuccess != null:
return acceptSuccess(_that.acceptance,_that.request);case DonationRequestAcceptError() when acceptError != null:
return acceptError(_that.error,_that.request);case _:
  return null;

}
}

}

/// @nodoc


class _DonationRequestInitial implements DonationRequestState {
  const _DonationRequestInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DonationRequestInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DonationRequestState.initial()';
}


}




/// @nodoc


class DonationRequestDetailsLoading implements DonationRequestState {
  const DonationRequestDetailsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonationRequestDetailsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DonationRequestState.detailsLoading()';
}


}




/// @nodoc


class DonationRequestDetailsSuccess implements DonationRequestState {
  const DonationRequestDetailsSuccess(this.request);
  

 final  RequestDetailsEntity request;

/// Create a copy of DonationRequestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonationRequestDetailsSuccessCopyWith<DonationRequestDetailsSuccess> get copyWith => _$DonationRequestDetailsSuccessCopyWithImpl<DonationRequestDetailsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonationRequestDetailsSuccess&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'DonationRequestState.detailsSuccess(request: $request)';
}


}

/// @nodoc
abstract mixin class $DonationRequestDetailsSuccessCopyWith<$Res> implements $DonationRequestStateCopyWith<$Res> {
  factory $DonationRequestDetailsSuccessCopyWith(DonationRequestDetailsSuccess value, $Res Function(DonationRequestDetailsSuccess) _then) = _$DonationRequestDetailsSuccessCopyWithImpl;
@useResult
$Res call({
 RequestDetailsEntity request
});




}
/// @nodoc
class _$DonationRequestDetailsSuccessCopyWithImpl<$Res>
    implements $DonationRequestDetailsSuccessCopyWith<$Res> {
  _$DonationRequestDetailsSuccessCopyWithImpl(this._self, this._then);

  final DonationRequestDetailsSuccess _self;
  final $Res Function(DonationRequestDetailsSuccess) _then;

/// Create a copy of DonationRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(DonationRequestDetailsSuccess(
null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as RequestDetailsEntity,
  ));
}


}

/// @nodoc


class DonationRequestDetailsError implements DonationRequestState {
  const DonationRequestDetailsError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of DonationRequestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonationRequestDetailsErrorCopyWith<DonationRequestDetailsError> get copyWith => _$DonationRequestDetailsErrorCopyWithImpl<DonationRequestDetailsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonationRequestDetailsError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'DonationRequestState.detailsError(error: $error)';
}


}

/// @nodoc
abstract mixin class $DonationRequestDetailsErrorCopyWith<$Res> implements $DonationRequestStateCopyWith<$Res> {
  factory $DonationRequestDetailsErrorCopyWith(DonationRequestDetailsError value, $Res Function(DonationRequestDetailsError) _then) = _$DonationRequestDetailsErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$DonationRequestDetailsErrorCopyWithImpl<$Res>
    implements $DonationRequestDetailsErrorCopyWith<$Res> {
  _$DonationRequestDetailsErrorCopyWithImpl(this._self, this._then);

  final DonationRequestDetailsError _self;
  final $Res Function(DonationRequestDetailsError) _then;

/// Create a copy of DonationRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(DonationRequestDetailsError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

/// @nodoc


class DonationRequestAcceptLoading implements DonationRequestState {
  const DonationRequestAcceptLoading(this.request);
  

 final  RequestDetailsEntity request;

/// Create a copy of DonationRequestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonationRequestAcceptLoadingCopyWith<DonationRequestAcceptLoading> get copyWith => _$DonationRequestAcceptLoadingCopyWithImpl<DonationRequestAcceptLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonationRequestAcceptLoading&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'DonationRequestState.acceptLoading(request: $request)';
}


}

/// @nodoc
abstract mixin class $DonationRequestAcceptLoadingCopyWith<$Res> implements $DonationRequestStateCopyWith<$Res> {
  factory $DonationRequestAcceptLoadingCopyWith(DonationRequestAcceptLoading value, $Res Function(DonationRequestAcceptLoading) _then) = _$DonationRequestAcceptLoadingCopyWithImpl;
@useResult
$Res call({
 RequestDetailsEntity request
});




}
/// @nodoc
class _$DonationRequestAcceptLoadingCopyWithImpl<$Res>
    implements $DonationRequestAcceptLoadingCopyWith<$Res> {
  _$DonationRequestAcceptLoadingCopyWithImpl(this._self, this._then);

  final DonationRequestAcceptLoading _self;
  final $Res Function(DonationRequestAcceptLoading) _then;

/// Create a copy of DonationRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(DonationRequestAcceptLoading(
null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as RequestDetailsEntity,
  ));
}


}

/// @nodoc


class DonationRequestAcceptSuccess implements DonationRequestState {
  const DonationRequestAcceptSuccess(this.acceptance, this.request);
  

 final  AcceptanceEntity acceptance;
 final  RequestDetailsEntity request;

/// Create a copy of DonationRequestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonationRequestAcceptSuccessCopyWith<DonationRequestAcceptSuccess> get copyWith => _$DonationRequestAcceptSuccessCopyWithImpl<DonationRequestAcceptSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonationRequestAcceptSuccess&&(identical(other.acceptance, acceptance) || other.acceptance == acceptance)&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,acceptance,request);

@override
String toString() {
  return 'DonationRequestState.acceptSuccess(acceptance: $acceptance, request: $request)';
}


}

/// @nodoc
abstract mixin class $DonationRequestAcceptSuccessCopyWith<$Res> implements $DonationRequestStateCopyWith<$Res> {
  factory $DonationRequestAcceptSuccessCopyWith(DonationRequestAcceptSuccess value, $Res Function(DonationRequestAcceptSuccess) _then) = _$DonationRequestAcceptSuccessCopyWithImpl;
@useResult
$Res call({
 AcceptanceEntity acceptance, RequestDetailsEntity request
});




}
/// @nodoc
class _$DonationRequestAcceptSuccessCopyWithImpl<$Res>
    implements $DonationRequestAcceptSuccessCopyWith<$Res> {
  _$DonationRequestAcceptSuccessCopyWithImpl(this._self, this._then);

  final DonationRequestAcceptSuccess _self;
  final $Res Function(DonationRequestAcceptSuccess) _then;

/// Create a copy of DonationRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? acceptance = null,Object? request = null,}) {
  return _then(DonationRequestAcceptSuccess(
null == acceptance ? _self.acceptance : acceptance // ignore: cast_nullable_to_non_nullable
as AcceptanceEntity,null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as RequestDetailsEntity,
  ));
}


}

/// @nodoc


class DonationRequestAcceptError implements DonationRequestState {
  const DonationRequestAcceptError(this.error, this.request);
  

 final  ApiErrorModel error;
 final  RequestDetailsEntity request;

/// Create a copy of DonationRequestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonationRequestAcceptErrorCopyWith<DonationRequestAcceptError> get copyWith => _$DonationRequestAcceptErrorCopyWithImpl<DonationRequestAcceptError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonationRequestAcceptError&&(identical(other.error, error) || other.error == error)&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,error,request);

@override
String toString() {
  return 'DonationRequestState.acceptError(error: $error, request: $request)';
}


}

/// @nodoc
abstract mixin class $DonationRequestAcceptErrorCopyWith<$Res> implements $DonationRequestStateCopyWith<$Res> {
  factory $DonationRequestAcceptErrorCopyWith(DonationRequestAcceptError value, $Res Function(DonationRequestAcceptError) _then) = _$DonationRequestAcceptErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error, RequestDetailsEntity request
});




}
/// @nodoc
class _$DonationRequestAcceptErrorCopyWithImpl<$Res>
    implements $DonationRequestAcceptErrorCopyWith<$Res> {
  _$DonationRequestAcceptErrorCopyWithImpl(this._self, this._then);

  final DonationRequestAcceptError _self;
  final $Res Function(DonationRequestAcceptError) _then;

/// Create a copy of DonationRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,Object? request = null,}) {
  return _then(DonationRequestAcceptError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as RequestDetailsEntity,
  ));
}


}

// dart format on
