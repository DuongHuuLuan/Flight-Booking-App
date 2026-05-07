import 'package:flight_booking_app/domain/usecase/get_onboarding_data.dart';
import 'package:flight_booking_app/ui/onboarding/cubit/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final GetOnboardingData getOnboardingData;

  OnboardingCubit(this.getOnboardingData) : super(OnboardingInitial());

  void loadData() async {
    emit(OnboardingLoading());
    try {
      final data = await getOnboardingData();
      emit(OnboardingLoaded(data));
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }
}
