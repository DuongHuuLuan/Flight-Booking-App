import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class TicketDivider extends StatelessWidget {
  const TicketDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const dashWidth = 6.0, dashGap = 4.0;
          final count = (constraints.maxWidth / (dashWidth + dashGap)).floor();
          return Row(
            children: List.generate(
              count,
              (i) => Container(
                width: dashWidth,
                height: 1,
                color: i.isEven ? AppColor.grey300 : Colors.transparent,
              ),
            ),
          );
        },
      ),
    );
  }
}
