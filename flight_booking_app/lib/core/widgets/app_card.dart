import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;
  final bool clipContent;

  const AppCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.borderRadius,
    this.color,
    this.boxShadow,
    this.onTap,
    this.clipContent = false,
  });

  EdgeInsetsGeometry get _margin =>
      margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 6);

  BorderRadiusGeometry get _borderRadius =>
      borderRadius ?? BorderRadius.circular(16);

  Color get _color => color ?? AppColor.white;

  List<BoxShadow> get _boxShadow =>
      boxShadow ??
      [
        BoxShadow(
          color: AppColor.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      margin: _margin,
      padding: padding,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: _borderRadius,
        boxShadow: _boxShadow,
      ),
      child: clipContent
          ? ClipRRect(borderRadius: _borderRadius, child: child)
          : child,
    );

    if (onTap != null) {
      card = GestureDetector(onTap: onTap, child: card);
    }

    return card;
  }
}
