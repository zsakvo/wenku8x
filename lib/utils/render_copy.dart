// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class TextPageMap {
  List<String> lines;
  final double renderHeight;
  final int spaceNum;
  bool verticalAlign;
  List<InlineSpan> spans;

  int get paraNums {
    return lines.length - spaceNum;
  }

  TextPageMap(
      {this.lines = const [],
      required this.renderHeight,
      required this.spaceNum,
      this.spans = const [],
      this.verticalAlign = true});

  List<InlineSpan> getPageSpan(
      {required double paragraphHeight,
      required double pageHeight,
      required TextStyle textStyle}) {
    double realRenderHeight = renderHeight;
    if (lines.isNotEmpty && lines.last.trim().isEmpty) {
      realRenderHeight = renderHeight - paragraphHeight;
      lines.removeLast();
    }

    final extraHeight =
        verticalAlign ? (pageHeight - realRenderHeight) / (spaceNum - 1) : 0;

    // return lines.map((line) {
    //   return TextSpan(
    //       text: line,
    //       style: line.trim().isEmpty
    //           ? TextStyle(height: paragraphHeight + extraHeight, fontSize: 1)
    //           : textStyle);
    // }).toList();
    return spans;
  }
}

class RenderUtil {
  static splitRichText(context,
      {required String name,
      required String title,
      int? cIndex,
      String? text,
      List<String>? textArr,
      EdgeInsets padding = EdgeInsets.zero,
      TextStyle textStyle =
          const TextStyle(fontSize: 18, color: Colors.black, height: 1.7)}) {
    var paragraphHeight = 12.0;
    var textLines = text?.split("\n") ?? textArr ?? [];
    var width =
        MediaQuery.of(context).size.width - padding.left - padding.right;
    var height = MediaQuery.of(context).size.height -
        padding.top -
        padding.bottom -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    // List<String> tempTextLines = [];

    List<InlineSpan> tempTextSpans = [];

    final titleStyle = textStyle.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: textStyle.fontSize != null ? (textStyle.fontSize! + 2) : 16);

    final titleSpan = TextSpan(children: [
      const TextSpan(
          text: " \n",
          style: TextStyle(fontSize: 1, height: 42, color: Colors.red)),
      TextSpan(
        text: title,
        style: titleStyle,
      ),
      const TextSpan(
          text: "\n \n",
          style: TextStyle(fontSize: 1, height: 64, color: Colors.red)),
    ]);

    final TextPainter titlePainter =
        TextPainter(text: titleSpan, textDirection: TextDirection.ltr);

    titlePainter.layout(maxWidth: width);
    final mls = titlePainter.computeLineMetrics();
    final titleHeight = mls.last.baseline - mls.last.ascent;
    double currentHeight = titleHeight;
    int spaceNum = 0;
    List<TextPageMap> textPageMaps = [];

    newPage() {
      textPageMaps.add(TextPageMap(
          // lines: tempTextLines,
          renderHeight: currentHeight,
          spans: tempTextSpans,
          spaceNum: spaceNum));

      currentHeight = 0.0;
      spaceNum = 0;
      // tempTextLines = [];
      tempTextSpans = [];
    }

    outLoop:
    while (textLines.isNotEmpty) {
      var textLine = textLines[0].trim();
      if (textLine.isEmpty) {
        textLines.removeAt(0);
        continue;
      }
      textLine = "国国$textLine";
      TextSpan textSpan = TextSpan(text: textLine, style: textStyle);
      TextPainter textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.justify,
          textDirection: TextDirection.ltr);
      textPainter.layout(maxWidth: width);
      var paintLines = textPainter.computeLineMetrics();
      late double dy;
      int begin = 2;
      for (var j = 0; j < paintLines.length; j++) {
        var paintLine = paintLines[j];
        var lineWidth = paintLine.width;
        var lineHeight = paintLine.height;
        dy = paintLine.baseline;
        if (currentHeight + lineHeight <= height) {
          // 绘制高度小于布局高度
          currentHeight += lineHeight;
          var tr = textPainter.getPositionForOffset(Offset(lineWidth, dy));
          // tempTextLines.add(textLine.substring(begin, tr.offset));
          // 推入临时 tempTextSpans
          // if (j == 0) {
          //   tempTextSpans.add(WidgetSpan(
          //       child: Container(
          //     width: 2 * 15,
          //     height: 20,
          //     color: Colors.blue,
          //   )));
          // }
          tempTextSpans.add(WidgetSpan(
              child: Container(
            color: Colors.green,
            width: j == 0 ? width : null,
            child: Text(
              textLine.substring(begin, tr.offset),
              style: textStyle,
              textAlign: j == 0 ? TextAlign.right : TextAlign.justify,
            ),
          )));
          begin = tr.offset;
        } else {
          newPage();
          // 绘制高度溢出，跳出循环
          if (j == 0) {
            textLines[0] = textLine;
            continue outLoop;
          } else {
            var tr = textPainter.getPositionForOffset(
                Offset(paintLines[j - 1].width, paintLines[j - 1].baseline));
            textLines[0] = textLine.substring(tr.offset);
            continue outLoop;
          }
        }
      }

      if (currentHeight + paragraphHeight + paragraphHeight > height) {
        newPage();
      } else {
        // tempTextLines.add("\n \n");
        tempTextSpans.add(WidgetSpan(
            child: Container(
          height: paragraphHeight,
          width: width,
          color: Colors.red,
        )));
        spaceNum++;
        currentHeight += paragraphHeight;
      }
      // 本次绘制全部上屏，弹出第一个
      textLines.removeAt(0);
    }
    // final pageTextSpan = tempTextLines.map((line) {
    //   return TextSpan(
    //       text: line,
    //       style: line.trim().isEmpty
    //           ? TextStyle(height: paragraphHeight, fontSize: 1)
    //           : textStyle);
    // }).toList();
    // if (tempTextLines.isNotEmpty) {
    //   textPageMaps.add(TextPageMap(
    //       lines: tempTextLines,
    //       renderHeight: currentHeight,
    //       spaceNum: spaceNum,
    //       verticalAlign: false));
    // }
    if (tempTextSpans.isNotEmpty) {
      textPageMaps.add(TextPageMap(
          // lines: tempTextLines,
          renderHeight: currentHeight,
          spaceNum: spaceNum,
          verticalAlign: false,
          spans: tempTextSpans));
    }

    // richTexts.add(
    //   RichText(
    //     text: TextSpan(children: pageTextSpan),
    //     textAlign: TextAlign.justify,
    //   ),
    // );

    int pi = 0;
    return textPageMaps
        .asMap()
        .map((index, item) {
          // int pi = 0;
          final span = item.getPageSpan(
              paragraphHeight: paragraphHeight,
              pageHeight: height,
              textStyle: textStyle);
          if (index == 0) span.insert(0, titleSpan);
          pi += (index == 0 ? 0 : textPageMaps[index - 1].paraNums);
          return MapEntry(
              index,
              Stack(
                key: ValueKey({"cIndex": cIndex, 'pIndex': pi}),
                children: [
                  Padding(
                    padding: padding.copyWith(bottom: 0),
                    child: RichText(
                      text: TextSpan(children: span),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 20,
                    right: 20,
                    child: Text(
                      index == 0 ? name : title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.7),
                          fontSize: 13),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 20,
                    child: Text(
                      "${index + 1}/${textPageMaps.length}",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.7),
                          fontSize: 13),
                    ),
                  )
                ],
              ));
        })
        .values
        .toList();
  }
}
