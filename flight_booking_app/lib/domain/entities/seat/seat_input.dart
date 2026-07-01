import 'package:equatable/equatable.dart';

class SeatInput extends Equatable {
  final String seatLabel;
  final String zoneId;

  const SeatInput({required this.seatLabel, required this.zoneId});

  @override
  List<Object?> get props => [seatLabel, zoneId];
}
