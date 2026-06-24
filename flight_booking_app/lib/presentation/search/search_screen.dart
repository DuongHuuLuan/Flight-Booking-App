import 'dart:async';

import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flight_booking_app/domain/entities/flight.dart';
import 'package:flight_booking_app/domain/usecase/search/get_all_flights_usecase.dart';
import 'package:flight_booking_app/injection_container.dart';
import 'package:flight_booking_app/presentation/search/widgets/search_body.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static String get routerName => '/search';
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<FlightEntity> _allFlights = [];
  List<FlightEntity> _filteredFlights = [];
  bool _isLoading = true;
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    _loadFlights();
    _focusNode.requestFocus();
  }

  Future<void> _loadFlights() async {
    final result = await getIt<GetAllFlightsUsecase>().call();
    result.fold(
      (exception) {
        if (mounted) setState(() => _isLoading = false);
      },
      (flights) {
        if (mounted) {
          setState(() {
            _allFlights = flights;
            _filteredFlights = flights;
            _isLoading = false;
          });
        }
      },
    );
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isEmpty) {
        setState(() => _filteredFlights = _allFlights);
        return;
      }
      final lowerQuery = query.toLowerCase();
      setState(() {
        _filteredFlights = _allFlights.where((flight) {
          return flight.departureAirport.code.toLowerCase().contains(
                lowerQuery,
              ) ||
              flight.departureAirport.city.toLowerCase().contains(lowerQuery) ||
              flight.arrivalAirport.code.toLowerCase().contains(lowerQuery) ||
              flight.arrivalAirport.city.toLowerCase().contains(lowerQuery) ||
              flight.airline.name.toLowerCase().contains(lowerQuery) ||
              flight.flightNumber.toLowerCase().contains(lowerQuery);
        }).toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: "Tìm sân bay, chuyến bay...",
            border: InputBorder.none,
            hintStyle: AppTextStyles.bodySmall.copyWith(color: AppColor.grey),
          ),
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColor.grey,
            fontWeight: FontWeight.w400,
          ),
          onChanged: _onSearchChanged,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.black87),
          onPressed: () => context.goToHome(),
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.clear, color: AppColor.grey),
              onPressed: () {
                _searchController.clear();
                _onSearchChanged("");
              },
            ),
        ],
      ),
      body: SearchBody(
        isLoading: _isLoading,
        filteredFlights: _filteredFlights,
        searchQuery: _searchController.text,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.15,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          color: AppColor.primary,
          shape: BoxShape.circle,
        ),
        child: RawMaterialButton(
          shape: const CircleBorder(),
          onPressed: () {},
          child: Icon(Icons.qr_code_scanner, color: AppColor.white, size: 28),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: AppColor.white,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  context.goToHome();
                },
                icon: Icon(Icons.home, color: AppColor.black87),
              ),

              IconButton(
                onPressed: () {
                  context.goToSearch();
                },
                icon: Icon(Icons.search, color: AppColor.primary),
              ),

              IconButton(
                onPressed: () {},
                icon: Icon(Icons.wallet, color: AppColor.black87),
              ),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.black87),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
