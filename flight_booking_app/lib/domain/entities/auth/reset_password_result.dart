import 'package:equatable/equatable.dart';

class ResetPasswordResult extends Equatable {
  final String message;
  final bool success;

  const ResetPasswordResult({required this.message, this.success = true});

  @override
  List<Object?> get props => [message, success];
}
