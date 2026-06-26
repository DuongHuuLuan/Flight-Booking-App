import 'package:flight_booking_app/presentation/flight/select_seat/cubit/select_seat_state.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/view/widgets/seat_grid.dart';
import 'package:flutter/material.dart';

class SeatMapView extends StatelessWidget {
  final SelectSeatState state;
  final void Function(String seatLabel) onSeatTap;

  const SeatMapView({super.key, required this.state, required this.onSeatTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/select_seat.png',
          width: double.infinity,
          fit: BoxFit.contain,
        ),
        SingleChildScrollView(
          child: SeatGrid(state: state, onSeatTap: onSeatTap),
        ),
      ],
    );
  }
}
