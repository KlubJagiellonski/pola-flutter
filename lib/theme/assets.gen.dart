/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class $AssetsCompanyGen {
  const $AssetsCompanyGen();

  /// File path: assets/company/heart.svg
  SvgGenImage get heart => const SvgGenImage('assets/company/heart.svg');

  /// File path: assets/company/info.svg
  SvgGenImage get info => const SvgGenImage('assets/company/info.svg');

  /// File path: assets/company/radio_button_unchecked.svg
  SvgGenImage get radioButtonUnchecked => const SvgGenImage('assets/company/radio_button_unchecked.svg');

  /// File path: assets/company/task_alt.svg
  SvgGenImage get taskAlt => const SvgGenImage('assets/company/task_alt.svg');

  /// File path: assets/company/unpublished.svg
  SvgGenImage get unpublished => const SvgGenImage('assets/company/unpublished.svg');

  /// List of all assets
  List<SvgGenImage> get values => [heart, info, radioButtonUnchecked, taskAlt, unpublished];
}

class $AssetsMenuPageGen {
  const $AssetsMenuPageGen();

  /// File path: assets/menuPage/diversity.svg
  SvgGenImage get diversity => const SvgGenImage('assets/menuPage/diversity.svg');

  /// File path: assets/menuPage/github.svg
  SvgGenImage get github => const SvgGenImage('assets/menuPage/github.svg');

  /// File path: assets/menuPage/groups.svg
  SvgGenImage get groups => const SvgGenImage('assets/menuPage/groups.svg');

  /// File path: assets/menuPage/handshake.svg
  SvgGenImage get handshake => const SvgGenImage('assets/menuPage/handshake.svg');

  /// File path: assets/menuPage/info.svg
  SvgGenImage get info => const SvgGenImage('assets/menuPage/info.svg');

  /// File path: assets/menuPage/menu.svg
  SvgGenImage get menu => const SvgGenImage('assets/menuPage/menu.svg');

  /// File path: assets/menuPage/star.svg
  SvgGenImage get star => const SvgGenImage('assets/menuPage/star.svg');

  /// File path: assets/menuPage/thumbs.svg
  SvgGenImage get thumbs => const SvgGenImage('assets/menuPage/thumbs.svg');

  /// List of all assets
  List<SvgGenImage> get values => [diversity, github, groups, handshake, info, menu, star, thumbs];
}

class $AssetsNavigationGen {
  const $AssetsNavigationGen();

  /// File path: assets/navigation/close.svg
  SvgGenImage get close => const SvgGenImage('assets/navigation/close.svg');

  /// List of all assets
  List<SvgGenImage> get values => [close];
}

class Assets {
  Assets._();

  static const $AssetsCompanyGen company = $AssetsCompanyGen();
  static const AssetGenImage icAddBlack24dp = AssetGenImage('assets/ic_add_black_24dp.png');
  static const AssetGenImage icBackspaceWhite36dp = AssetGenImage('assets/ic_backspace_white_36dp.png');
  static const AssetGenImage icDialpadWhite36dp = AssetGenImage('assets/ic_dialpad_white_36dp.png');
  static const AssetGenImage icDoneWhite36dp = AssetGenImage('assets/ic_done_white_36dp.png');
  static const AssetGenImage icFlashOffWhite48dp = AssetGenImage('assets/ic_flash_off_white_48dp.png');
  static const AssetGenImage icFlashOnWhite48dp = AssetGenImage('assets/ic_flash_on_white_48dp.png');
  static const AssetGenImage icLauncher = AssetGenImage('assets/ic_launcher.png');
  static const AssetGenImage menu = AssetGenImage('assets/menu.png');
  static const $AssetsMenuPageGen menuPage = $AssetsMenuPageGen();
  static const $AssetsNavigationGen navigation = $AssetsNavigationGen();

  /// List of all assets
  static List<AssetGenImage> get values => [
        icAddBlack24dp,
        icBackspaceWhite36dp,
        icDialpadWhite36dp,
        icDoneWhite36dp,
        icFlashOffWhite48dp,
        icFlashOnWhite48dp,
        icLauncher,
        menu
      ];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final BytesLoader loader;
    if (_isVecFormat) {
      loader = AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ?? (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
