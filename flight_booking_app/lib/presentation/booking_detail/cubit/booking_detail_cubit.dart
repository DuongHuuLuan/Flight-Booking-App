import 'package:flight_booking_app/domain/usecase/booking/get_booking_detail_usecase.dart';
import 'package:flight_booking_app/domain/usecase/booking/get_price_breakdown_usecase.dart';
import 'package:flight_booking_app/presentation/booking_detail/cubit/booking_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingDetailCubit extends Cubit<BookingDetailState> {
  final GetBookingDetailUsecase getBookingDetailUsecase;
  final GetPriceBreakdownUsecase getPriceBreakdownUsecase;

  BookingDetailCubit({
    required this.getBookingDetailUsecase,
    required this.getPriceBreakdownUsecase,
  }) : super(const BookingDetailState());

  Future<void> loadDetail(String bookingId) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await getBookingDetailUsecase(bookingId);
    result.fold(
      (error) =>
          emit(state.copyWith(isLoading: false, error: error.toString())),
      (detail) => emit(state.copyWith(isLoading: false, bookingDetail: detail)),
    );
  }

  Future<void> loadPriceBreakdown(String bookingId) async {
    final result = await getPriceBreakdownUsecase(bookingId);
    result.fold(
      (error) => emit(state.copyWith(error: error.toString())),
      (data) => emit(state.copyWith(priceBreakdown: data)),
    );
  }
}
