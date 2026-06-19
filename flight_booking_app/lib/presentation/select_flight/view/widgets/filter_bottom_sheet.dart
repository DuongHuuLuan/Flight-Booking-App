import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/presentation/select_flight/cubit/select_flight_cubit.dart';
import 'package:flight_booking_app/presentation/select_flight/cubit/select_flight_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<SelectFlightCubit>(),
        child: const FilterBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectFlightCubit, SelectFlightState>(
      builder: (context, state) {
        final cubit = context.read<SelectFlightCubit>();
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Stops", style: AppTextStyles.heading3),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                _buildChip(
                  "Non Stop",
                  state.stops == StopsFilter.nonStop,
                  () => cubit.applyFilters(
                    stops: StopsFilter.nonStop,
                    departureTime: state.departureTime,
                    arrivalTime: state.arrivalTime,
                    priceRange: state.priceRange,
                  ),
                ),
                _buildChip(
                  "1 Stop",
                  state.stops == StopsFilter.oneStop,
                  () => cubit.applyFilters(
                    stops: StopsFilter.oneStop,
                    departureTime: state.departureTime,
                    arrivalTime: state.arrivalTime,
                    priceRange: state.priceRange,
                  ),
                ),
                _buildChip(
                  "All Flights",
                  state.stops == StopsFilter.all,
                  () => cubit.applyFilters(
                    stops: StopsFilter.all,
                    departureTime: state.departureTime,
                    arrivalTime: state.arrivalTime,
                    priceRange: state.priceRange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text("Departure Time", style: AppTextStyles.heading3),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: TimeFilter.values.where((t) => t != TimeFilter.any).map(
                (t) {
                  return _buildChip(
                    _timeLabel(t),
                    state.departureTime == t,
                    () {
                      cubit.applyFilters(
                        stops: state.stops,
                        departureTime: t,
                        arrivalTime: state.arrivalTime,
                        priceRange: state.priceRange,
                      );
                    },
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 20),
            Text("Arrival Time", style: AppTextStyles.heading3),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: TimeFilter.values.where((t) => t != TimeFilter.any).map(
                (t) {
                  return _buildChip(_timeLabel(t), state.arrivalTime == t, () {
                    cubit.applyFilters(
                      stops: state.stops,
                      departureTime: state.departureTime,
                      arrivalTime: t,
                      priceRange: state.priceRange,
                    );
                  });
                },
              ).toList(),
            ),
            const SizedBox(height: 20),
            Text("Price", style: AppTextStyles.heading3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${state.priceRange.start.round()}"),
                Text("\$${state.priceRange.end.round()}"),
              ],
            ),
            RangeSlider(
              values: state.priceRange,
              min: state.minPrice,
              max: state.maxPrice,
              divisions: 20,
              labels: RangeLabels(
                "\$${state.priceRange.start.round()}",
                "\$${state.priceRange.end.round()}",
              ),
              activeColor: AppColor.primary,
              onChanged: (values) {
                cubit.applyFilters(
                  stops: state.stops,
                  departureTime: state.departureTime,
                  arrivalTime: state.arrivalTime,
                  priceRange: values,
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      cubit.clearFilters();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColor.primary,
                      side: const BorderSide(color: AppColor.primary),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Clear All"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      foregroundColor: AppColor.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Apply"),
                  ),
                ),
              ],
            ),
          ],
        ).paddingOnly(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        );
      },
    );
  }

  Widget _buildChip(String label, bool selected, VoidCallback onTap) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: AppColor.primary,
      labelStyle: AppTextStyles.bodyMedium.copyWith(
        color: selected ? AppColor.white : AppColor.black87,
        fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
      ),
      onSelected: (_) => onTap(),
    );
  }

  String _timeLabel(TimeFilter t) {
    switch (t) {
      case TimeFilter.morning:
        return "Morning";
      case TimeFilter.afternoon:
        return "Afternoon";
      case TimeFilter.evening:
        return "Evening";
      case TimeFilter.night:
        return "Night";
      default:
        return "";
    }
  }
}
