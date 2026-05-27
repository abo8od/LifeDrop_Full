import 'package:donor_app/core/networking/api_error_model.dart';
import 'package:donor_app/core/entities/districts_entity.dart';
import 'package:donor_app/core/entities/governorate_entity.dart';

enum RegisterStatus { initial, loading, success, failure }

enum GovernoratesStatus { initial, loading, success, failure }

enum DistrictsStatus { initial, loading, success, failure }

class RegisterState {
  final RegisterStatus status;
  final ApiErrorModel? error;
  final GovernoratesStatus governoratesStatus;
  final DistrictsStatus districtsStatus;
  final List<GovernorateEntity> governorates;
  final List<DistrictsEntity> districts;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.error,
    this.governoratesStatus = GovernoratesStatus.initial,
    this.districtsStatus = DistrictsStatus.initial,
    this.governorates = const [],
    this.districts = const [],
  });

  RegisterState copyWith({
    RegisterStatus? status,
    ApiErrorModel? error,
    GovernoratesStatus? governoratesStatus,
    DistrictsStatus? districtsStatus,
    List<GovernorateEntity>? governorates,
    List<DistrictsEntity>? districts,
  }) {
    return RegisterState(
      status: status ?? this.status,
      error: error ?? this.error,
      governoratesStatus: governoratesStatus ?? this.governoratesStatus,
      districtsStatus: districtsStatus ?? this.districtsStatus,
      governorates: governorates ?? this.governorates,
      districts: districts ?? this.districts,
    );
  }
}
