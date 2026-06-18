import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/navigation_exp.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/core/utils/widget_pop_scope.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_state.dart';
import 'package:flight_booking_app/presentation/home/cubit/home_cubit.dart';
import 'package:flight_booking_app/presentation/home/cubit/home_state.dart';
import 'package:flight_booking_app/presentation/home/view/widgets/flight_search_card.dart';
import 'package:flight_booking_app/presentation/home/view/widgets/popular_flights_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static String get routerName => '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _FlightBookingState();
}

class _FlightBookingState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final homeState = context.read<HomeCubit>().state;

      if (homeState.status != HomeStatus.loading &&
          homeState.status != HomeStatus.success) {
        context.read<HomeCubit>().loadHomeData();
      }
    });
  }

  Future<void> _onRefresh() async {
    await context.read<HomeCubit>().loadHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, homeState) {
        if (homeState.status == HomeStatus.loading) {
          context.showLoading("Loading home...");
        }

        if (homeState.status == HomeStatus.success ||
            homeState.status == HomeStatus.failure) {
          context.hideLoading();
        }
      },
      builder: (context, homeState) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            final username = authState.status == AuthStatus.authAuthenticated
                ? authState.user?.name ?? "A"
                : "A";

            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: RefreshIndicator(
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: const BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),

                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Hello $username",
                                        style: AppTextStyles.bodyLarge.copyWith(
                                          color: AppColor.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const RotatedBox(
                                        quarterTurns: 4,
                                        child: Icon(
                                          Icons.waving_hand,
                                          color: AppColor.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Find your flights",
                                    style: AppTextStyles.heading2.copyWith(
                                      color: AppColor.white,
                                    ),
                                  ),
                                ],
                              ),

                              IconButton(
                                onPressed: () {},
                                iconSize: 25,
                                style: IconButton.styleFrom(
                                  side: const BorderSide(
                                    color: AppColor.greyLight,
                                    width: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.notifications,
                                  color: AppColor.white,
                                ),
                              ),
                            ],
                          ).paddingOnly(
                            top: 60,
                            left: 30,
                            bottom: 30,
                            right: 30,
                          ),

                          const SizedBox(height: 20),
                          const FlightSearchCard(),
                          const SizedBox(height: 10),

                          if (homeState.status == HomeStatus.failure)
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                homeState.errorMessage ?? "Failed to load home",
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColor.error,
                                ),
                              ),
                            )
                          else
                            const PopularFlightsSection(),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: const BoxDecoration(
                  color: AppColor.primary,
                  shape: BoxShape.circle,
                ),
                child: RawMaterialButton(
                  shape: const CircleBorder(),
                  onPressed: () {},
                  child: const Icon(
                    Icons.qr_code_scanner,
                    color: AppColor.white,
                    size: 28,
                  ),
                ),
              ),

              bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                notchMargin: 10.0,
                color: AppColor.white,
                elevation: 10,
                clipBehavior: Clip.antiAlias,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.goToHome();
                      },
                      icon: const Icon(Icons.home, color: AppColor.primary),
                    ),
                    IconButton(
                      onPressed: () {
                        context.goToSearch();
                      },
                      icon: const Icon(Icons.search, color: AppColor.black87),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.wallet, color: AppColor.black87),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person, color: Colors.black87),
                      onPressed: () {
                        context.read<AuthCubit>().logout();
                        context.goToLogin();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).canPop(false);
  }
}
