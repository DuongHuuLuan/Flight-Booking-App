import 'package:flight_booking_app/ui/core/theme/app_theme.dart';
import 'routing/app_router.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const FlightBookingApp());
}

class FlightBookingApp extends StatelessWidget {
  const FlightBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
