import 'package:flight_booking_app/domain/entities/payment_method_entity.dart';

enum PaymentMethodType { creditCard, paypal }

class PaymentMethodState {
  final bool isLoading;
  final List<PaymentMethodEntity> savedCards;
  final PaymentMethodEntity? selectedCard;
  final PaymentMethodType selectedMethod;
  final bool isProcessing;
  final double totalPrice;
  final String? error;

  const PaymentMethodState({
    this.isLoading = false,
    this.savedCards = const [],
    this.selectedCard,
    this.selectedMethod = PaymentMethodType.creditCard,
    this.isProcessing = false,
    this.totalPrice = 0,
    this.error,
  });

  PaymentMethodState copyWith({
    bool? isLoading,
    List<PaymentMethodEntity>? savedCards,
    PaymentMethodEntity? selectedCard,
    PaymentMethodType? selectedMethod,
    bool? isProcessing,
    double? totalPrice,
    String? error,
  }) {
    return PaymentMethodState(
      isLoading: isLoading ?? this.isLoading,
      savedCards: savedCards ?? this.savedCards,
      selectedCard: selectedCard ?? this.selectedCard,
      selectedMethod: selectedMethod ?? this.selectedMethod,
      isProcessing: isProcessing ?? this.isProcessing,
      totalPrice: totalPrice ?? this.totalPrice,
      error: error,
    );
  }
}
