import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/models/replacement.dart';
import 'package:pola_flutter/pages/detail/detail.dart';
import 'package:pola_flutter/pages/detail/replacement/replacement_bloc.dart';
import 'package:pola_flutter/pages/detail/replacement/replacement_event.dart';
import 'package:pola_flutter/pages/detail/replacement/replacement_state.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
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

    final Translations t = Translations.of(context);
    
    return BlocProvider(
      create: (context) => ReplacementBloc(PolaApiRepository()),
      child: BlocListener<ReplacementBloc, ReplacementState>(
        listener: (context, state) {
          if (state.result != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(searchResult: state.result!),
              ),
            ).then((_) {
              context.read<ReplacementBloc>().add(
                const ReplacementEvent.navigationCompleted(),
              );
            });
          }
        },
        child: BlocBuilder<ReplacementBloc, ReplacementState>(
          builder: (context, state) {
            if (state.isError) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(t.scan.error),
                      content: Text(t.scan.tryAgain),
                      actions: <Widget>[
                        TextButton(
                          child: Text(t.scan.closeError),
                          onPressed: () {
                            context.read<ReplacementBloc>().add(
                              const ReplacementEvent.alertDialogDismissed(),
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              });
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.companyScreen.replecemntSectionTitle,
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
          },
        ),
      ),
    );
  }
}

class _ReplacementCard extends StatelessWidget {
  const _ReplacementCard({Key? key, required this.replacement}) : super(key: key);

  final Replacement replacement;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReplacementBloc, ReplacementState>(
      builder: (context, state) {
        final isLoadingForThisCard = state.isLoading && 
            state.result == null &&
            state.currentReplacement?.code == replacement.code;

        return GestureDetector(
          onTap: isLoadingForThisCard
              ? null
              : () {
                  context.read<ReplacementBloc>().add(
                    ReplacementEvent.replacementTapped(replacement),
                  );
                },
          child: Container(
              width: 160.0,
              decoration: BoxDecoration(
                color: AppColors.buttonBackground,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            replacement.displayName.isNotEmpty
                                ? replacement.displayName
                                : replacement.name,
                            style: TextStyle(
                              fontSize: TextSize.description,
                              fontWeight: FontWeight.w400,
                              fontFamily: FontFamily.lato,
                              color: AppColors.text,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 1.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
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
                            if (replacement.isFriend) ...[
                              const SizedBox(width: 4.0),
                              Assets.company.heart.svg(
                                width: 16.0,
                                height: 16.0,
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isLoadingForThisCard)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
        );
      },
    );
  }
}