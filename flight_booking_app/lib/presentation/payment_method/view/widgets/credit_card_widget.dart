import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/domain/entities/payment_method_entity.dart';
import 'package:flutter/material.dart';

class CreditCardWidget extends StatelessWidget {
  final PaymentMethodEntity card;
  final double width;
  final double height;

  const CreditCardWidget({
    super.key,
    required this.card,
    required this.width,
    this.height = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF7B1A4A), Color(0xFF9D1C5E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _WavePainter())),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: LinearGradient(
                        colors: [AppColor.grey300, AppColor.grey100],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 28,
                        height: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: AppColor.grey400,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 46,
                    height: 30,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 3,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEB001B),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 3,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF79E1B),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                'Master Card',
                style: AppTextStyles.caption.copyWith(
                  color: AppColor.grey300,
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                card.maskedNumber,
                style: AppTextStyles.heading3.copyWith(color: AppColor.white),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Name',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColor.grey300,
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          card.cardHolderName,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expires Date',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColor.grey300,
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        card.expiryDate,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ).paddingAll(20),
        ],
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.6);
    path.cubicTo(
      size.width * 0.2,
      size.height * 0.5,
      size.width * 0.3,
      size.height * 0.75,
      size.width * 0.5,
      size.height * 0.65,
    );
    path.cubicTo(
      size.width * 0.7,
      size.height * 0.55,
      size.width * 0.8,
      size.height * 0.8,
      size.width,
      size.height * 0.7,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);

    final paint2 = Paint()
      ..color = AppColor.white.withValues(alpha: 0.03)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height * 0.75);
    path2.cubicTo(
      size.width * 0.25,
      size.height * 0.65,
      size.width * 0.35,
      size.height * 0.85,
      size.width * 0.55,
      size.height * 0.78,
    );
    path2.cubicTo(
      size.width * 0.75,
      size.height * 0.7,
      size.width * 0.85,
      size.height * 0.9,
      size.width,
      size.height * 0.82,
    );
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
