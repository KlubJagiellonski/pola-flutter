import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';

class ReportPage extends StatefulWidget {
  final int? productId;

  const ReportPage({Key? key, this.productId}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

enum _ReportState { initial, loading, success, error }

class _ReportPageState extends State<ReportPage> {
  final _controller = TextEditingController();
  final _repository = PolaApiRepository();
  _ReportState _state = _ReportState.initial;
  bool _attachSystemInfo = false;
  bool _descriptionEmpty = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String> _buildDescription() async {
    var description = _controller.text.trim();
    if (_attachSystemInfo) {
      final info = await PackageInfo.fromPlatform();
      final sysInfo = '\n\n--- System info ---'
          '\nOS: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}'
          '\nApp: ${info.version}+${info.buildNumber}';
      description += sysInfo;
    }
    return description;
  }

  Future<void> _submit() async {
    if (_controller.text.trim().isEmpty) {
      setState(() => _descriptionEmpty = true);
      return;
    }
    setState(() => _descriptionEmpty = false);

    setState(() => _state = _ReportState.loading);

    final fullDescription = await _buildDescription();

    final success = await _repository.createReport(
      description: fullDescription,
      productId: widget.productId,
    );

    if (!mounted) return;
    setState(() => _state = success ? _ReportState.success : _ReportState.error);

    if (success) {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: _state == _ReportState.success
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 24.0),
                child: _SuccessView(t: t),
              )
            : _FormView(
                t: t,
                controller: _controller,
                attachSystemInfo: _attachSystemInfo,
                isLoading: _state == _ReportState.loading,
                hasError: _state == _ReportState.error,
                onSystemInfoChanged: (val) =>
                    setState(() => _attachSystemInfo = val),
                onSubmit: _submit,
                descriptionEmpty: _descriptionEmpty,
                onDescriptionChanged: (_) =>
                    setState(() => _descriptionEmpty = false),
              ),
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
  final ValueChanged<bool> onSystemInfoChanged;
  final VoidCallback onSubmit;
  final bool descriptionEmpty;
  final ValueChanged<String> onDescriptionChanged;

  const _FormView({
    required this.t,
    required this.controller,
    required this.attachSystemInfo,
    required this.isLoading,
    required this.hasError,
    required this.onSystemInfoChanged,
    required this.onSubmit,
    required this.descriptionEmpty,
    required this.onDescriptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 24.0),
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
                    style: const TextStyle(color: AppColors.defaultRed, fontSize: 13.0),
                  ),
                ],
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: isLoading ? null : () => onSystemInfoChanged(!attachSystemInfo),
                  child: Row(
                    children: [
                      _CircleCheckbox(checked: attachSystemInfo),
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

class _CircleCheckbox extends StatelessWidget {
  final bool checked;

  const _CircleCheckbox({required this.checked});

  @override
  Widget build(BuildContext context) {
    final color = checked ? AppColors.defaultRed : AppColors.inactive;
    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.5),
      ),
      child: checked
          ? Icon(Icons.check, size: 13.0, color: AppColors.defaultRed)
          : null,
    );
  }
}

class _SuccessView extends StatelessWidget {
  final Translations t;

  const _SuccessView({required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(
          Icons.check_circle_outline,
          color: AppColors.defaultRed,
          size: 72.0,
        ),
        const SizedBox(height: 24.0),
        Text(
          t.reportScreen.successTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: TextSize.pageTitle,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.lato,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          t.reportScreen.successMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: TextSize.mediumTitle,
            fontFamily: FontFamily.lato,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }
}
