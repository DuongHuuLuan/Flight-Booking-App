import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/app_card.dart';
import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String? title;
  final Widget? trailing;
  final List<Widget> children;

  const SectionCard({
    super.key,
    this.title,
    this.trailing,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null || trailing != null)
            Row(
              children: [
                if (title != null)
                  Expanded(child: Text(title!, style: AppTextStyles.heading3)),
                ?trailing,
              ],
            ).paddingAll(16),
          if (title != null || trailing != null)
            const Divider(height: 1, color: AppColor.border),
          ...children,
        ],
      ),
    );
  }
}
