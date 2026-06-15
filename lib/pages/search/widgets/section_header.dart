import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/text_size.dart';

class SearchSectionTitle extends StatelessWidget {
  final String title;

  const SearchSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: TextSize.mediumTitle,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: SearchSectionTitle(title: title)),
        if (actionText != null)
          TextButton(
            onPressed: onActionTap,
            child: Text(
              actionText!,
              style: const TextStyle(
                color: AppColors.defaultRed,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}
