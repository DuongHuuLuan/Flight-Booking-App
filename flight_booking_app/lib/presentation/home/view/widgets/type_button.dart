import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flutter/widgets.dart';

class TypeButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Color activeColor;
  final IconData icon;
  final VoidCallback? onPressed;

  const TypeButton({
    super.key,
    required this.text,
    required this.activeColor,
    required this.icon,
    required this.isSelected,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : AppColor.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? activeColor : AppColor.greyLight,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.white : AppColor.black87,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(
                icon,
                size: 16,
                color: isSelected ? AppColor.primary : AppColor.white,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmall.copyWith(
                  color: isSelected ? AppColor.white : AppColor.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
