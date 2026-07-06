import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/widgets/section_card.dart';
import 'package:flight_booking_app/presentation/booking_detail/cubit/booking_detail_state.dart';
import 'package:flight_booking_app/core/widgets/price_row.dart';
import 'package:flutter/material.dart';

class PriceBreakdownCardV2 extends StatelessWidget {
  final BookingDetailState state;

  const PriceBreakdownCardV2({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final detail = state.bookingDetail!;
    final passengerCount = detail.passengers.length;

    return SectionCard(
      title: "Price Breakdown",
      children: [
        PriceRow(
          label: "Base Price (x $passengerCount)",
          amount: "\$${state.baseFare.toStringAsFixed(0)}",
        ),
        if (state.zoneSurcharge > 0)
          PriceRow(
            label: "Zone Surcharge",
            amount: "\$${(state.zoneSurcharge).toStringAsFixed(0)}",
          ),
        if (state.serviceTotal > 0)
          PriceRow(
            label: "Services (Meals & Drinks)",
            amount: "\$${(state.serviceTotal).toStringAsFixed(0)}",
          ),
        if (state.baggageTotal > 0)
          PriceRow(
            label: "Baggage",
            amount: "\$${(state.baggageTotal).toStringAsFixed(0)}",
          ),
        PriceRow(label: "Discount", amount: "\$0"),
        const Divider(height: 1, color: AppColor.border),
        PriceRow(
          label: "Total",
          amount: "\$${state.grandTotal.toStringAsFixed(0)}",
          isTotal: true,
        ),
      ],
    );
  }
}
