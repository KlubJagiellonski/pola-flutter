import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/text_size.dart';

class OfflineView extends StatelessWidget {
  const OfflineView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          Image.asset(
            'assets/scan/undraw_no-signal.png', // User will need to add this
            height: 212,
            width: 195,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              height: 212,
              width: 195,
              child: Placeholder(),
            ),
          ),
          const SizedBox(height: 32),
          // Title with icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                color: AppColors.defaultRed,
                size: 32,
              ),
              const SizedBox(width: 12),
              const Text(
                'Brak połączenia',
                style: TextStyle(
                  fontSize: 24, // Assuming TextSize.newsTitle or similar
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Description
          const Text(
            'Jesteś offline. Skanowanie zostanie wznowione automatycznie po odzyskaniu zasięgu',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: TextSize.small,
              color: AppColors.text,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 48),
          // Loading indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.inactive),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Szukanie sieci...',
                style: TextStyle(
                  fontSize: TextSize.small,
                  color: AppColors.inactive,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Button
          SizedBox(
            width: 300,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                AppSettings.openAppSettings(type: AppSettingsType.wifi);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.defaultRed,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Sprawdź ustawienia',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: TextSize.small,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
