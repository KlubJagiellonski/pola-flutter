import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'package:pola_flutter/pages/menu/version_bloc.dart';

class VersionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => VersionBloc()..add(VersionEvent.onApear()), 
      child: BlocBuilder<VersionBloc, VersionState>(
        builder: (context, state) {
          return _VersionLabelWidget(version: state.version);
        },
      )
    );
  }
}

class _VersionLabelWidget extends StatelessWidget {
  final String? version;

  const _VersionLabelWidget({this.version});

    @override
  Widget build(BuildContext context) {
    String? version = this.version;
    if (version == null) {
      return Container();
    }

    return Text(
      version,
      style: TextStyle(
        fontSize: TextSize.smallTitle,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.lato,
        color: AppColors.inactiveColor,
      ),
      textAlign: TextAlign.end,
    );
  }
}
