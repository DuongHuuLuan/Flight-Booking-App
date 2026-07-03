import 'package:flight_booking_app/presentation/passenger/cubit/passenger_count_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerCountCubit extends Cubit<PassengerCountState> {
  PassengerCountCubit() : super(PassengerCountState());

  void setAdults(int v) => emit(state.copyWith(adults: v));
  void setChildren(int v) => emit(state.copyWith(children: v));
  void setSeniors(int v) => emit(state.copyWith(seniors: v));

  void incrementAdults() {
    if (state.total >= 9) return;
    emit(state.copyWith(adults: state.adults + 1));
  }

  void decrementAdults() {
    if (state.adults <= 1) return;
    emit(state.copyWith(adults: state.adults - 1));
  }

  void incrementChildren() {
    if (state.total >= 9) return;
    if (state.children >= state.adults) return;
    emit(state.copyWith(children: state.children + 1));
  }

  void decrementChildren() {
    if (state.children <= 0) return;
    emit(state.copyWith(children: state.children - 1));
  }

  void incrementSeniors() {
    if (state.total >= 9) return;
    if (state.seniors >= state.adults) return;
    emit(state.copyWith(seniors: state.seniors + 1));
  }

  void decrementSeniors() {
    if (state.seniors <= 0) return;
    emit(state.copyWith(seniors: state.seniors - 1));
  }
}
