import 'package:flutter/material.dart';
import 'package:pola_flutter/models/replacement.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';

class ReplacementsSection extends StatelessWidget {
  const ReplacementsSection({Key? key, required this.replacements}) : super(key: key);

  final List<Replacement> replacements;

  @override
  Widget build(BuildContext context) {
    if (replacements.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            'Niska punktacja Pola. Zobacz Polskie zamienniki:',
            style: TextStyle(
              fontSize: TextSize.smallTitle,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamily.lato,
              color: AppColors.text,
            ),
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 90.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            itemCount: replacements.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 11.0),
                child: _ReplacementCard(replacement: replacements[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ReplacementCard extends StatelessWidget {
  const _ReplacementCard({Key? key, required this.replacement}) : super(key: key);

  final Replacement replacement;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      decoration: BoxDecoration(
        color: AppColors.buttonBackground,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
                replacement.displayName.isNotEmpty ? replacement.displayName : replacement.name,
                style: TextStyle(
                  fontSize: TextSize.description,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.lato,
                  color: AppColors.text,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 1.0),
            Expanded(
              child:Text(
              replacement.company,
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.lato,
                color: AppColors.inactive,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            ),
          ],
        ),
      ),
    );
  }
}