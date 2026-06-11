import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/models/product_search_response.dart';
import 'package:pola_flutter/pages/search/search_bloc.dart';
import 'package:pola_flutter/pages/search/search_event.dart';
import 'package:pola_flutter/pages/search/search_state.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'package:pola_flutter/ui/product_list_item.dart';

class ProductSearchTile extends StatelessWidget {
  final ProductSearchItem product;

  const ProductSearchTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SearchBloc, SearchState, bool>(
      selector: (state) =>
          state.isOpeningResult && state.openingProduct?.code == product.code,
      builder: (context, isOpening) {
        return ProductListItem(
          score: product.score,
          title: product.name,
          subtitle: product.subtitle,
          height: 64,
          scoreWidth: 52,
          margin: const EdgeInsets.symmetric(vertical: 4),
          border: Border.all(color: AppColors.divider),
          titleStyle: const TextStyle(
            color: AppColors.text,
            fontSize: TextSize.smallTitle,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.lato,
          ),
          subtitleStyle: const TextStyle(
            color: AppColors.text,
            fontSize: TextSize.description,
            fontFamily: FontFamily.lato,
          ),
          titleMaxLines: 2,
          onTap: isOpening
              ? null
              : () {
                  context.read<SearchBloc>().add(
                    SearchProductSelected(product),
                  );
                },
          trailing: isOpening
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.chevron_right, color: AppColors.text),
        );
      },
    );
  }
}
