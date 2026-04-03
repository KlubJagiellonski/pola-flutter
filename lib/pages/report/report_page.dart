import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/pages/report/report_bloc.dart';
import 'package:pola_flutter/pages/report/report_event.dart';
import 'package:pola_flutter/pages/report/report_state.dart';
import 'package:pola_flutter/pages/report/report_success_view.dart';
import 'package:pola_flutter/ui/circle_checkbox.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';

class ReportPage extends StatefulWidget {
  final int? productId;

  const ReportPage({Key? key, this.productId}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportBloc(PolaApiRepository(), productId: widget.productId),
      child: BlocConsumer<ReportBloc, ReportState>(
        listenWhen: (prev, curr) => !prev.isSuccess && curr.isSuccess,
        listener: (context, state) async {
          await Future.delayed(const Duration(seconds: 2));
          if (context.mounted) Navigator.of(context).pop();
        },
        builder: (context, state) {
          final t = Translations.of(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                t.reportScreen.title,
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: TextSize.newsTitle,
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: SafeArea(
              child: state.isSuccess
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 17.0, vertical: 24.0),
                      child: ReportSuccessView(t: t),
                    )
                  : _FormView(
                      t: t,
                      controller: _controller,
                      attachSystemInfo: state.attachSystemInfo,
                      isLoading: state.isLoading,
                      hasError: state.isError,
                      descriptionEmpty: state.descriptionEmpty,
                      onSystemInfoChanged: (val) => context
                          .read<ReportBloc>()
                          .add(ReportEvent.systemInfoToggled(val)),
                      onSubmit: () => context
                          .read<ReportBloc>()
                          .add(ReportEvent.submitted(_controller.text)),
                      onDescriptionChanged: (_) => context
                          .read<ReportBloc>()
                          .add(const ReportEvent.descriptionChanged()),
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _FormView extends StatelessWidget {
  final Translations t;
  final TextEditingController controller;
  final bool attachSystemInfo;
  final bool isLoading;
  final bool hasError;
  final bool descriptionEmpty;
  final ValueChanged<bool> onSystemInfoChanged;
  final VoidCallback onSubmit;
  final ValueChanged<String> onDescriptionChanged;

  const _FormView({
    required this.t,
    required this.controller,
    required this.attachSystemInfo,
    required this.isLoading,
    required this.hasError,
    required this.descriptionEmpty,
    required this.onSystemInfoChanged,
    required this.onSubmit,
    required this.onDescriptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 17.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    t.reportScreen.descriptionLabel,
                    style: TextStyle(
                      fontSize: TextSize.mediumTitle,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.lato,
                      color: AppColors.text,
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                TextField(
                  controller: controller,
                  maxLines: 8,
                  enabled: !isLoading,
                  onChanged: onDescriptionChanged,
                  decoration: InputDecoration(
                    hintText: t.reportScreen.hint,
                    hintStyle: TextStyle(
                      color: AppColors.inactive,
                      fontFamily: FontFamily.lato,
                      fontSize: TextSize.mediumTitle,
                    ),
                    filled: true,
                    fillColor: AppColors.textField,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                  style: TextStyle(
                    fontFamily: FontFamily.lato,
                    fontSize: TextSize.mediumTitle,
                    color: AppColors.text,
                  ),
                ),
                if (descriptionEmpty) ...[
                  const SizedBox(height: 6.0),
                  Text(
                    t.reportScreen.descriptionRequired,
                    style: const TextStyle(
                        color: AppColors.defaultRed, fontSize: 13.0),
                  ),
                ],
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: isLoading
                      ? null
                      : () => onSystemInfoChanged(!attachSystemInfo),
                  child: Row(
                    children: [
                      CircleCheckbox(checked: attachSystemInfo),
                      const SizedBox(width: 8.0),
                      Text(
                        t.reportScreen.attachSystemInfo,
                        style: TextStyle(
                          fontSize: TextSize.description + 1,
                          fontFamily: FontFamily.lato,
                          color: AppColors.inactive,
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasError) ...[
                  const SizedBox(height: 8.0),
                  Text(
                    t.reportScreen.errorMessage,
                    style: const TextStyle(color: AppColors.defaultRed),
                  ),
                ],
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(17.0, 8.0, 17.0, 16.0),
          child: ElevatedButton(
            onPressed: isLoading ? null : onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.defaultRed,
              disabledBackgroundColor: AppColors.inactive,
              minimumSize: const Size(double.infinity, 0),
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.0,
                    ),
                  )
                : Text(
                    t.reportScreen.send,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: TextSize.mediumTitle,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
