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

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// Directory path: assets/icons/2.0x
  $AssetsIcons20xGen get a2 => const $AssetsIcons20xGen();

  /// Directory path: assets/icons/3.0x
  $AssetsIcons30xGen get a3 => const $AssetsIcons30xGen();

  /// File path: assets/icons/diversity.png
  AssetGenImage get diversity => const AssetGenImage('assets/icons/diversity.png');

  /// File path: assets/icons/github.png
  AssetGenImage get github => const AssetGenImage('assets/icons/github.png');

  /// File path: assets/icons/groups.png
  AssetGenImage get groups => const AssetGenImage('assets/icons/groups.png');

  /// File path: assets/icons/handshake.png
  AssetGenImage get handshake => const AssetGenImage('assets/icons/handshake.png');

  /// File path: assets/icons/info.png
  AssetGenImage get info => const AssetGenImage('assets/icons/info.png');

  /// File path: assets/icons/star.png
  AssetGenImage get star => const AssetGenImage('assets/icons/star.png');

  /// File path: assets/icons/thumbs.png
  AssetGenImage get thumbs => const AssetGenImage('assets/icons/thumbs.png');

  /// List of all assets
  List<AssetGenImage> get values => [diversity, github, groups, handshake, info, star, thumbs];
}

class $AssetsIcons20xGen {
  const $AssetsIcons20xGen();

  /// File path: assets/icons/2.0x/diversity.png
  AssetGenImage get diversity => const AssetGenImage('assets/icons/2.0x/diversity.png');

  /// File path: assets/icons/2.0x/github.png
  AssetGenImage get github => const AssetGenImage('assets/icons/2.0x/github.png');

  /// File path: assets/icons/2.0x/groups.png
  AssetGenImage get groups => const AssetGenImage('assets/icons/2.0x/groups.png');

  /// File path: assets/icons/2.0x/handshake.png
  AssetGenImage get handshake => const AssetGenImage('assets/icons/2.0x/handshake.png');

  /// File path: assets/icons/2.0x/info.png
  AssetGenImage get info => const AssetGenImage('assets/icons/2.0x/info.png');

  /// File path: assets/icons/2.0x/star.png
  AssetGenImage get star => const AssetGenImage('assets/icons/2.0x/star.png');

  /// File path: assets/icons/2.0x/thumbs.png
  AssetGenImage get thumbs => const AssetGenImage('assets/icons/2.0x/thumbs.png');

  /// List of all assets
  List<AssetGenImage> get values => [diversity, github, groups, handshake, info, star, thumbs];
}

class $AssetsIcons30xGen {
  const $AssetsIcons30xGen();

  /// File path: assets/icons/3.0x/diversity.png
  AssetGenImage get diversity => const AssetGenImage('assets/icons/3.0x/diversity.png');

  /// File path: assets/icons/3.0x/github.png
  AssetGenImage get github => const AssetGenImage('assets/icons/3.0x/github.png');

  /// File path: assets/icons/3.0x/groups.png
  AssetGenImage get groups => const AssetGenImage('assets/icons/3.0x/groups.png');

  /// File path: assets/icons/3.0x/handshake.png
  AssetGenImage get handshake => const AssetGenImage('assets/icons/3.0x/handshake.png');

  /// File path: assets/icons/3.0x/info.png
  AssetGenImage get info => const AssetGenImage('assets/icons/3.0x/info.png');

  /// File path: assets/icons/3.0x/star.png
  AssetGenImage get star => const AssetGenImage('assets/icons/3.0x/star.png');

  /// File path: assets/icons/3.0x/thumbs.png
  AssetGenImage get thumbs => const AssetGenImage('assets/icons/3.0x/thumbs.png');

  /// List of all assets
  List<AssetGenImage> get values => [diversity, github, groups, handshake, info, star, thumbs];
}

class Assets {
  Assets._();

  static const AssetGenImage back = AssetGenImage('assets/back.png');
  static const AssetGenImage icAddBlack24dp = AssetGenImage('assets/ic_add_black_24dp.png');
  static const AssetGenImage icBackspaceWhite36dp = AssetGenImage('assets/ic_backspace_white_36dp.png');
  static const AssetGenImage icDialpadWhite36dp = AssetGenImage('assets/ic_dialpad_white_36dp.png');
  static const AssetGenImage icDoneWhite36dp = AssetGenImage('assets/ic_done_white_36dp.png');
  static const AssetGenImage icFlashOffWhite48dp = AssetGenImage('assets/ic_flash_off_white_48dp.png');
  static const AssetGenImage icFlashOnWhite48dp = AssetGenImage('assets/ic_flash_on_white_48dp.png');
  static const AssetGenImage icHeart = AssetGenImage('assets/ic_heart.png');
  static const AssetGenImage icLauncher = AssetGenImage('assets/ic_launcher.png');
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const SvgGenImage info = SvgGenImage('assets/info.svg');
  static const AssetGenImage menu = AssetGenImage('assets/menu.png');
  static const SvgGenImage radioButtonUnchecked = SvgGenImage('assets/radio_button_unchecked.svg');
  static const SvgGenImage taskAlt = SvgGenImage('assets/task_alt.svg');

  /// List of all assets
  static List<dynamic> get values => [
        back,
        icAddBlack24dp,
        icBackspaceWhite36dp,
        icDialpadWhite36dp,
        icDoneWhite36dp,
        icFlashOffWhite48dp,
        icFlashOnWhite48dp,
        icHeart,
        icLauncher,
        info,
        menu,
        radioButtonUnchecked,
        taskAlt
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
