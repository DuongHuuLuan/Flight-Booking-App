import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/core/widgets/bottom_payment_bar.dart';
import 'package:flight_booking_app/presentation/passenger/cubit/passenger_cubit.dart';
import 'package:flight_booking_app/presentation/passenger/cubit/passenger_state.dart';
import 'package:flight_booking_app/presentation/passenger/view/widgets/v2_passenger_form_card.dart';
import 'package:flight_booking_app/presentation/services/view/service_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PassengerDetailScreen extends StatefulWidget {
  static String get routerName => '/passenger-detail';

  final String bookingId;
  final int seatCount;
  final double basePrice;
  final String zoneId;
  final String flightId;

  const PassengerDetailScreen({
    super.key,
    required this.bookingId,
    required this.seatCount,
    required this.basePrice,
    this.zoneId = '',
    required this.flightId,
  });

  @override
  State<PassengerDetailScreen> createState() => _PassengerDetailScreenState();
}

class _PassengerDetailScreenState extends State<PassengerDetailScreen> {
  Future<void> _onSave() async {
    final cubit = context.read<PassengerCubit>();
    final success = await cubit.savePassengers(bookingId: widget.bookingId);
    if (success && mounted) {
      final passengers = cubit.state.forms.asMap().entries.map((e) {
        final i = e.key;
        final f = e.value;
        return {
          'index': i,
          'seatLabel': f.seatLabel,
          'ageGroup': f.ageGroup.name,
          'name': f.name,
          'mobilePhone': f.mobilePhone,
          'passportNumber': f.passportNumber,
          'nationality': f.nationality,
          'address': f.address,
          'email': f.email,
          'idNumber': f.idNumber,
          'baggageLevel': f.baggageLevel,
          'dateOfBirth': f.dateOfBirth?.toIso8601String(),
        };
      }).toList();
      context.push(
        ServiceSelectionScreen.routerName,
        extra: {
          'bookingId': widget.bookingId,
          'seatCount': widget.seatCount,
          'basePrice': widget.basePrice,
          'passengers': passengers,
          'zoneId': widget.zoneId,
          'flightId': widget.flightId,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Details', style: AppTextStyles.heading3),
        centerTitle: true,
      ),
      body: BlocConsumer<PassengerCubit, PassengerState>(
        listenWhen: (previous, current) =>
            previous.isLoading != current.isLoading,
        listener: (context, state) {
          if (state.isLoading) {
            context.showLoading();
          } else {
            context.hideLoading();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < state.forms.length; i++)
                        V2PassengerFormCard(
                          formData: state.forms[i],
                          index: i + 1,
                          onUpdateField: (field, value) => context
                              .read<PassengerCubit>()
                              .updateField(i, field, value),
                        ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
              BottomPaymentBar(
                price: widget.basePrice * widget.seatCount,
                buttonText: 'Continue',
                onPressed: state.isLoading ? null : _onSave,
              ),
            ],
          );
        },
      ),
    );
  }
}
