import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/presentation/passenger/cubit/passenger_count_cubit.dart';
import 'package:flight_booking_app/presentation/passenger/cubit/passenger_count_state.dart';
import 'package:flight_booking_app/presentation/passenger/view/passenger_count/widgets/passenger_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PassengerCountScreen extends StatelessWidget {
  static String get routerName => '/passenger-count';

  final String flightId;
  final double basePrice;

  const PassengerCountScreen({
    super.key,
    required this.flightId,
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('How many passengers?', style: AppTextStyles.heading2),
              const SizedBox(height: 8),
              Text(
                'Maximum 9 passengers per booking',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColor.greyDark,
                ),
              ),
              const SizedBox(height: 32),
              PassengerCounter(
                label: 'Adults',
                subtitle: 'Age 12+',
                value: state.adults,
                min: 1,
                onIncrement: cubit.incrementAdults,
                onDecrement: cubit.decrementAdults,
              ),
              const Divider(height: 32),
              PassengerCounter(
                label: 'Children',
                subtitle: 'Age 2-11',
                value: state.children,
                min: 0,
                onIncrement: cubit.incrementChildren,
                onDecrement: cubit.decrementChildren,
              ),
              const Divider(height: 32),
              PassengerCounter(
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
                height: MediaQuery.of(context).size.height * 0.06,
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
                        'basePrice': basePrice,
                        'adults': state.adults,
                        'children': state.children,
                        'seniors': state.seniors,
                      },
                    );
                  },
                  child: Text(
                    'Continue — \$${(basePrice * state.total).toStringAsFixed(0)}',
                    style: AppTextStyles.button,
                  ),
                ),
              ),
            ],
          ).paddingAll(20);
        },
      ),
    );
  }
}
