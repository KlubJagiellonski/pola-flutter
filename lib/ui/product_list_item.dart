import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'package:pola_flutter/ui/score_badge.dart';

class ProductListItem extends StatelessWidget {
  final int? score;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final double minHeight;
  final double scoreWidth;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry contentPadding;
  final int titleMaxLines;
  final BoxBorder? border;

  const ProductListItem({
    super.key,
    required this.score,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.minHeight = 40,
    this.scoreWidth = 40,
    this.margin = const EdgeInsets.only(top: 4, left: 16, right: 8, bottom: 4),
    this.contentPadding = const EdgeInsets.symmetric(vertical: 4),
    this.titleMaxLines = 1,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(minHeight / 2);

    return Padding(
      padding: margin,
      child: Material(
        color: AppColors.white,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Container(
              foregroundDecoration: BoxDecoration(
                borderRadius: borderRadius,
                border: border,
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ScoreBadge(
                      score: score,
                      width: scoreWidth,
                      minHeight: minHeight,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Padding(
                        padding: contentPadding,
                        child: _ProductListText(
                          title: title,
                          subtitle: subtitle,
                          titleMaxLines: titleMaxLines,
                        ),
                      ),
                    ),
                    _ProductListTrailing(trailing: trailing),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductListText extends StatelessWidget {
  final String title;
  final String? subtitle;
  final int titleMaxLines;

  const _ProductListText({
    required this.title,
    this.subtitle,
    required this.titleMaxLines,
  });

  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;

    if (subtitle == null || subtitle.isEmpty) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: TextSize.smallTitle,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: titleMaxLines,
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: titleMaxLines,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: TextSize.smallTitle,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.lato,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: TextSize.description,
            fontFamily: FontFamily.lato,
          ),
        ),
      ],
    );
  }
}

class _ProductListTrailing extends StatelessWidget {
  final Widget? trailing;

  const _ProductListTrailing({required this.trailing});

  @override
  Widget build(BuildContext context) {
    final trailing = this.trailing;

    if (trailing != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 8, right: 14),
        child: Center(child: trailing),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Assets.scan.showMore.svg(),
    );
  }
}
