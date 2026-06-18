import 'package:flight_booking_app/core/cubit/loading/app_loading_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLoadingCubit extends Cubit<AppLoadingState> {
  AppLoadingCubit() : super(const AppLoadingState());

  void show({String? message}) {
    emit(state.copyWith(isLoading: true, message: message));
  }

  void hide() {
    emit(const AppLoadingState());
  }
}
