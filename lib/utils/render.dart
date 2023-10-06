import 'package:flutter/material.dart';

class RenderUtil {
  static splitRichText(context,
      {required String name,
      required String title,
      int? cIndex,
      String? text,
      List<String>? textArr,
      double paragraphHeight = 12.0,
      EdgeInsets padding = EdgeInsets.zero,
      TextStyle textStyle =
          const TextStyle(fontSize: 18, color: Colors.black, height: 1.7)}) {
    // var paragraphHeight = 12.0;
    var textLines = (text?.split("\n") ?? textArr ?? []);
    var renderWidth =
        MediaQuery.of(context).size.width - padding.left - padding.right;
    var renderHeight = MediaQuery.of(context).size.height -
        padding.top -
        padding.bottom -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    // Log.e(textLines);

    // 绘制单字
    final singleTextSpan = TextSpan(text: "国", style: textStyle);
    final singleTextPainter =
        TextPainter(text: singleTextSpan, textDirection: TextDirection.ltr);
    singleTextPainter.layout();
    // final singleTextHeight =
    //     singleTextPainter.computeLineMetrics().first.height;
    final singleTextWidth = singleTextPainter.computeLineMetrics().first.width;

    // 绘制标题
    final titleStyle = textStyle.copyWith(
        fontSize: textStyle.fontSize! + 4,
        height: textStyle.height!,
        fontWeight: FontWeight.w600);
    final titleSpan = TextSpan(text: title, style: titleStyle);
    final titlePainter =
        TextPainter(text: titleSpan, textDirection: TextDirection.ltr);
    titlePainter.layout();
    final singleTitleHeight = titlePainter.computeLineMetrics().first.height;
    final titleContainerHeight = singleTitleHeight * 3 + titlePainter.height;

    // 当前累积的页面高度（第一页初始高度等于标题容器高度）
    // double currentPaintHeight = titleContainerHeight;
    // 当前页剩余可绘制高度
    double currentRestHeight = renderHeight - titleContainerHeight;
    // 是否需要缩进
    bool needIndent = true;
    // 当前页面的组件列表
    List<InlineSpan> curentPageSpans = [
      WidgetSpan(
        child: Container(
          width: renderWidth,
          height: titleContainerHeight,
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: titleStyle,
            textAlign: TextAlign.justify,
          ),
        ),
      )
    ];

    List<List<InlineSpan>> pages = [];

    // 剩余空间列表
    List<double> restHeights = [];

    // 循环正文数组，直至待绘制内容为空
    while (textLines.isNotEmpty) {
      final textLine = textLines.first;
      if (textLine.isEmpty) {
        textLines.removeAt(0);
        continue;
      }
      final textSpan = TextSpan(text: textLine, style: textStyle);
      final textPainter =
          TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      textPainter.layout(
          maxWidth: renderWidth - (needIndent ? (2 * singleTextWidth) : 0));
      final computeLines = textPainter.computeLineMetrics();
      // Log.e([textLines.first, textPainter.computeLineMetrics().length]);
      // 当前页面可以容纳本次绘制的段落
      if (currentRestHeight > 0) {
        if (computeLines.length == 1) {
          // 当前段落只有一行
          curentPageSpans.addAll([
            if (needIndent)
              WidgetSpan(
                  child: SizedBox(
                width: 2 * singleTextWidth,
              )),
            textSpan,
            const TextSpan(text: "\n")
          ]);
          // 移除对应高度
          currentRestHeight -= (computeLines.first.height + paragraphHeight);
          textLines.removeAt(0);
          needIndent = true;
        } else {
          // for (var i = 0; i < computeLines.length; i++) {
          final line = computeLines.first;
          final lineWidth = line.width;
          final lineHight = line.height;
          //

          if (computeLines.length > 1) {
            // currentRestHeight -= lineHight;
            final offsetForLastWordInLine = textPainter
                .getPositionForOffset(Offset(lineWidth, line.baseline))
                .offset;
            final lineTexts = textLine.substring(0, offsetForLastWordInLine);
            if (needIndent) {
              curentPageSpans.add(
                WidgetSpan(
                    child: SizedBox(
                  width: 2 * singleTextWidth,
                )),
              );
            }
            curentPageSpans.add(TextSpan(text: lineTexts, style: textStyle));
            textLines[0] =
                textLine.substring(offsetForLastWordInLine, textLine.length);
            needIndent = false;
            currentRestHeight -= lineHight;
          } else {
            currentRestHeight -= paragraphHeight;
            textLines.removeAt(0);
            needIndent = true;
          }
        }
      } else {
        // break;
        // 当前页面不可以容纳本次绘制的段落，把已有段落推入页面
        pages.add(curentPageSpans);
        restHeights.add(currentRestHeight);
        curentPageSpans = [];
        currentRestHeight = renderHeight;
      }
    }

    // 最后一页
    pages.add(curentPageSpans);

    int pi = 0;
    return pages
        .asMap()
        .map((index, item) {
          // int pi = 0;
          // final span = item.getPageSpan(
          //     paragraphHeight: paragraphHeight,
          //     pageHeight: height,
          //     textStyle: textStyle);
          // if (index == 0) span.insert(0, titleSpan);
          // item.forEach((element) {
          //   Log.e([element.toPlainText(), element.codeUnitAt(0)]);
          // });
          // final spaceNum = item.where((element) {
          //   return element.codeUnitAt(0) == 10;
          // }).length;
          final newItem = item.map((e) {
            // final index = item.indexOf(e);
            if (e.codeUnitAt(0) == 10) {
              // Log.e(restHeights, "PPP");
              return TextSpan(
                  text: "\n \n",
                  style: TextStyle(fontSize: 1, height: paragraphHeight
                      // +
                      //     (index < restHeights.length
                      //         ? restHeights[index] / (spaceNum)
                      //         : 0)
                      ));
            } else {
              return e;
            }
          }).toList();
          pi += (index == 0 ? 0 : pages[index - 1].length);
          return MapEntry(
              index,
              Stack(
                key: ValueKey({"cIndex": cIndex, 'pIndex': pi}),
                children: [
                  Padding(
                    padding: padding.copyWith(bottom: 0),
                    child: RichText(
                      text: TextSpan(children: newItem),
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
                      "${index + 1}/${pages.length}",
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

    // return [
    //   Container(
    //     key: ValueKey({"cIndex": cIndex, 'pIndex': 0}),
    //     margin: padding,
    //     width: renderWidth,
    //     height: renderHeight,
    //     color: Colors.blue[300],
    //     child: RichText(text:
    //       TextSpan(children: curentPageSpans),
    //       textAlign: TextAlign.justify,
    //     ),
    //   )
    // ];
  }
}
