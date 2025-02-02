import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'package:pola_flutter/i18n/strings.g.dart';

class ScanSearchButton extends StatelessWidget {
  const ScanSearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/search');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Assets.search.svg(),
              ),
              Expanded(
                child: Text(
                  Translations.of(context).scan.search,
                  style: TextStyle(
                    fontSize: TextSize.mediumTitle,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
