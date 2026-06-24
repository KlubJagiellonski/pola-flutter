import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/data/product_search_history_service.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/pages/search/search_bloc.dart';
import 'package:pola_flutter/pages/search/search_event.dart';
import 'package:pola_flutter/pages/search/search_history_page.dart';
import 'package:pola_flutter/pages/search/search_state.dart';
import 'package:pola_flutter/pages/search/widgets/recent_history_section.dart';
import 'package:pola_flutter/pages/search/widgets/search_app_bar.dart';
import 'package:pola_flutter/pages/search/widgets/search_floating_actions.dart';
import 'package:pola_flutter/pages/search/widgets/search_input.dart';
import 'package:pola_flutter/pages/search/widgets/search_results_section.dart';
import 'package:pola_flutter/theme/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final Future<SearchBloc> _blocFuture;
  SearchBloc? _bloc;

  @override
  void initState() {
    super.initState();
    final repository = context.read<PolaApi>();
    _blocFuture = ProductSearchHistoryService.create().then((historyStore) {
      final bloc = SearchBloc(repository, historyStore)
        ..add(const SearchEvent.started());
      _bloc = bloc;
      return bloc;
    });
  }

  @override
  void dispose() {
    _bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SearchBloc>(
      future: _blocFuture,
      builder: (context, snapshot) {
        final bloc = snapshot.data;
        if (bloc == null) {
          return const Scaffold(
            backgroundColor: AppColors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return BlocProvider.value(value: bloc, child: const _SearchView());
      },
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final _queryController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _queryController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 240) {
      context.read<SearchBloc>().add(const SearchEvent.nextPageRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listenWhen: (previous, current) =>
          previous.resultToOpen != current.resultToOpen ||
          previous.selectionErrorMessage != current.selectionErrorMessage,
      listener: _onStateChanged,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: SearchAppBar(title: t.search.title),
        floatingActionButton: SearchFloatingActions(
          onHistoryTap: _openHistory,
          onScannerTap: () => Navigator.of(context).pop(),
        ),
        body: SafeArea(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    sliver: SliverToBoxAdapter(
                      child: SearchInput(
                        controller: _queryController,
                        query: state.query,
                        hintText: t.search.hint,
                        showSearchIcon: state.query.isEmpty,
                        onChanged: (query) {
                          context.read<SearchBloc>().add(
                            SearchEvent.queryChanged(query),
                          );
                        },
                        onClear: () {
                          _queryController.clear();
                          context.read<SearchBloc>().add(
                            const SearchEvent.queryChanged(''),
                          );
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  if (state.hasSearchableQuery)
                    SearchResultsSection(state: state),
                  RecentHistorySection(state: state),
                  const SliverToBoxAdapter(child: SizedBox(height: 96)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _onStateChanged(BuildContext context, SearchState state) {
    final resultToOpen = state.resultToOpen;
    if (resultToOpen != null) {
      context.read<SearchBloc>().add(const SearchEvent.resultOpened());
      Navigator.of(context).pushNamed('/detail', arguments: resultToOpen);
      return;
    }

    final selectionErrorMessage = state.selectionErrorMessage;
    if (selectionErrorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.search.openError)));
      context.read<SearchBloc>().add(const SearchEvent.selectionErrorShown());
    }
  }

  void _openHistory() {
    final bloc = context.read<SearchBloc>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            BlocProvider.value(value: bloc, child: const SearchHistoryPage()),
      ),
    );
  }
}
