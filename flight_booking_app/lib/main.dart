import 'package:flight_booking_app/core/theme/app_theme.dart';
import 'package:flight_booking_app/core/widgets/app_loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/cubit/loading/app_loading_cubit.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
import 'routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await di.init();
  runApp(const FlightBookingApp());
}

class FlightBookingApp extends StatelessWidget {
  const FlightBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppLoadingCubit>(
      create: (_) => getIt<AppLoadingCubit>(),
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return AppLoadingOverlay(child: child ?? const SizedBox());
        },
      ),
    );
  }
}
