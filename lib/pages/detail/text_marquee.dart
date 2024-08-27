import 'package:flutter/material.dart';
// Copy/pasted from https://github.com/radnive/Flutter_TextMarquee/blob/main/lib/text_marquee.dart
// and added initState method to fix missing animation when added to AppBar.

class TextMarquee extends StatefulWidget {
  /// Text to be scrolled.
  final String text;

  /// Text style.
  final TextStyle style;

  /// Animation duration.
  final Duration? duration;

  /// Animation curve.
  final Curve curve;

  /// Delay time for scrolling start.
  final Duration delay;

  /// The distance between the original text and its subsequent repetition.
  /// ALERT: This value will be add to [startPaddingSize]
  final double spaceSize;

  /// Text spacing from the beginning of the widget.
  /// ALERT: This value will be add to [spaceSize]
  final double startPaddingSize;

  /// If the text is arranged from the right, it should have a value of True.
  final bool rtl;

  /// Create TextMarquee
  const TextMarquee(this.text,
      {Key? key,
      this.style = const TextStyle(),
      this.duration,
      this.curve = Curves.linear,
      this.delay = const Duration(seconds: 2),
      this.spaceSize = 32,
      this.startPaddingSize = 0,
      this.rtl = false})
      : super(key: key);

  @override
  State<TextMarquee> createState() => _TextMarqueeState();
}

class _TextMarqueeState extends State<TextMarquee> {
  /// To control text scrolling (actually SingleChildScrollView).
  final ScrollController _scrollController = ScrollController();

  /// To save the length of the text.
  double _textWidth = 0;

  /// To save whether the text length is longer than the widget length or not!
  bool _isLarger = false;

  /// To save whether the text is scrolling or not!
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimating();
    });
  }

  @override
  void didUpdateWidget(TextMarquee oldWidget) {
    // The commands inside this callback are executed after the build function.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // If the text is not scrolling, the animation will start.
      if (!_isScrolling) {
        _startAnimating();
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _startAnimating() async {
    // If the text is not larger than widget, Scrolling will stop.
    if (!_isLarger) {
      _isScrolling = false;
      return;
    }

    // Apply delay to start scrolling.
    await Future.delayed(widget.delay);

    // Ensure the widget is still mounted before proceeding
    if (!mounted) return;

    // Calculate scrolling length.
    double scrollLength =
        _textWidth + widget.spaceSize + widget.startPaddingSize;

    // Scroll to the end of SingleChildScrollView.
    await _scrollController.animateTo(scrollLength,
        duration: (widget.duration != null)
            ? widget.duration!
            : Duration(milliseconds: (scrollLength * 27).toInt()),
        curve: widget.curve);

    // Ensure the widget is still mounted before jumping
    if (!mounted) return;

    // Jump to start of SingleChildScrollView. (without animation)
    _scrollController.jumpTo(0);

    // Change scrolling status.
    _isScrolling = true;

    // Repeat animation.
    _startAnimating();
  }

  @override
  Widget build(BuildContext context) {
    // Get the text width.
    _textWidth = _getTextWidth(context);

    return LayoutBuilder(
      builder: (_, constraint) {
        // Check if the text length is longer than the widget length or not!.
        _isLarger = constraint.maxWidth <= _textWidth;

        return Directionality(
          textDirection: TextDirection.ltr,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              controller: _scrollController,
              reverse: widget.rtl,
              child: Row(
                children: [
                  SizedBox(width: widget.startPaddingSize),
                  Text(widget.text, style: widget.style, maxLines: 1),
                  (_isLarger)
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: widget.spaceSize + widget.startPaddingSize),
                          child: Text(widget.text,
                              style: widget.style, maxLines: 1),
                        )
                      : const SizedBox()
                ],
              )),
        );
      },
    );
  }

  double _getTextWidth(BuildContext context) {
    // If the text is blank, its length is zero.
    if (widget.text.isEmpty) {
      return 0;
    }

    // Create textSpan from the text and its style.
    final span = TextSpan(text: widget.text, style: widget.style);

    // Determine max width of the textSpan layout.
    const constraints = BoxConstraints(maxWidth: double.infinity);

    // Build text widget.
    final richTextWidget = Text.rich(span).build(context) as RichText;

    // Create render object from text widget.
    final renderObject = richTextWidget.createRenderObject(context);

    // Set layout constraint to render object.
    renderObject.layout(constraints);

    // Get text width from render object.
    final boxes = renderObject.getBoxesForSelection(TextSelection(
      baseOffset: 0,
      extentOffset: TextSpan(text: widget.text).toPlainText().length,
    ));

    // Return width of text.
    return boxes.last.right;
  }

  @override
  void dispose() {
    _isLarger = false;
    _scrollController.dispose();
    super.dispose();
  }
}