import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/core/widgets/bottom_payment_bar.dart';
import 'package:flight_booking_app/domain/entities/seat/service_entity.dart';
import 'package:flight_booking_app/domain/enums/age_group.dart';
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
  final double basePrice;
  final int seatCount;
  final List<Map<String, dynamic>> passengers;
  final String zoneId;

  const ServiceSelectionScreen({
    super.key,
    required this.flightId,
    required this.bookingId,
    required this.basePrice,
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

  AgeGroup get _ageGroup => AgeGroup.values.firstWhere(
    (ag) => ag.name == _currentPassenger['ageGroup'],
  );

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  void _loadServices() {
    final zoneId = _currentPassenger['zoneId'] as String? ?? widget.zoneId;
    final ageGroup = _ageGroup;
    context.read<ServiceSelectionCubit>().loadServices(
      flightId: widget.flightId,
      zoneId: zoneId,
      ageGroup: ageGroup,
    );
  }

  void _nextPassenger() {
    if (_currentPassengerIndex < widget.passengers.length - 1) {
      setState(() => _currentPassengerIndex++);
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
            previous.isSuccess != current.isSuccess,
        listener: (context, state) {
          if (state.isLoading || state.isSaving) {
            context.showLoading();
          } else {
            context.hideLoading();
          }
          if (state.isSuccess) {
            if (_currentPassengerIndex < widget.passengers.length - 1) {
              context.read<ServiceSelectionCubit>().reset();
              _nextPassenger();
            } else {
              context.push(
                BookingDetailScreen.routerName,
                extra: {
                  'bookingId': widget.bookingId,
                  'basePrice': widget.basePrice,
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
              final serviceTotal = state.serviceGroup == null
                  ? 0.0
                  : state.tempSelections.entries.fold<double>(0, (sum, e) {
                      final allServices = [
                        ...state.serviceGroup!.meals,
                        ...state.serviceGroup!.drinks,
                        ...state.serviceGroup!.baggage,
                      ];
                      final svc = allServices.firstWhere(
                        (s) => s.serviceId == e.key,
                        orElse: () => const ServiceEntity(
                          serviceId: '',
                          type: '',
                          name: '',
                          price: 0,
                          maxPerPassenger: 0,
                        ),
                      );
                      return sum + svc.price * e.value;
                    });
              return BottomPaymentBar(
                price: widget.basePrice * widget.seatCount + serviceTotal,
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
