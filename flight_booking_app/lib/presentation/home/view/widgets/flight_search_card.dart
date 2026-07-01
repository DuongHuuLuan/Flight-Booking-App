import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/widgets/app_dropdown_button_form_field.dart';
import 'package:flight_booking_app/core/widgets/app_elevated_button.dart';
import 'package:flight_booking_app/core/widgets/app_text_form_field.dart';
import 'package:flight_booking_app/domain/entities/flight_search_params.dart';
import 'package:flight_booking_app/domain/enums/trip_type.dart';
import 'package:flight_booking_app/presentation/home/cubit/home_cubit.dart';
import 'package:flight_booking_app/presentation/home/view/widgets/type_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightSearchCard extends StatefulWidget {
  const FlightSearchCard({super.key});

  @override
  State<FlightSearchCard> createState() => _FlightSearchCardState();
}

class _FlightSearchCardState extends State<FlightSearchCard> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController departureDateController = TextEditingController();
  TripType _selectedType = TripType.oneWay;
  String _passengerCount = "1";

  final List<String> _passengerOptions = List.generate(
    9,
    (index) => "${index + 1}",
  );

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    departureDateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      departureDateController.text =
          "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TypeButton(
                          text: "One Way",
                          activeColor: AppColor.primary,
                          icon: Icons.arrow_right_alt,
                          isSelected: _selectedType == TripType.oneWay,
                          onPressed: () =>
                              setState(() => _selectedType = TripType.oneWay),
                        ),
                      ),
                      const SizedBox(width: 5),

                      Expanded(
                        child: TypeButton(
                          text: "Round Trip",
                          activeColor: AppColor.primary,
                          icon: Icons.autorenew,
                          isSelected: _selectedType == TripType.roundTrip,
                          onPressed: () => setState(
                            () => _selectedType = TripType.roundTrip,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),

                      Expanded(
                        child: TypeButton(
                          text: "Multi City",
                          activeColor: AppColor.primary,
                          icon: Icons.call_made,
                          isSelected: _selectedType == TripType.multiCity,
                          onPressed: () => setState(
                            () => _selectedType = TripType.multiCity,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      Column(
                        children: [
                          AppTextFormField(
                            controller: fromController,
                            labelText: "From",
                            hintText: "Dubai, United Arab Emirates",
                          ),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: toController,
                            labelText: "To",
                            hintText: "Auckland, New Zealand",
                          ),
                        ],
                      ),
                      Positioned(
                        right: 16,
                        top: 48,
                        child: GestureDetector(
                          onTap: () {
                            final temp = fromController.text;
                            fromController.text = toController.text;
                            toController.text = temp;
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.black.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.swap_vert,
                                color: AppColor.primary,
                                size: 22,
                              ).paddingAll(2),
                            ).paddingAll(12),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _pickDate,
                    child: AbsorbPointer(
                      child: AppTextFormField(
                        controller: departureDateController,
                        labelText: "Departure Date",
                        hintText: "Departure Date",
                        suffixIcon: Icon(Icons.date_range),
                      ),
                    ),
                  ),
                  if (_selectedType == TripType.roundTrip) ...[
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _pickDate,
                      child: AbsorbPointer(
                        child: AppTextFormField(
                          controller: TextEditingController(),
                          labelText: "Return Date",
                          hintText: "Return Date",
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: AppDropdownButtonFormField(
                          isExpanded: true,
                          value: _passengerCount,
                          labelText: "Passenger",
                          items: _passengerOptions
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    "$e ${int.parse(e) > 1 ? "Adults" : "Adult"}",
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _passengerCount = v!),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 20),
                  AppElevatedButton(
                    label: "Search Flight",
                    height: MediaQuery.of(context).size.height * 0.07,
                    backgroundColor: AppColor.primary,
                    onPressed: () {
                      final params = FlightSearchParams(
                        tripType: _selectedType,
                        origin: fromController.text.trim(),
                        destination: toController.text.trim(),
                        departureDate: DateTime.now(),
                        passengerCount: int.parse(_passengerCount),
                      );

                      context.read<HomeCubit>().searchFlights(params);
                      context.goToSelectFlight(params);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ).paddingAll(16),
    );
  }
}
