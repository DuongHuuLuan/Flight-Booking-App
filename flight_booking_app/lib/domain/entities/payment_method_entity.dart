class PaymentMethodEntity {
  final String id;
  final String maskedNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cardType;
  final bool isDefault;

  PaymentMethodEntity({
    required this.id,
    required this.maskedNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cardType,
    required this.isDefault,
  });
}
