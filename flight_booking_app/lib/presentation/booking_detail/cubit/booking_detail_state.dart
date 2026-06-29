import 'package:flight_booking_app/domain/entities/booking/booking_detail_entity.dart';

class BookingDetailState {
  final bool isLoading;
  final BookingDetailEntity? bookingDetail;
  final Map<String, dynamic>? priceBreakdown;
  final String? error;

  const BookingDetailState({
    this.isLoading = false,
    this.bookingDetail,
    this.priceBreakdown,
    this.error,
  });

  BookingDetailState copyWith({
    bool? isLoading,
    BookingDetailEntity? bookingDetail,
    Map<String, dynamic>? priceBreakdown,
    String? error,
  }) {
    return BookingDetailState(
      isLoading: isLoading ?? this.isLoading,
      bookingDetail: bookingDetail ?? this.bookingDetail,
      priceBreakdown: priceBreakdown ?? this.priceBreakdown,
      error: error,
    );
  }
}
