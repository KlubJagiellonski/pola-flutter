import 'package:flutter/material.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final String query;
  final String hintText;
  final bool showSearchIcon;
  final TextInputAction textInputAction;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const SearchInput({
    super.key,
    required this.controller,
    required this.query,
    required this.hintText,
    required this.onChanged,
    required this.onClear,
    this.showSearchIcon = true,
    this.textInputAction = TextInputAction.search,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.info_outline, size: 14, color: AppColors.text),
            const SizedBox(width: 4),
            Text(
              t.search.inputLabel,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: TextSize.description,
                fontFamily: FontFamily.lato,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onChanged,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.inactive),
            filled: true,
            fillColor: AppColors.textField,
            prefixIcon: showSearchIcon
                ? Padding(
                    padding: const EdgeInsets.all(14),
                    child: Assets.search.svg(
                      colorFilter: const ColorFilter.mode(
                        AppColors.inactive,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                : null,
            suffixIcon: query.isNotEmpty
                ? IconButton(
                    onPressed: onClear,
                    icon: const Icon(Icons.close, color: AppColors.text),
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
