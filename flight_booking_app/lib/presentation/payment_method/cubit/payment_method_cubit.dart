import 'package:flight_booking_app/domain/entities/payment_method_entity.dart';
import 'package:flight_booking_app/presentation/payment_method/cubit/payment_method_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  PaymentMethodCubit({required double totalPrice})
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

  void selectPaymentMethod(PaymentMethodType type) {
    emit(state.copyWith(selectedMethod: type, error: null));
  }

  Future<bool> processPayment() async {
    emit(state.copyWith(isProcessing: true, error: null));
    await Future.delayed(const Duration(milliseconds: 1500));
    emit(state.copyWith(isProcessing: false));
    return true;
  }

  void addCard(PaymentMethodEntity card) {
    final updated = List<PaymentMethodEntity>.from(state.savedCards)..add(card);
    emit(state.copyWith(savedCards: updated, selectedCard: card));
  }
}
