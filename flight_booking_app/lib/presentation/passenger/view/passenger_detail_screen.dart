import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
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
  final double totalPrice;
  final List<String> seatZoneIds;
  final String flightId;

  const PassengerDetailScreen({
    super.key,
    required this.bookingId,
    required this.seatCount,
    required this.basePrice,
    required this.totalPrice,
    required this.seatZoneIds,
    required this.flightId,
  });

  @override
  State<PassengerDetailScreen> createState() => _PassengerDetailScreenState();
}

class _PassengerDetailScreenState extends State<PassengerDetailScreen> {
  int _currentStep = 0;

  bool _isLastStep(int total) => _currentStep >= total - 1;

  bool _isCurrentStepValid(PassengerState state) {
    if (state.forms.isEmpty) return false;
    final form = state.forms[_currentStep];
    return form.name.isNotEmpty && form.mobilePhone.isNotEmpty;
  }

  void _onNext() {
    final cubit = context.read<PassengerCubit>();
    final state = cubit.state;
    if (state.forms.isEmpty) return;

    if (!_isCurrentStepValid(state)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng điền đầy đủ thông tin bắt buộc'),
        ),
      );
      return;
    }

    if (_isLastStep(state.forms.length)) {
      _onSave();
    } else {
      setState(() => _currentStep++);
    }
  }

  void _onBack() {
    if (_currentStep > 0) setState(() => _currentStep--);
  }

  Future<void> _onSave() async {
    final cubit = context.read<PassengerCubit>();
    final success = await cubit.savePassengers(bookingId: widget.bookingId);
    if (success && mounted) {
      final created = cubit.state.passengers ?? [];
      final passengers = cubit.buildPassengerPayloads(
        created,
        widget.seatZoneIds,
      );
      context.push(
        ServiceSelectionScreen.routerName,
        extra: {
          'bookingId': widget.bookingId,
          'seatCount': widget.seatCount,
          'totalPrice': widget.totalPrice,
          'passengers': passengers,
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
        leading: _currentStep > 0
            ? IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: _onBack)
            : null,
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
          if (state.forms.isEmpty) return const SizedBox();

          final total = state.forms.length;
          final isLast = _isLastStep(total);
          final isValid = _isCurrentStepValid(state);

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_currentStep + 1} of $total',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColor.greyDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ...List.generate(total, (i) {
                    final active = i <= _currentStep;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: active ? 24 : 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: active ? AppColor.primary : AppColor.grey200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ],
              ).paddingVertical(12),

              Expanded(
                child: SingleChildScrollView(
                  child: V2PassengerFormCard(
                    formData: state.forms[_currentStep],
                    index: _currentStep + 1,
                    baggageOptions: state.baggageOptions,
                    onUpdateField: (field, value) => context
                        .read<PassengerCubit>()
                        .updateField(_currentStep, field, value),
                  ),
                ),
              ),

              BottomPaymentBar(
                price: widget.totalPrice + state.totalBaggagePrice,
                buttonText: isLast ? 'Continue' : 'Next',
                onPressed: isValid && !state.isLoading ? _onNext : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
