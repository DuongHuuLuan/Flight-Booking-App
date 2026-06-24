import 'package:flight_booking_app/domain/entities/booking_detail_entity.dart';

class BookingDetailState {
  final bool isLoading;
  final BookingDetailEntity? bookingDetail;
  final String? error;

  const BookingDetailState({
    this.isLoading = false,
    this.bookingDetail,
    this.error,
  });

  BookingDetailState copyWith({
    bool? isLoading,
    BookingDetailEntity? bookingDetail,
    String? error,
  }) {
    return BookingDetailState(
      isLoading: isLoading ?? this.isLoading,
      bookingDetail: bookingDetail ?? this.bookingDetail,
      error: error,
    );
  }
}
