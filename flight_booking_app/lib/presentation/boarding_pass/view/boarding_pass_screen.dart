import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/app_elevated_button.dart';
import 'package:flight_booking_app/domain/entities/booking_detail_entity.dart';
import 'package:flight_booking_app/presentation/boarding_pass/view/widgets/boarding_pass_card.dart';
import 'package:flutter/material.dart';

class BoardingPassScreen extends StatelessWidget {
  static String get routerName => '/boarding-pass';

  final BookingDetailEntity booking;
  const BoardingPassScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text('Boarding Pass', style: AppTextStyles.heading3),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        children: [
          BoardingPassCard(booking: booking),
          const SizedBox(height: 20),
          Text(
            'Please arrive at the airport at least 2 hours before departure',
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(color: AppColor.greyDark),
          ),
        ],
      ),
      bottomNavigationBar: AppElevatedButton(
        height: MediaQuery.of(context).size.height * 0.06,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.primary,
        label: 'Download Ticket',

        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Download feature coming soon')),
          );
        },
      ).paddingOnly(bottom: 30, left: 20, right: 20),
    );
  }
}
