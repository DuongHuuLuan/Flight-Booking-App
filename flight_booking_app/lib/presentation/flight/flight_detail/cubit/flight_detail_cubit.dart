import 'package:flight_booking_app/domain/usecase/flight/get_flight_detail_usecase.dart';
import 'package:flight_booking_app/presentation/flight/flight_detail/cubit/flight_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightDetailCubit extends Cubit<FlightDetailState> {
  final GetFlightDetailUsecase getFlightDetail;
  FlightDetailCubit({required this.getFlightDetail})
    : super(FlightDetailState());

  Future<void> loadFlightDetail(String id) async {
    emit(state.copyWith(isLoading: true));

    final result = await getFlightDetail(id);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.toString())),
      (detail) {
        emit(FlightDetailState(isLoading: false, flightDetail: detail));
      },
    );
  }
}
