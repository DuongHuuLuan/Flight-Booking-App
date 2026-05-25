import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/domain/Entities/flight.dart';
import 'package:flight_booking_app/presentation/home/view/widgets/polular_flights_card.dart';
import 'package:flutter/material.dart';

class SearchBody extends StatelessWidget {
  final bool isLoading;
  final List<FlightEntity> filteredFlights;
  final String searchQuery;
  final VoidCallback? onRetry;

  const SearchBody({
    super.key,
    required this.isLoading,
    required this.filteredFlights,
    required this.searchQuery,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (filteredFlights.isNotEmpty) {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: filteredFlights.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) =>
            PopularFlightCard(flight: filteredFlights[index]),
      );
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flight, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            searchQuery.isEmpty
                ? "Tìm kiếm chuyến bay"
                : "Không tìm thấy chuyến bay nào",
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColor.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
    );
  }
}
