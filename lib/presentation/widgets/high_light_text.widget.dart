import 'package:flutter/material.dart';
//https://stackoverflow.com/questions/52917243/how-to-highlight-a-word-in-string-in-flutter-programmatically

class HighlightText extends StatelessWidget {
  final String text;
  final String highlight;
  final TextStyle style;
  final bool ignoreCase;

  const HighlightText({
    super.key,
    required this.text,
    required this.highlight,
    required this.style,
    this.ignoreCase = false,
  });

  @override
  Widget build(BuildContext context) {
    final text = this.text ?? '';
    if ((highlight?.isEmpty ?? true) || text.isEmpty) {
      return Text(text, style: style);
    }

    var sourceText = ignoreCase ? text.toLowerCase() : text;
    var targetHighlight = ignoreCase ? highlight.toLowerCase() : highlight;

    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;
    do {
      indexOfHighlight = sourceText.indexOf(targetHighlight, start);
      if (indexOfHighlight < 0) {
        spans.add(_normalSpan(text.substring(start)));
        break;
      }
      if (indexOfHighlight > start) {
        spans.add(_normalSpan(text.substring(start, indexOfHighlight)));
      }
      start = indexOfHighlight + highlight.length;
      spans.add(_highlightSpan(text.substring(indexOfHighlight, start)));
    } while (true);

    return Text.rich(TextSpan(children: spans));
  }

  TextSpan _highlightSpan(String content) {
    return TextSpan(text: content, style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w700));
  }

  TextSpan _normalSpan(String content) {
    return TextSpan(text: content, style: style);
  }
}
