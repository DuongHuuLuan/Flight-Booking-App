import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flutter/material.dart';

class InfoGrid extends StatelessWidget {
  final List<InfoRow> rows;

  const InfoGrid({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: rows
          .map(
            (row) => Row(
              children: [
                _infoCell(row.label1, row.value1),
                _infoCell(row.label2, row.value2),
                _infoCell(row.label3, row.value3, isLast: true),
              ],
            ).paddingOnly(bottom: 12),
          )
          .toList(),
    );
  }

  Widget _infoCell(String label, String value, {bool isLast = false}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: isLast
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColor.greyDark,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRow {
  final String label1, value1, label2, value2, label3, value3;
  const InfoRow(
    this.label1,
    this.value1,
    this.label2,
    this.value2,
    this.label3,
    this.value3,
  );
}
