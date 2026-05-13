import 'package:flight_booking_app/core/theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'routing/app_router.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

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
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
