import 'package:equatable/equatable.dart';

class CooldownEntity extends Equatable {
  final DateTime nextEligibleDate;
  final int daysRemaining;
  final bool isEligible;

  const CooldownEntity({
    required this.nextEligibleDate,
    required this.daysRemaining,
    required this.isEligible,
  });

  factory CooldownEntity.placeholder() => CooldownEntity(
    nextEligibleDate: DateTime.now(),
    daysRemaining: 0,
    isEligible: false,
  );

  @override
  List<Object?> get props => [nextEligibleDate, daysRemaining, isEligible];
}
