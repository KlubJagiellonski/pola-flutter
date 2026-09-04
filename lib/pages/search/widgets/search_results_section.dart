import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/pages/search/search_bloc.dart';
import 'package:pola_flutter/pages/search/search_event.dart';
import 'package:pola_flutter/pages/search/search_state.dart';
import 'package:pola_flutter/pages/search/widgets/product_search_tile.dart';
import 'package:pola_flutter/pages/search/widgets/search_error.dart';
import 'package:pola_flutter/pages/search/widgets/section_header.dart';
import 'package:pola_flutter/theme/colors.dart';

class SearchResultsSection extends StatelessWidget {
  final SearchState state;

  const SearchResultsSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.requestState == SearchRequestState.typing && !state.hasResults) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    if (state.requestState == SearchRequestState.loading && !state.hasResults) {
      return const SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }

    if (state.requestState == SearchRequestState.error && !state.hasResults) {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverToBoxAdapter(
          child: SearchError(
            onRetry: () {
              context.read<SearchBloc>().add(
                const SearchEvent.retryRequested(),
              );
            },
          ),
        ),
      );
    }

    if (!state.hasResults) {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: SearchSectionTitle(title: t.search.noResults),
          ),
        ),
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SearchSectionTitle(
                title: _resultsCountText(state.totalItems),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList.builder(
            itemCount: state.results.length,
            itemBuilder: (context, index) {
              return ProductSearchTile(product: state.results[index]);
            },
          ),
        ),
        if (state.requestState == SearchRequestState.loadingMore)
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        if (state.requestState == SearchRequestState.error)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: SearchError(
                compact: true,
                onRetry: () {
                  context.read<SearchBloc>().add(
                    const SearchEvent.nextPageRequested(),
                  );
                },
              ),
            ),
          ),
        const SliverPadding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 20),
          sliver: SliverToBoxAdapter(child: Divider(color: AppColors.divider)),
        ),
      ],
    );
  }

  String _resultsCountText(int count) {
    if (count == 1) {
      return t.search.resultsCountOne;
    }
    return t.search.resultsCountMany(count: count);
  }
}
