import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final String? message;
  final TextStyle? messageStyle;
  final List<String>? errors;
  final String buttonLabel;
  final VoidCallback onConfirm;
  final IconData icon;
  final Color color;
  final String? cancelLabel;
  final TextStyle? cancelLabelStyle;
  final TextStyle? buttonLabelStyle;
  final VoidCallback? onCancel;
  final Color? borderColorCancel;

  const AppAlertDialog({
    super.key,
    required this.title,
    this.titleStyle,
    this.message,
    this.messageStyle,
    this.errors,
    required this.onConfirm,
    this.cancelLabel,
    this.onCancel,
    this.buttonLabelStyle,
    this.cancelLabelStyle,
    this.buttonLabel = "Retry",
    this.icon = Icons.error_outline,
    this.borderColorCancel,
    this.color = AppColor.error,
  });

  @override
  Widget build(BuildContext context) {
    final showCancelButton = onCancel != null && cancelLabel != null;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: color),
          const SizedBox(height: 16),
          Text(
            title,
            style: titleStyle ?? AppTextStyles.heading3.copyWith(color: color),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          if (message != null)
            Text(
              message!,
              style: messageStyle ?? AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),

          if (errors != null && errors!.isNotEmpty)
            ...errors!.map(
              (e) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.cancel, color: color, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      e,
                      style: TextStyle(color: color.withValues(alpha: 0.8)),
                    ),
                  ),
                ],
              ).paddingVertical(4),
            ),

          const SizedBox(height: 32),

          if (showCancelButton)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColor.grey,
                      side: BorderSide(
                        color: borderColorCancel ?? AppColor.grey,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      cancelLabel!,
                      style: cancelLabelStyle ?? AppTextStyles.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: AppColor.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      buttonLabel,
                      style:
                          buttonLabelStyle ??
                          AppTextStyles.bodyMedium.copyWith(
                            color: AppColor.white,
                          ),
                    ),
                  ),
                ),
              ],
            )
          else
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: AppColor.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(buttonLabel),
              ),
            ),
        ],
      ).paddingAll(24),
    );
  }
}
