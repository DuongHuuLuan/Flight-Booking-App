import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/app_card.dart';
import 'package:flight_booking_app/domain/entities/booking/booking_detail_entity.dart';
import 'package:flight_booking_app/presentation/booking_detail/view/widgets/price_row.dart';
import 'package:flutter/material.dart';

class PriceBreakdownCardV2 extends StatelessWidget {
  final BookingDetailEntity bookingDetail;
  final Map<String, dynamic>? priceBreakdown;

  const PriceBreakdownCardV2({
    super.key,
    required this.bookingDetail,
    this.priceBreakdown,
  });

  @override
  Widget build(BuildContext context) {
    final pb = priceBreakdown;
    final zoneTotal = pb?['zone_price_total'] as num? ?? bookingDetail.zonePriceTotal ?? 0;
    final serviceTotal = pb?['service_total'] as num? ?? bookingDetail.serviceTotal ?? 0;
    final baggageTotal = pb?['baggage_total'] as num? ?? bookingDetail.baggageTotal ?? 0;
    final baseTotal = pb?['base_price_total'] as num? ??
        (bookingDetail.totalPrice - zoneTotal - serviceTotal - baggageTotal);
    final total = pb?['total_price'] as num? ?? bookingDetail.totalPrice;
    final passengerCount = bookingDetail.passengers.length;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Price Breakdown", style: AppTextStyles.heading3).paddingAll(16),
          const Divider(height: 1, color: AppColor.border),
          PriceRow(
            label: "Base Price (x $passengerCount)",
            amount: "\$${baseTotal.toStringAsFixed(0)}",
          ),
          if (zoneTotal > 0)
            PriceRow(
              label: "Zone Surcharge",
              amount: "\$${(zoneTotal).toStringAsFixed(0)}",
            ),
          if (serviceTotal > 0)
            PriceRow(
              label: "Services (Meals & Drinks)",
              amount: "\$${(serviceTotal).toStringAsFixed(0)}",
            ),
          if (baggageTotal > 0)
            PriceRow(
              label: "Baggage",
              amount: "\$${(baggageTotal).toStringAsFixed(0)}",
            ),
          PriceRow(label: "Discount", amount: "\$0"),
          const Divider(height: 1, color: AppColor.border),
          PriceRow(
            label: "Total",
            amount: "\$${total.toStringAsFixed(0)}",
            isTotal: true,
          ),
        ],
      ),
    );
  }
}
