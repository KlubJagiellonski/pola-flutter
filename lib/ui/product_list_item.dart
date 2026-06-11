import 'package:flutter/material.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';

class ProductListItem extends StatelessWidget {
  final int? score;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showChevron;
  final double height;
  final double scoreWidth;
  final EdgeInsetsGeometry margin;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final int titleMaxLines;
  final BoxBorder? border;

  const ProductListItem({
    super.key,
    required this.score,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.showChevron = true,
    this.height = 40,
    this.scoreWidth = 40,
    this.margin = const EdgeInsets.only(top: 4, left: 16, right: 8, bottom: 4),
    this.titleStyle,
    this.subtitleStyle,
    this.titleMaxLines = 1,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(height / 2);

    return Padding(
      padding: margin,
      child: Material(
        color: AppColors.white,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: border,
            ),
            child: Row(
              children: [
                ScoreBadge(score: score, width: scoreWidth, height: height),
                const SizedBox(width: 8),
                Expanded(
                  child: _ProductListText(
                    title: title,
                    subtitle: subtitle,
                    titleStyle: titleStyle,
                    subtitleStyle: subtitleStyle,
                    titleMaxLines: titleMaxLines,
                  ),
                ),
                _ProductListTrailing(
                  trailing: trailing,
                  showChevron: showChevron,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScoreBadge extends StatelessWidget {
  final int? score;
  final double width;
  final double height;

  const ScoreBadge({
    super.key,
    required this.score,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final compact = height <= 44;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.defaultRed,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(height / 2),
          bottomLeft: Radius.circular(height / 2),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            score?.toString() ?? '-',
            style: TextStyle(
              height: compact ? 0 : 1,
              fontWeight: FontWeight.w700,
              fontFamily: FontFamily.roboto,
              fontSize: compact ? TextSize.mediumTitle : TextSize.newsTitle,
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            t.scan.pkt,
            style: TextStyle(
              height: compact ? 0.1 : 1.1,
              fontWeight: FontWeight.w700,
              fontFamily: FontFamily.roboto,
              fontSize: compact ? 9 : 10,
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ProductListText extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final int titleMaxLines;

  const _ProductListText({
    required this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
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
          style:
              titleStyle ??
              const TextStyle(
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
          style:
              titleStyle ??
              const TextStyle(
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
          style:
              subtitleStyle ??
              const TextStyle(
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
  final bool showChevron;

  const _ProductListTrailing({
    required this.trailing,
    required this.showChevron,
  });

  @override
  Widget build(BuildContext context) {
    final trailing = this.trailing;

    if (trailing != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 8, right: 14),
        child: trailing,
      );
    }

    if (!showChevron) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Assets.scan.showMore.svg(),
    );
  }
}
