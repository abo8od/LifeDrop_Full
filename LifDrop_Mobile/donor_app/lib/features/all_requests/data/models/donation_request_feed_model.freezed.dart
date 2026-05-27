// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'donation_request_feed_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DonationRequestFeedModel {

 String get requestId; String get hospitalName; String get governorateName; BloodType get requiredBloodType; int get targetQuota; int get remainingQuota; UrgencyStatus get urgency; DateTime get expiryDate; int get distancePriority; double get hospitalLatitude; double get hospitalLongitude;
/// Create a copy of DonationRequestFeedModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonationRequestFeedModelCopyWith<DonationRequestFeedModel> get copyWith => _$DonationRequestFeedModelCopyWithImpl<DonationRequestFeedModel>(this as DonationRequestFeedModel, _$identity);

  /// Serializes this DonationRequestFeedModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonationRequestFeedModel&&super == other&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.hospitalName, hospitalName) || other.hospitalName == hospitalName)&&(identical(other.governorateName, governorateName) || other.governorateName == governorateName)&&(identical(other.requiredBloodType, requiredBloodType) || other.requiredBloodType == requiredBloodType)&&(identical(other.targetQuota, targetQuota) || other.targetQuota == targetQuota)&&(identical(other.remainingQuota, remainingQuota) || other.remainingQuota == remainingQuota)&&(identical(other.urgency, urgency) || other.urgency == urgency)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.distancePriority, distancePriority) || other.distancePriority == distancePriority)&&(identical(other.hospitalLatitude, hospitalLatitude) || other.hospitalLatitude == hospitalLatitude)&&(identical(other.hospitalLongitude, hospitalLongitude) || other.hospitalLongitude == hospitalLongitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,super.hashCode,requestId,hospitalName,governorateName,requiredBloodType,targetQuota,remainingQuota,urgency,expiryDate,distancePriority,hospitalLatitude,hospitalLongitude);



}

/// @nodoc
abstract mixin class $DonationRequestFeedModelCopyWith<$Res>  {
  factory $DonationRequestFeedModelCopyWith(DonationRequestFeedModel value, $Res Function(DonationRequestFeedModel) _then) = _$DonationRequestFeedModelCopyWithImpl;
@useResult
$Res call({
 String requestId, String hospitalName, String governorateName, BloodType requiredBloodType, int targetQuota, int remainingQuota, UrgencyStatus urgency, DateTime expiryDate, int distancePriority, double hospitalLatitude, double hospitalLongitude
});




}
/// @nodoc
class _$DonationRequestFeedModelCopyWithImpl<$Res>
    implements $DonationRequestFeedModelCopyWith<$Res> {
  _$DonationRequestFeedModelCopyWithImpl(this._self, this._then);

  final DonationRequestFeedModel _self;
  final $Res Function(DonationRequestFeedModel) _then;

/// Create a copy of DonationRequestFeedModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requestId = null,Object? hospitalName = null,Object? governorateName = null,Object? requiredBloodType = null,Object? targetQuota = null,Object? remainingQuota = null,Object? urgency = null,Object? expiryDate = null,Object? distancePriority = null,Object? hospitalLatitude = null,Object? hospitalLongitude = null,}) {
  return _then(_self.copyWith(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,hospitalName: null == hospitalName ? _self.hospitalName : hospitalName // ignore: cast_nullable_to_non_nullable
as String,governorateName: null == governorateName ? _self.governorateName : governorateName // ignore: cast_nullable_to_non_nullable
as String,requiredBloodType: null == requiredBloodType ? _self.requiredBloodType : requiredBloodType // ignore: cast_nullable_to_non_nullable
as BloodType,targetQuota: null == targetQuota ? _self.targetQuota : targetQuota // ignore: cast_nullable_to_non_nullable
as int,remainingQuota: null == remainingQuota ? _self.remainingQuota : remainingQuota // ignore: cast_nullable_to_non_nullable
as int,urgency: null == urgency ? _self.urgency : urgency // ignore: cast_nullable_to_non_nullable
as UrgencyStatus,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,distancePriority: null == distancePriority ? _self.distancePriority : distancePriority // ignore: cast_nullable_to_non_nullable
as int,hospitalLatitude: null == hospitalLatitude ? _self.hospitalLatitude : hospitalLatitude // ignore: cast_nullable_to_non_nullable
as double,hospitalLongitude: null == hospitalLongitude ? _self.hospitalLongitude : hospitalLongitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DonationRequestFeedModel].
extension DonationRequestFeedModelPatterns on DonationRequestFeedModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DonationRequestFeedModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DonationRequestFeedModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DonationRequestFeedModel value)  $default,){
final _that = this;
switch (_that) {
case _DonationRequestFeedModel():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DonationRequestFeedModel value)?  $default,){
final _that = this;
switch (_that) {
case _DonationRequestFeedModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String requestId,  String hospitalName,  String governorateName,  BloodType requiredBloodType,  int targetQuota,  int remainingQuota,  UrgencyStatus urgency,  DateTime expiryDate,  int distancePriority,  double hospitalLatitude,  double hospitalLongitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DonationRequestFeedModel() when $default != null:
return $default(_that.requestId,_that.hospitalName,_that.governorateName,_that.requiredBloodType,_that.targetQuota,_that.remainingQuota,_that.urgency,_that.expiryDate,_that.distancePriority,_that.hospitalLatitude,_that.hospitalLongitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String requestId,  String hospitalName,  String governorateName,  BloodType requiredBloodType,  int targetQuota,  int remainingQuota,  UrgencyStatus urgency,  DateTime expiryDate,  int distancePriority,  double hospitalLatitude,  double hospitalLongitude)  $default,) {final _that = this;
switch (_that) {
case _DonationRequestFeedModel():
return $default(_that.requestId,_that.hospitalName,_that.governorateName,_that.requiredBloodType,_that.targetQuota,_that.remainingQuota,_that.urgency,_that.expiryDate,_that.distancePriority,_that.hospitalLatitude,_that.hospitalLongitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String requestId,  String hospitalName,  String governorateName,  BloodType requiredBloodType,  int targetQuota,  int remainingQuota,  UrgencyStatus urgency,  DateTime expiryDate,  int distancePriority,  double hospitalLatitude,  double hospitalLongitude)?  $default,) {final _that = this;
switch (_that) {
case _DonationRequestFeedModel() when $default != null:
return $default(_that.requestId,_that.hospitalName,_that.governorateName,_that.requiredBloodType,_that.targetQuota,_that.remainingQuota,_that.urgency,_that.expiryDate,_that.distancePriority,_that.hospitalLatitude,_that.hospitalLongitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DonationRequestFeedModel extends DonationRequestFeedModel {
  const _DonationRequestFeedModel({required this.requestId, required this.hospitalName, required this.governorateName, required this.requiredBloodType, required this.targetQuota, required this.remainingQuota, required this.urgency, required this.expiryDate, required this.distancePriority, required this.hospitalLatitude, required this.hospitalLongitude}): super._();
  factory _DonationRequestFeedModel.fromJson(Map<String, dynamic> json) => _$DonationRequestFeedModelFromJson(json);

@override final  String requestId;
@override final  String hospitalName;
@override final  String governorateName;
@override final  BloodType requiredBloodType;
@override final  int targetQuota;
@override final  int remainingQuota;
@override final  UrgencyStatus urgency;
@override final  DateTime expiryDate;
@override final  int distancePriority;
@override final  double hospitalLatitude;
@override final  double hospitalLongitude;

/// Create a copy of DonationRequestFeedModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DonationRequestFeedModelCopyWith<_DonationRequestFeedModel> get copyWith => __$DonationRequestFeedModelCopyWithImpl<_DonationRequestFeedModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DonationRequestFeedModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DonationRequestFeedModel&&super == other&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.hospitalName, hospitalName) || other.hospitalName == hospitalName)&&(identical(other.governorateName, governorateName) || other.governorateName == governorateName)&&(identical(other.requiredBloodType, requiredBloodType) || other.requiredBloodType == requiredBloodType)&&(identical(other.targetQuota, targetQuota) || other.targetQuota == targetQuota)&&(identical(other.remainingQuota, remainingQuota) || other.remainingQuota == remainingQuota)&&(identical(other.urgency, urgency) || other.urgency == urgency)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.distancePriority, distancePriority) || other.distancePriority == distancePriority)&&(identical(other.hospitalLatitude, hospitalLatitude) || other.hospitalLatitude == hospitalLatitude)&&(identical(other.hospitalLongitude, hospitalLongitude) || other.hospitalLongitude == hospitalLongitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,super.hashCode,requestId,hospitalName,governorateName,requiredBloodType,targetQuota,remainingQuota,urgency,expiryDate,distancePriority,hospitalLatitude,hospitalLongitude);



}

/// @nodoc
abstract mixin class _$DonationRequestFeedModelCopyWith<$Res> implements $DonationRequestFeedModelCopyWith<$Res> {
  factory _$DonationRequestFeedModelCopyWith(_DonationRequestFeedModel value, $Res Function(_DonationRequestFeedModel) _then) = __$DonationRequestFeedModelCopyWithImpl;
@override @useResult
$Res call({
 String requestId, String hospitalName, String governorateName, BloodType requiredBloodType, int targetQuota, int remainingQuota, UrgencyStatus urgency, DateTime expiryDate, int distancePriority, double hospitalLatitude, double hospitalLongitude
});




}
/// @nodoc
class __$DonationRequestFeedModelCopyWithImpl<$Res>
    implements _$DonationRequestFeedModelCopyWith<$Res> {
  __$DonationRequestFeedModelCopyWithImpl(this._self, this._then);

  final _DonationRequestFeedModel _self;
  final $Res Function(_DonationRequestFeedModel) _then;

/// Create a copy of DonationRequestFeedModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? hospitalName = null,Object? governorateName = null,Object? requiredBloodType = null,Object? targetQuota = null,Object? remainingQuota = null,Object? urgency = null,Object? expiryDate = null,Object? distancePriority = null,Object? hospitalLatitude = null,Object? hospitalLongitude = null,}) {
  return _then(_DonationRequestFeedModel(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,hospitalName: null == hospitalName ? _self.hospitalName : hospitalName // ignore: cast_nullable_to_non_nullable
as String,governorateName: null == governorateName ? _self.governorateName : governorateName // ignore: cast_nullable_to_non_nullable
as String,requiredBloodType: null == requiredBloodType ? _self.requiredBloodType : requiredBloodType // ignore: cast_nullable_to_non_nullable
as BloodType,targetQuota: null == targetQuota ? _self.targetQuota : targetQuota // ignore: cast_nullable_to_non_nullable
as int,remainingQuota: null == remainingQuota ? _self.remainingQuota : remainingQuota // ignore: cast_nullable_to_non_nullable
as int,urgency: null == urgency ? _self.urgency : urgency // ignore: cast_nullable_to_non_nullable
as UrgencyStatus,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,distancePriority: null == distancePriority ? _self.distancePriority : distancePriority // ignore: cast_nullable_to_non_nullable
as int,hospitalLatitude: null == hospitalLatitude ? _self.hospitalLatitude : hospitalLatitude // ignore: cast_nullable_to_non_nullable
as double,hospitalLongitude: null == hospitalLongitude ? _self.hospitalLongitude : hospitalLongitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
