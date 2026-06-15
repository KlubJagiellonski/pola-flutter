import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/colors.dart';

class SearchFloatingActions extends StatelessWidget {
  final VoidCallback onHistoryTap;
  final VoidCallback onScannerTap;

  const SearchFloatingActions({
    super.key,
    required this.onHistoryTap,
    required this.onScannerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.small(
          heroTag: 'search-history',
          backgroundColor: AppColors.buttonBackground,
          foregroundColor: AppColors.defaultRed,
          onPressed: onHistoryTap,
          child: const Icon(Icons.history),
        ),
        const SizedBox(height: 8),
        FloatingActionButton.small(
          heroTag: 'search-scanner',
          backgroundColor: AppColors.buttonBackground,
          foregroundColor: AppColors.defaultRed,
          onPressed: onScannerTap,
          child: const Icon(Icons.qr_code_scanner),
        ),
      ],
    );
  }
}

class HistoryFloatingActions extends StatelessWidget {
  final VoidCallback onScannerTap;

  const HistoryFloatingActions({super.key, required this.onScannerTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.small(
          heroTag: 'history-scanner',
          backgroundColor: AppColors.buttonBackground,
          foregroundColor: AppColors.defaultRed,
          onPressed: onScannerTap,
          child: const Icon(Icons.qr_code_scanner),
        ),
      ],
    );
  }
}
