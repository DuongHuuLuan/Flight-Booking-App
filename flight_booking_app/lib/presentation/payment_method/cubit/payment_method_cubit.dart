import 'package:flight_booking_app/domain/entities/payment_method_entity.dart';
import 'package:flight_booking_app/domain/usecase/booking/mock_payment_usecase.dart';
import 'package:flight_booking_app/presentation/payment_method/cubit/payment_method_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  final MockPaymentUsecase? mockPaymentUsecase;

  PaymentMethodCubit({required double totalPrice, this.mockPaymentUsecase})
    : super(PaymentMethodState(totalPrice: totalPrice));

  void setTotalPrice(double price) {
    emit(state.copyWith(totalPrice: price));
  }

  void loadCards() {
    final cards = [
      PaymentMethodEntity(
        id: '1',
        maskedNumber: '•••• •••• •••• 9876',
        cardHolderName: 'Johnsan Watson',
        expiryDate: '08/28',
        cardType: 'Mastercard',
        isDefault: true,
      ),
      PaymentMethodEntity(
        id: '2',
        maskedNumber: '•••• •••• •••• 9885',
        cardHolderName: 'Johnsan Watson',
        expiryDate: '08/30',
        cardType: 'Mastercard',
        isDefault: true,
      ),
    ];
    emit(
      state.copyWith(
        isLoading: false,
        savedCards: cards,
        selectedCard: cards.firstWhere((c) => c.isDefault),
      ),
    );
  }

  void selectCard(PaymentMethodEntity card) {
    emit(state.copyWith(selectedCard: card, error: null));
  }

  void createCard({
    required String rawCardNumber,
    required String holderName,
    required String expiryDate,
  }) {
    final cleaned = rawCardNumber.replaceAll(' ', '');
    final masked = '•••• ${cleaned.substring(cleaned.length - 4)}';
    final type = cleaned.startsWith('4') ? 'Visa' : 'Mastercard';
    final card = PaymentMethodEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      maskedNumber: masked,
      cardHolderName: holderName,
      expiryDate: expiryDate,
      cardType: type,
      isDefault: false,
    );
    addCard(card);
  }

  void selectPaymentMethod(PaymentMethodType type) {
    emit(state.copyWith(selectedMethod: type, error: null));
  }

  Future<bool> processPayment(String bookingId) async {
    emit(state.copyWith(isProcessing: true, error: null));

    if (mockPaymentUsecase != null) {
      final result = await mockPaymentUsecase!(bookingId);
      return result.fold(
        (error) {
          emit(state.copyWith(isProcessing: false, error: error.toString()));
          return false;
        },
        (data) {
          final success = data['success'] == true;
          emit(state.copyWith(isProcessing: false, paymentSuccess: success));
          return success;
        },
      );
    }

    await Future.delayed(const Duration(milliseconds: 1500));
    emit(state.copyWith(isProcessing: false, paymentSuccess: true));
    return true;
  }

  void addCard(PaymentMethodEntity card) {
    final updated = List<PaymentMethodEntity>.from(state.savedCards)..add(card);
    emit(state.copyWith(savedCards: updated, selectedCard: card));
  }
}
