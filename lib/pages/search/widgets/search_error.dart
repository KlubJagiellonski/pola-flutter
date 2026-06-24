import 'package:flutter/material.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/theme/colors.dart';

class SearchError extends StatelessWidget {
  final bool compact;
  final VoidCallback onRetry;

  const SearchError({super.key, required this.onRetry, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: compact ? 8 : 24),
      child: Row(
        children: [
          Expanded(
            child: Text(
              t.search.error,
              style: const TextStyle(color: AppColors.text),
            ),
          ),
          TextButton(onPressed: onRetry, child: Text(t.search.retry)),
        ],
      ),
    );
  }
}
