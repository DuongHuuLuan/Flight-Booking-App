import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/core/widgets/bottom_payment_bar.dart';
import 'package:flight_booking_app/domain/entities/seat/service_entity.dart';
import 'package:flight_booking_app/domain/enums/age_group.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/booking_detail_screen.dart';
import 'package:flight_booking_app/presentation/services/cubit/service_selection_cubit.dart';
import 'package:flight_booking_app/presentation/services/cubit/service_selection_state.dart';
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
    context.read<ServiceSelectionCubit>().loadServices(
      flightId: widget.flightId,
      zoneId: widget.zoneId,
      ageGroup: _ageGroup,
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
          if (state.isLoading && state.serviceGroup == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              _PassengerIndicator(
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
                            _ServiceSection(
                              title: 'Meals',
                              icon: Icons.restaurant,
                              services: state.serviceGroup!.meals,
                              selections: state.tempSelections,
                              onToggle: (s, d) => context
                                  .read<ServiceSelectionCubit>()
                                  .toggleService(s, d),
                            ),
                            const SizedBox(height: 20),
                            _ServiceSection(
                              title: 'Drinks',
                              icon: Icons.local_drink,
                              services: state.serviceGroup!.drinks,
                              selections: state.tempSelections,
                              onToggle: (s, d) => context
                                  .read<ServiceSelectionCubit>()
                                  .toggleService(s, d),
                            ),
                            const SizedBox(height: 20),
                            _ServiceSection(
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
      bottomNavigationBar: BlocBuilder<ServiceSelectionCubit, ServiceSelectionState>(
        builder: (context, state) {
          return BottomPaymentBar(
            price: widget.basePrice * widget.seatCount,
            buttonText: _currentPassengerIndex < widget.passengers.length - 1
                ? 'Save & Next Passenger'
                : 'Save & Continue',
            onPressed: state.isSaving || state.serviceGroup == null
                ? null
                : () => context.read<ServiceSelectionCubit>().confirmServices(
                    bookingId: widget.bookingId,
                    passengerId:
                        'p-${_currentPassenger['index'] ?? _currentPassengerIndex}',
                    seatLabel: _currentPassenger['seatLabel'] as String? ?? '',
                  ),
          );
        },
      ),
    );
  }
}

class _PassengerIndicator extends StatelessWidget {
  final int current;
  final int total;
  final String name;
  final String seatLabel;

  const _PassengerIndicator({
    required this.current,
    required this.total,
    required this.name,
    required this.seatLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColor.background,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '$current / $total',
              style: AppTextStyles.caption.copyWith(color: AppColor.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.isEmpty ? 'Passenger $current' : name,
                  style: AppTextStyles.bodyLarge,
                ),
                if (seatLabel.isNotEmpty)
                  Text(
                    'Seat $seatLabel',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColor.greyDark,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<ServiceEntity> services;
  final Map<String, int> selections;
  final void Function(ServiceEntity service, int delta) onToggle;

  const _ServiceSection({
    required this.title,
    required this.icon,
    required this.services,
    required this.selections,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: AppColor.primary),
            const SizedBox(width: 8),
            Text(title, style: AppTextStyles.heading3),
          ],
        ),
        const SizedBox(height: 12),
        for (final service in services)
          _ServiceTile(
            service: service,
            count: selections[service.serviceId] ?? 0,
            onIncrement: () => onToggle(service, 1),
            onDecrement: () => onToggle(service, -1),
          ),
      ],
    );
  }
}

class _ServiceTile extends StatelessWidget {
  final ServiceEntity service;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _ServiceTile({
    required this.service,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: AppColor.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.name, style: AppTextStyles.bodyLarge),
                  Text(
                    '\$${service.price.toStringAsFixed(0)}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _IconButton(
                  icon: Icons.remove,
                  onPressed: count <= 0 ? null : onDecrement,
                ),
                SizedBox(
                  width: 32,
                  child: Text(
                    '$count',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyLarge,
                  ),
                ),
                _IconButton(
                  icon: Icons.add,
                  onPressed: count >= service.maxPerPassenger
                      ? null
                      : onIncrement,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _IconButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onPressed != null
          ? AppColor.primary.withValues(alpha: 0.1)
          : AppColor.border,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            icon,
            size: 18,
            color: onPressed != null ? AppColor.primary : AppColor.greyDark,
          ),
        ),
      ),
    );
  }
}
