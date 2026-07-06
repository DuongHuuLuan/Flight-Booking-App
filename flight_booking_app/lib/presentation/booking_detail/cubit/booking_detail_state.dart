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

  double get zoneSurcharge =>
      (priceBreakdown?['zoneSurchargeTotal'] as num? ??
              bookingDetail?.zonePriceTotal ??
              0)
          .toDouble();
  double get serviceTotal =>
      (priceBreakdown?['serviceTotal'] as num? ??
              bookingDetail?.serviceTotal ??
              0)
          .toDouble();
  double get baggageTotal =>
      (priceBreakdown?['baggageTotal'] as num? ??
              bookingDetail?.baggageTotal ??
              0)
          .toDouble();
  double get baseFare =>
      (priceBreakdown?['baseFare'] as num? ??
              ((bookingDetail?.totalPrice ?? 0) -
                  zoneSurcharge -
                  serviceTotal -
                  baggageTotal))
          .toDouble();
  double get grandTotal =>
      (priceBreakdown?['grandTotal'] as num? ?? bookingDetail?.totalPrice ?? 0)
          .toDouble();

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
