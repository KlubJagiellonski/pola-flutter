import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/pages/search/search_bloc.dart';
import 'package:pola_flutter/pages/search/search_event.dart';
import 'package:pola_flutter/pages/search/search_state.dart';
import 'package:pola_flutter/pages/search/widgets/recent_history_section.dart';
import 'package:pola_flutter/pages/search/widgets/search_app_bar.dart';
import 'package:pola_flutter/pages/search/widgets/search_floating_actions.dart';
import 'package:pola_flutter/pages/search/widgets/search_input.dart';
import 'package:pola_flutter/theme/colors.dart';

class SearchHistoryPage extends StatefulWidget {
  const SearchHistoryPage({super.key});

  @override
  State<SearchHistoryPage> createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  final _filterController = TextEditingController();
  String _filter = '';

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
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
        appBar: SearchAppBar(title: t.search.historyTitle),
        floatingActionButton: HistoryFloatingActions(
          onScannerTap: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        body: SafeArea(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              final filteredHistory = context.read<SearchBloc>().filterHistory(
                _filter,
              );

              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    sliver: SliverToBoxAdapter(
                      child: SearchInput(
                        controller: _filterController,
                        query: _filter,
                        hintText: t.search.historyHint,
                        onChanged: (value) {
                          setState(() {
                            _filter = value;
                          });
                        },
                        onClear: () {
                          _filterController.clear();
                          setState(() {
                            _filter = '';
                          });
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  if (state.history.isEmpty)
                    const SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverToBoxAdapter(child: EmptyHistory()),
                    )
                  else if (_filter.trim().isNotEmpty)
                    FullHistorySection(products: filteredHistory)
                  else ...[
                    SearchHistoryPreview(products: state.history.take(3)),
                    const SliverToBoxAdapter(child: SizedBox(height: 16)),
                    const SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverToBoxAdapter(
                        child: Divider(color: AppColors.divider),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 16)),
                    FullHistorySection(products: state.history),
                  ],
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
}
