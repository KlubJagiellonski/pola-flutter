import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/models/product_search_response.dart';
import 'package:pola_flutter/pages/search/search_bloc.dart';
import 'package:pola_flutter/pages/search/search_event.dart';
import 'package:pola_flutter/pages/search/search_state.dart';
import 'package:pola_flutter/pages/search/widgets/product_search_tile.dart';
import 'package:pola_flutter/pages/search/widgets/section_header.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/text_size.dart';

class RecentHistorySection extends StatelessWidget {
  final SearchState state;

  const RecentHistorySection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final recentProducts = state.history.take(3).toList();
    if (recentProducts.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SearchHistoryPreview(products: recentProducts);
  }
}

class SearchHistoryPreview extends StatelessWidget {
  final Iterable<ProductSearchItem> products;

  const SearchHistoryPreview({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final productsList = products.toList();

    return SliverMainAxisGroup(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: SectionHeader(
              title: t.search.recentSearches,
              actionText: t.search.clear,
              onActionTap: () {
                context.read<SearchBloc>().add(
                  const SearchEvent.historyCleared(),
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList.builder(
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              return ProductSearchTile(product: productsList[index]);
            },
          ),
        ),
      ],
    );
  }
}

class FullHistorySection extends StatelessWidget {
  final Iterable<ProductSearchItem> products;

  const FullHistorySection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final productsList = products.toList();

    return SliverMainAxisGroup(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: SearchSectionTitle(title: t.search.fullHistory),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        if (productsList.isEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(t.search.noHistoryResults),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.builder(
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                return ProductSearchTile(product: productsList[index]);
              },
            ),
          ),
      ],
    );
  }
}

class EmptyHistory extends StatelessWidget {
  const EmptyHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Text(
        t.search.emptyHistory,
        style: const TextStyle(
          color: AppColors.text,
          fontSize: TextSize.mediumTitle,
        ),
      ),
    );
  }
}
