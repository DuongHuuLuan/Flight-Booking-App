import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart' as bw;
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class TicketBarcode extends StatelessWidget {
  final String number;

  const TicketBarcode({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        bw.BarcodeWidget(
          barcode: Barcode.code128(),
          data: number,
          height: 60,
          drawText: false,
        ),
        const SizedBox(height: 8),
        Text(
          number,
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
