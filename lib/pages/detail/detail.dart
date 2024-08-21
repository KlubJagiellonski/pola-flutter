 import 'package:flutter/material.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'detail_lidl.dart';
import 'detail_content.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.searchResult}) : super(key: key);

  final SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    if (searchResult.companies != null && searchResult.companies!.length == 2) {
      return LidlDetailPage(searchResult: searchResult);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: _ScrollingText(text: searchResult.name ?? "Unknown Company"),
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

class _ScrollingText extends StatefulWidget {
  final String text;

  const _ScrollingText({Key? key, required this.text}) : super(key: key);

  @override
  State<_ScrollingText> createState() => _ScrollingTextState();
}

class _ScrollingTextState extends State<_ScrollingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10), 
      vsync: this,
    )..repeat(); 

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

   
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();

    final textWidth = textPainter.width;

    return Container(
      width: double.infinity,
      height: 24,  
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
    
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
 
              double offset = -screenWidth * _animation.value;
 
              if (textWidth < screenWidth) {
                offset = 0;
              }

              return Transform.translate(
              
                offset: Offset(offset, 0),
                child: Row(
                  children: [
                    Text(
                      widget.text,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),  
                    Text(
                      widget.text,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
