 import 'package:flutter/material.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'detail_lidl.dart';
import 'detail_content.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key, required this.searchResult}) : super(key: key);

  final SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    if (searchResult.companies != null && searchResult.companies!.length == 2) {
      return LidlDetailPage(searchResult: searchResult);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: _MarqueeText(searchResult.name ?? ""),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              DetailContent(searchResult),
            ],
          ),
        ),
      ),
    );
  }
}

class _MarqueeText extends StatefulWidget {
  final String text;

  const _MarqueeText(this.text, {Key? key}) : super(key: key);

  @override
  State<_MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<_MarqueeText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  static const int _maxCharacterCount = 20; 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    return Container(
      width: double.infinity,
      child: ClipRect(
        child: widget.text.length > _maxCharacterCount 
          ? _buildAnimatedText(textStyle) 
          : Text(widget.text, style: textStyle),
      ),
    );
  }

  Widget _buildAnimatedText(TextStyle textStyle) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Row(
          children: [
            Transform.translate(
              offset: Offset(-MediaQuery.of(context).size.width * _animation.value, 0),
              child: Row(
                children: [
                  Text(widget.text, style: textStyle),
                  const SizedBox(width: 20),  
                  Text(widget.text, style: textStyle),  
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}