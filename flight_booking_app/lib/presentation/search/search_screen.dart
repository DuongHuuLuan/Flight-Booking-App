import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flight_booking_app/presentation/search/cubit/search_cubit.dart';
import 'package:flight_booking_app/presentation/search/cubit/search_state.dart';
import 'package:flight_booking_app/presentation/search/widgets/search_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  static String get routerName => '/search';
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchCubit>().loadFlights();
    });
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
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
          onChanged: (query) => context.read<SearchCubit>().search(query),
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
                context.read<SearchCubit>().search("");
              },
            ),
        ],
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return SearchBody(
            isLoading: state.isLoading,
            filteredFlights: state.filteredFlights,
            searchQuery: _searchController.text,
            onRetry: () => context.read<SearchCubit>().loadFlights(),
          );
        },
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
