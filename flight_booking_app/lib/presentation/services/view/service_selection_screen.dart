import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/core/widgets/bottom_payment_bar.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/booking_detail_screen.dart';
import 'package:flight_booking_app/presentation/services/cubit/service_selection_cubit.dart';
import 'package:flight_booking_app/presentation/services/cubit/service_selection_state.dart';
import 'package:flight_booking_app/presentation/services/view/widgets/passenger_indicator.dart';
import 'package:flight_booking_app/presentation/services/view/widgets/service_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ServiceSelectionScreen extends StatefulWidget {
  static String get routerName => '/service-selection';

  final String flightId;
  final String bookingId;
  final double totalPrice;
  final int seatCount;
  final List<Map<String, dynamic>> passengers;
  final String zoneId;

  const ServiceSelectionScreen({
    super.key,
    required this.flightId,
    required this.bookingId,
    required this.totalPrice,
    required this.seatCount,
    required this.passengers,
    this.zoneId = '',
  });

  @override
  State<ServiceSelectionScreen> createState() => _ServiceSelectionScreenState();
}

class _ServiceSelectionScreenState extends State<ServiceSelectionScreen> {
  int _currentPassengerIndex = 0;

  Map<String, dynamic> get _currentPassenger =>
      widget.passengers[_currentPassengerIndex];

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ServiceSelectionCubit>();
    cubit.setFormBaggageLevel(
      _currentPassenger['baggageLevel'] as String? ?? '',
    );
    _loadServices();
  }

  void _loadServices() {
    final cubit = context.read<ServiceSelectionCubit>();
    final zoneId = _currentPassenger['zoneId'] as String? ?? widget.zoneId;
    final ageGroup = cubit.resolveAgeGroup(
      _currentPassenger['ageGroup'] as String,
    );
    cubit.loadServices(
      flightId: widget.flightId,
      zoneId: zoneId,
      ageGroup: ageGroup,
    );
  }

  void _nextPassenger() {
    if (_currentPassengerIndex < widget.passengers.length - 1) {
      setState(() => _currentPassengerIndex++);
      final cubit = context.read<ServiceSelectionCubit>();
      cubit.setFormBaggageLevel(
        _currentPassenger['baggageLevel'] as String? ?? '',
      );
      _loadServices();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: const Text('Select Services', style: AppTextStyles.heading3),
        centerTitle: true,
      ),
      body: BlocConsumer<ServiceSelectionCubit, ServiceSelectionState>(
        listenWhen: (previous, current) =>
            previous.isSaving != current.isSaving ||
            previous.isSuccess != current.isSuccess ||
            previous.isLoading != current.isLoading,

        listener: (context, state) {
          if (state.isLoading || state.isSaving) {
            context.showLoading();
          } else {
            context.hideLoading();
          }
          if (state.isSuccess) {
            if (_currentPassengerIndex < widget.passengers.length - 1) {
              _nextPassenger();
            } else {
              context.push(
                BookingDetailScreen.routerName,
                extra: {
                  'bookingId': widget.bookingId,
                  'totalPrice': state.grandTotal,
                  'seatCount': widget.seatCount,
                },
              );
            }
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              PassengerIndicator(
                current: _currentPassengerIndex + 1,
                total: widget.passengers.length,
                name: _currentPassenger['name'] as String? ?? '',
                seatLabel: _currentPassenger['seatLabel'] as String? ?? '',
              ),
              Expanded(
                child: state.serviceGroup == null
                    ? const Center(
                        child: Text(
                          'No services available\nfor this passenger',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ServiceSection(
                              title: 'Meals',
                              icon: Icons.restaurant,
                              services: state.serviceGroup!.meals,
                              selections: state.tempSelections,
                              onToggle: (s, d) => context
                                  .read<ServiceSelectionCubit>()
                                  .toggleService(s, d),
                            ),
                            const SizedBox(height: 20),
                            ServiceSection(
                              title: 'Drinks',
                              icon: Icons.local_drink,
                              services: state.serviceGroup!.drinks,
                              selections: state.tempSelections,
                              onToggle: (s, d) => context
                                  .read<ServiceSelectionCubit>()
                                  .toggleService(s, d),
                            ),
                            const SizedBox(height: 20),
                            if ((_currentPassenger['baggageLevel'] as String?)
                                    ?.isEmpty ??
                                true)
                              ServiceSection(
                                title: 'Baggage',
                                icon: Icons.luggage,
                                services: state.serviceGroup!.baggage,
                                selections: state.tempSelections,
                                onToggle: (s, d) => context
                                    .read<ServiceSelectionCubit>()
                                    .toggleService(s, d),
                              ),
                          ],
                        ),
                      ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar:
          BlocBuilder<ServiceSelectionCubit, ServiceSelectionState>(
            builder: (context, state) {
              return BottomPaymentBar(
                price: state.grandTotal,
                buttonText:
                    _currentPassengerIndex < widget.passengers.length - 1
                    ? 'Next Passenger'
                    : 'Continue',
                onPressed: state.isSaving || state.serviceGroup == null
                    ? null
                    : () =>
                          context.read<ServiceSelectionCubit>().confirmServices(
                            bookingId: widget.bookingId,
                            passengerId:
                                _currentPassenger['passengerId'] as String,
                            seatLabel:
                                _currentPassenger['seatLabel'] as String? ?? '',
                            baggageLevel:
                                _currentPassenger['baggageLevel'] as String? ??
                                '',
                          ),
              );
            },
          ),
    );
  }
}
