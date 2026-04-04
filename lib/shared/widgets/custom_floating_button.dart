import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class CustomFloatingButton extends StatefulWidget {
  const CustomFloatingButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: Alignment.center,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primaryContainer,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowTint.withValues(alpha: 0.06),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: const Icon(Icons.add, size: 24, color: AppColors.onPrimary),
        ),
      ),
    );
  }
}
