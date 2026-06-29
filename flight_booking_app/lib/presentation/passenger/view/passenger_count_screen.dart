import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/presentation/passenger/cubit/passenger_count_cubit.dart';
import 'package:flight_booking_app/presentation/passenger/cubit/passenger_count_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PassengerCountScreen extends StatelessWidget {
  static String get routerName => '/passenger-count';

  final String flightId;
  final String cabinClass;
  final double basePrice;

  const PassengerCountScreen({
    super.key,
    required this.flightId,
    required this.cabinClass,
    required this.basePrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text('Passengers', style: AppTextStyles.heading3),
        centerTitle: true,
      ),
      body: BlocBuilder<PassengerCountCubit, PassengerCountState>(
        builder: (context, state) {
          final cubit = context.read<PassengerCountCubit>();
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How many passengers?',
                  style: AppTextStyles.heading2,
                ),
                const SizedBox(height: 8),
                Text(
                  'Maximum 9 passengers per booking',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColor.greyDark,
                  ),
                ),
                const SizedBox(height: 32),
                _PassengerCounter(
                  label: 'Adults',
                  subtitle: 'Age 12+',
                  value: state.adults,
                  min: 1,
                  onIncrement: cubit.incrementAdults,
                  onDecrement: cubit.decrementAdults,
                ),
                const Divider(height: 32),
                _PassengerCounter(
                  label: 'Children',
                  subtitle: 'Age 2-11',
                  value: state.children,
                  min: 0,
                  onIncrement: cubit.incrementChildren,
                  onDecrement: cubit.decrementChildren,
                ),
                const Divider(height: 32),
                _PassengerCounter(
                  label: 'Seniors',
                  subtitle: 'Age 60+',
                  value: state.seniors,
                  min: 0,
                  onIncrement: cubit.incrementSeniors,
                  onDecrement: cubit.decrementSeniors,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      foregroundColor: AppColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      context.push(
                        '/select-seat',
                        extra: {
                          'flightId': flightId,
                          'cabinClass': cabinClass,
                          'basePrice': basePrice,
                          'adults': state.adults,
                          'children': state.children,
                          'seniors': state.seniors,
                        },
                      );
                    },
                    child: Text(
                      'Continue — \$${(basePrice * state.total).toStringAsFixed(0)}',
                      style: AppTextStyles.buttonLarge,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PassengerCounter extends StatelessWidget {
  final String label;
  final String subtitle;
  final int value;
  final int min;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _PassengerCounter({
    required this.label,
    required this.subtitle,
    required this.value,
    required this.min,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.bodyLarge),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTextStyles.caption),
            ],
          ),
        ),
        Row(
          children: [
            _CounterButton(
              icon: Icons.remove,
              onPressed: value <= min ? null : onDecrement,
            ),
            SizedBox(
              width: 48,
              child: Text(
                '$value',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading3,
              ),
            ),
            _CounterButton(
              icon: Icons.add,
              onPressed: onIncrement,
            ),
          ],
        ),
      ],
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _CounterButton({required this.icon, this.onPressed});

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
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 20, color: onPressed != null ? AppColor.primary : AppColor.greyDark),
        ),
      ),
    );
  }
}
