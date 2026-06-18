import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/domain/entities/airport.dart';
import 'package:flight_booking_app/presentation/select_flight/view/widgets/widgets_router_info/airport_info.dart';
import 'package:flight_booking_app/presentation/select_flight/view/widgets/widgets_router_info/flight_header_painter.dart';
import 'package:flutter/material.dart';

class RouteInfoBar extends StatelessWidget {
  final AirportEntity? origin;
  final AirportEntity? destination;
  final int? duration;

  const RouteInfoBar({super.key, this.origin, this.destination, this.duration});

  String get durationText {
    if (duration == null) return "";
    final h = duration! ~/ 60;
    final m = duration! % 60;
    return "${h}h ${m.toString().padLeft(2, '0')}m";
  }

  @override
  Widget build(BuildContext context) {
    final originCity = origin?.city ?? "Dubai";
    final originCode = origin?.code ?? "DXB";

    final destCity = destination?.city ?? "Auckland";
    final destCode = destination?.code ?? "AKL";

    return Container(
      height: MediaQuery.of(context).size.height * 0.26,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: FlightHeaderPainter())),

          Positioned(
            left: 20,
            bottom: 30,
            child: AirportInfo(
              city: originCity,
              code: originCode,
              alignEnd: false,
            ),
          ),

          Positioned(
            right: 20,
            bottom: 30,
            child: AirportInfo(city: destCity, code: destCode, alignEnd: true),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 52,
            child: Column(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.flight,
                    color: AppColor.primary,
                    size: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  durationText,
                  style: AppTextStyles.caption.copyWith(color: AppColor.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
