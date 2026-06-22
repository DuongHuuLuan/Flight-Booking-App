import 'package:flight_booking_app/domain/entities/flight_detail_entity.dart';
import 'package:flight_booking_app/domain/usecase/booking/create_booking_usecase.dart';
import 'package:flight_booking_app/domain/usecase/flight/get_flight_detail_usecase.dart';
import 'package:flight_booking_app/presentation/flight/flight_detail/flight_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightDetailCubit extends Cubit<FlightDetailState> {
  final GetFlightDetailUsecase getFlightDetail;
  final CreateBookingUsecase createBookingUseCase;
  FlightDetailCubit({
    required this.getFlightDetail,
    required this.createBookingUseCase,
  }) : super(FlightDetailState());

  Future<void> loadFlightDetail(String id) async {
    emit(state.copyWith(isLoading: true));

    final result = await getFlightDetail(id);
    result.fold((failure) => emit(state.copyWith(isLoading: false)), (detail) {
      emit(
        FlightDetailState(
          isLoading: false,
          flightDetail: detail,
          selectedCabinClass: detail.cabinClass.isNotEmpty
              ? detail.cabinClass.first
              : null,
        ),
      );
    });
  }

  void selectCabinClass(CabinClassOption option) {
    emit(state.copyWith(selectedCabinClass: option));
  }

  Future<bool> createBooking() async {
    final flight = state.flightDetail;
    final cabin = state.selectedCabinClass;
    if (flight == null || cabin == null) return false;

    emit(state.copyWith(isBooking: true));
    final result = await createBookingUseCase(
      flightId: flight.id,
      cabinClass: cabin.cabinClass.name,
    );
    return result.fold(
      (error) {
        emit(state.copyWith(isBooking: false));
        return false;
      },
      (_) {
        emit(state.copyWith(isBooking: false));
        return true;
      },
    );
  }
}
