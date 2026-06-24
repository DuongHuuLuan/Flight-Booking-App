import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/core/widgets/bottom_payment_bar.dart';
import 'package:flight_booking_app/domain/entities/passenger_entity.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/booking_detail_screen.dart';
import 'package:flight_booking_app/presentation/passenger/cubit/passenger_cubit.dart';
import 'package:flight_booking_app/presentation/passenger/cubit/passenger_state.dart';
import 'package:flight_booking_app/presentation/passenger/view/widgets/passenger_form_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PassengerDetailScreen extends StatefulWidget {
  static String get routerName => '/passenger-detail';

  final String bookingId;
  final int seatCount;
  final double basePrice;

  const PassengerDetailScreen({
    super.key,
    required this.bookingId,
    required this.seatCount,
    required this.basePrice,
  });

  @override
  State<PassengerDetailScreen> createState() => _PassengerDetailScreenState();
}

class _PassengerDetailScreenState extends State<PassengerDetailScreen> {
  late final List<PassengerFormData> _formDataList;

  @override
  void initState() {
    super.initState();
    _formDataList = List.generate(widget.seatCount, (_) => PassengerFormData());
  }

  @override
  void dispose() {
    for (final fd in _formDataList) {
      fd.dispose();
    }
    super.dispose();
  }

  void _onSave() {
    final cubit = context.read<PassengerCubit>();
    final passengers = _formDataList.map((fd) {
      final parts = fd.dobController.text.split('/');
      final dob = parts.length == 3
          ? DateTime(
              int.parse(parts[2]),
              int.parse(parts[1]),
              int.parse(parts[0]),
            )
          : DateTime.now();
      return PassengerEntity(
        id: '',
        bookingId: widget.bookingId,
        name: fd.nameController.text,
        mobilePhone: fd.mobilePhoneController.text,
        dateOfBirth: dob,
        passportNumber: fd.passportController.text,
        nationality: fd.nationalityController.text,
      );
    }).toList();

    cubit.savePassengers(bookingId: widget.bookingId, passengers: passengers);
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
            previous.isLoading != current.isLoading ||
            previous.isSuccess != current.isSuccess,
        listener: (context, state) {
          if (state.isLoading) {
            context.showLoading();
          } else {
            context.hideLoading();
          }
          if (state.isSuccess && context.mounted) {
            context.push(
              BookingDetailScreen.routerName,
              extra: {
                'bookingId': widget.bookingId,
                'basePrice': widget.basePrice,
                'seatCount': widget.seatCount,
              },
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < widget.seatCount; i++)
                        PassengerFormCard(
                          formData: _formDataList[i],
                          index: i + 1,
                        ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
              BottomPaymentBar(
                price: widget.basePrice * widget.seatCount,
                buttonText: 'Save',
                onPressed: state.isLoading ? null : _onSave,
              ),
            ],
          );
        },
      ),
    );
  }
}
