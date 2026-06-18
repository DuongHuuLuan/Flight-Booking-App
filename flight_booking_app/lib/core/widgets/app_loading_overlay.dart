import 'package:flight_booking_app/core/cubit/loading/app_loading_cubit.dart';
import 'package:flight_booking_app/core/cubit/loading/app_loading_state.dart';
import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/widgets/app_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLoadingOverlay extends StatelessWidget {
  final Widget child;

  const AppLoadingOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLoadingCubit, AppLoadingState>(
      builder: (context, state) {
        return Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              child,

              if (state.isLoading)
                Positioned.fill(
                  child: Stack(
                    children: [
                      ModalBarrier(dismissible: false, color: AppColor.black38),

                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 24,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // RippleWave(
                              //   size: (MediaQuery.of(context).size.width * 0.28)
                              //       .clamp(90.0, 120.0),
                              // ),
                              AppLoadingIndicator(),

                              if (state.message != null) ...[
                                const SizedBox(height: 16),
                                Text(
                                  state.message!,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColor.greyLight,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

extension AppLoadingContext on BuildContext {
  void showLoading([String? message]) {
    read<AppLoadingCubit>().show(message: message);
  }

  void hideLoading() {
    read<AppLoadingCubit>().hide();
  }
}
