import 'dart:async';
import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/domain/Entities/flight.dart';
import 'package:flight_booking_app/domain/usecase/search/get_all_flights_usecase.dart';
import 'package:flight_booking_app/injection_container.dart';
import 'package:flight_booking_app/presentation/home/view/home_screen.dart';
import 'package:flight_booking_app/presentation/search/widgets/search_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension SearchNavigation on BuildContext {
  void goToSearch() => go('/search');
}

class SearchScreen extends StatefulWidget {
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
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: "Tìm sân bay, chuyến bay...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: AppColor.grey),
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
    );
  }
}
