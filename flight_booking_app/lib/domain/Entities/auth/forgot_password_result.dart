import 'package:equatable/equatable.dart';

class ForgotPasswordResult extends Equatable {
  final String message;
  final String? nextStep;
  final String? contact;

  const ForgotPasswordResult({
    required this.message,
    this.nextStep,
    this.contact,
  });

  @override
  List<Object?> get props => [message, nextStep, contact];
}
