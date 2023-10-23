// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class PageSplitter {
  final PageConfig config;
  final double width;
  final double height;
  final String title;
  final String name;
  final String? text;
  final List<String>? paragraphs;
  final int? rangeStart;
  final int? rangeEnd;

  // 每章页面信息
  final List<PageInfo> _pages = [];

  PageSplitter({
    required this.config,
    required this.width,
    required this.height,
    required this.title,
    required this.name,
    this.text,
    this.paragraphs,
    this.rangeStart,
    this.rangeEnd,
  })  : assert(text != null || paragraphs != null),
        assert(text == null || paragraphs == null),
        assert(
            rangeStart == null || rangeEnd == null || rangeStart < rangeEnd) {
    double renderWidth =
        width - config.pagePaddingLeft - config.pagePaddingRight;
    double renderHeight = height -
        config.pagePaddingTop -
        config.pagePaddingBottom -
        config.topInfoBarHeight -
        config.bottomInfoBarHeight;
    final singleTextHeight = config.singleTextSize.height;
    final _titleTp = TextPainter(
      text: TextSpan(text: title, style: config.titleTextStyle),
      textDirection: TextDirection.ltr,
    );
    _titleTp.layout(maxWidth: renderWidth);
    // 标题所占高度
    double titleHeight = config.titlePaddingTop +
        config.titlePaddingBottom +
        _titleTp.height +
        config.pagePaddingTop +
        config.topInfoBarHeight;
    double _rHeight = titleHeight;
    final tp = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.justify,
    );
    // 段落数组
    final _paragraphs = rangeStart != null
        ? (paragraphs ?? text?.split('\n') ?? [])
            .getRange(rangeStart!, rangeEnd!)
            .toList()
        : (paragraphs ?? text?.split('\n') ?? []);
    // 临时存储字符串
    String _tempString = "";
    // 每页段落信息
    var _pageParagraphs = <ParagraphInfo>[
      ParagraphInfo(
          title,
          Offset(
              config.pagePaddingLeft,
              config.titlePaddingTop +
                  config.pagePaddingTop +
                  config.topInfoBarHeight),
          isTitle: true,
          indent: false),
    ];

    // 测量函数
    measureTextLines(String text, {indent = false}) {
      if (text.isEmpty) return;
      tp.text = TextSpan(text: "永永$text", style: config.textStyle);
      tp.layout(maxWidth: renderWidth);
      final _lines = tp.computeLineMetrics();

      if (_lines.last.baseline + _rHeight + config.bottomInfoBarHeight <=
          height) {
        // 如果当前页面剩余空间可以绘制完整段落
        _pageParagraphs.add(ParagraphInfo(
            text, Offset(config.pagePaddingLeft, _rHeight),
            indent: indent));
        _rHeight += tp.height;
        _tempString = '';
        if (_rHeight +
                config.paragraphSpacing +
                singleTextHeight +
                config.bottomInfoBarHeight <=
            height) {
          // 可以容纳下一段落的第一行
          _rHeight += config.paragraphSpacing;
        } else {
          _pages.add(PageInfo(
              paragraphs: _pageParagraphs,
              renderHeight: renderHeight,
              actualHeight:
                  _rHeight - config.pagePaddingTop - config.topInfoBarHeight));
          // 不可以容纳下一段落的第一行，不追加额外空格，直接换页
          _rHeight = config.pagePaddingTop + config.topInfoBarHeight;
          _pageParagraphs = [];
        }
      } else {
        String storeParagraph = '';
        int offsetBegin = 0;
        final _rHeightBak = _rHeight;
        for (var line in _lines) {
          if (_rHeightBak + line.baseline + config.bottomInfoBarHeight <=
              height) {
            // 当前行可以在本页绘制
            final offsetForLastWord = tp
                .getPositionForOffset(Offset(line.width, line.baseline))
                .offset;
            storeParagraph += text.substring(offsetBegin, offsetForLastWord);
            offsetBegin = offsetForLastWord;
            _rHeight += line.height;
          } else {
            // 本页不足以绘制当前行，换页。
            // 先把当前残余的行单独推入本页面
            _pageParagraphs.add(ParagraphInfo(
                storeParagraph,
                Offset(
                  config.pagePaddingLeft,
                  _rHeightBak,
                ),
                indent: true,
                forceJustify: true));
            // 存储剩余段落
            if (storeParagraph.isNotEmpty) {
              final restText = text.substring(storeParagraph.length - 2);
              if (restText.isNotEmpty) {
                _tempString = restText;
              } else {
                _tempString = '';
              }
              _pageParagraphs.last.removeLast2Char();
            }
            // 重置段落
            // _chapterPages.add(_pageParagraphs);
            _pages.add(PageInfo(
                paragraphs: _pageParagraphs,
                renderHeight: renderHeight,
                actualHeight: _rHeight -
                    config.pagePaddingTop -
                    config.topInfoBarHeight));
            _pageParagraphs = [];
            // 重置绘制高度
            _rHeight = config.pagePaddingTop + config.topInfoBarHeight;
            break;
          }
        }
      }
    }

    while (_paragraphs.isNotEmpty || _tempString.isNotEmpty) {
      // 先判定上一页剩余字符串
      if (_tempString.isNotEmpty) {
        measureTextLines(_tempString, indent: false);
      } else {
        final p = _paragraphs.removeAt(0).trim();
        measureTextLines(p, indent: true);
      }
    }

    if (_pageParagraphs.isNotEmpty) {
      _pages.add(PageInfo(
          paragraphs: _pageParagraphs,
          renderHeight: renderHeight,
          actualHeight: null));
    }
  }

  CustomPainter getPainterItem(int index) {
    return _PagePainter(
      paragraphInfos: _pages[index].paragraphs,
      config: config,
      topBarText: title,
      bottomBarText: name,
    );
  }

  List<CustomPainter> getPainters() {
    return List.generate(length, (index) => getPainterItem(index));
  }

  Widget getWidgetItem(int index) {
    return CustomPaint(
      foregroundPainter: _PagePainter(
        paragraphInfos: _pages[index].paragraphs,
        config: config,
        topBarText: index == 0 ? name : title,
        bottomBarText: "${index + 1}/$length",
      ),
      size: Size(width, height),
      child: Container(
        color: config.background,
      ),
    );
  }

  List<Widget> getWidgets() {
    return List.generate(length, (index) => getWidgetItem(index));
  }

  int get length => _pages.length;

  List<PageInfo> get pages => _pages;
}

class PageConfig {
  /// 是否开启调试模式
  final bool debug;

  /// 页面上边距
  final double pagePaddingTop;

  /// 页面右边距
  final double pagePaddingRight;

  /// 页面下边距
  final double pagePaddingBottom;

  /// 页面左边距
  final double pagePaddingLeft;

  /// 页面背景颜色
  final Color background;

  /// 可选，页面背景图片
  final ui.Image? backgroundImage;

  /// 字体名称
  final String? fontFamily;

  /// 字体大小
  final double fontSize;

  /// 字体颜色
  final Color fontColor;

  /// 字体行高
  final double lineHeight;

  /// 段落间距
  final double paragraphSpacing;

  /// 是否缩进
  final bool indent;

  /// 标题上距离
  final double titlePaddingTop;

  /// 标题下距离
  final double titlePaddingBottom;

  /// 标题字体大小
  final double titleFontSize;

  /// 顶/底部信息栏距离
  final double infoBarPadding;

  /// 信息栏字体大小
  final double infoBarFontSize;

  /// 消息栏字体颜色
  final Color infoBarFontColor;

  /// 信息栏额外的填充高度
  final EdgeInsets extraInfoBarEdgeInsets;

  // 构造函数
  const PageConfig(
      {this.debug = false,
      this.pagePaddingTop = 24,
      this.pagePaddingBottom = 24,
      this.pagePaddingLeft = 24,
      this.pagePaddingRight = 24,
      this.background = Colors.white,
      this.backgroundImage,
      this.fontFamily,
      this.fontSize = 16,
      this.fontColor = const Color(0xff222222),
      this.lineHeight = 1.6,
      this.indent = false,
      this.titleFontSize = 19,
      this.paragraphSpacing = 18,
      this.titlePaddingTop = 20,
      this.titlePaddingBottom = 32,
      this.infoBarPadding = 16,
      this.infoBarFontSize = 12,
      this.infoBarFontColor = const Color(0xff999999),
      this.extraInfoBarEdgeInsets = const EdgeInsets.all(0)});

  /// 顶部信息栏高度
  double get topInfoBarHeight =>
      infoBarPadding + extraInfoBarEdgeInsets.top + infoBarFontSize;

  /// 底部信息栏高度
  double get bottomInfoBarHeight =>
      infoBarPadding + extraInfoBarEdgeInsets.bottom + infoBarFontSize;

  /// 字体样式
  TextStyle get textStyle => TextStyle(
      color: fontColor,
      fontSize: fontSize,
      fontFamily: fontFamily,
      height: lineHeight);

  /// 字体样式
  ui.TextStyle get uiTextStyle => ui.TextStyle(
        color: fontColor,
        fontSize: fontSize,
        fontFamily: fontFamily,
        height: lineHeight,
      );

  /// 标题字体样式
  TextStyle get titleTextStyle => TextStyle(
      color: fontColor,
      fontSize: titleFontSize,
      fontFamily: fontFamily,
      height: 1);

  /// 标题字体样式
  ui.TextStyle get uiTitleTextStyle => ui.TextStyle(
        color: fontColor,
        fontSize: titleFontSize,
        fontFamily: fontFamily,
        height: 1,
        // decoration: ui.TextDecoration.overline,
        // decorationColor: Colors.red
      );

  /// infoBar 字体样式
  ui.TextStyle get uiInfoBarTextStyle => ui.TextStyle(
      color: infoBarFontColor,
      fontSize: infoBarFontSize,
      fontFamily: fontFamily,
      height: 1);

  Size get singleTextSize {
    final tp = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.justify,
      maxLines: 1,
      text: TextSpan(text: '永', style: textStyle),
    );
    tp.layout();
    return Size(tp.width, tp.computeLineMetrics().first.ascent);
  }
}

class ParagraphInfo {
  String paragraph;
  Offset offset;
  final bool isTitle;
  final bool forceJustify;
  final bool indent;
  ParagraphInfo(this.paragraph, this.offset,
      {this.isTitle = false, this.forceJustify = false, this.indent = false});

  removeLast2Char() {
    paragraph = paragraph.substring(0, paragraph.length - 2);
  }

  translate(double dx, double dy) {
    offset = offset.translate(dx, dy);
  }
}

class PageInfo {
  List<ParagraphInfo> paragraphs;
  PageInfo({
    required this.paragraphs,
    required double renderHeight,
    required double? actualHeight,
  }) {
    if (actualHeight != null) {
      // 计算渲染差值
      final diff = renderHeight - actualHeight;
      // 计算每行差值
      final diffPerLine = diff / paragraphs.length;
      // 更新每行偏移量
      for (var i = 0; i < paragraphs.length; i++) {
        paragraphs[i].translate(0, diffPerLine * i);
      }
    }
  }
}

class _PagePainter extends CustomPainter {
  final List<ParagraphInfo> paragraphInfos;
  final PageConfig config;
  final String topBarText;
  final String bottomBarText;
  _PagePainter(
      {required this.paragraphInfos,
      required this.config,
      required this.topBarText,
      required this.bottomBarText});
  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final _paragraphInfos = [...paragraphInfos];
    ui.ParagraphConstraints constraints = ui.ParagraphConstraints(
        width: size.width - config.pagePaddingLeft - config.pagePaddingRight);

    // 绘制顶栏文字
    final _topBarTp = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.start,
      maxLines: 1,
      ellipsis: '...',
    ));
    final _bottomBarTp = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.end,
      maxLines: 1,
      ellipsis: '...',
    ));
    _topBarTp.pushStyle(config.uiInfoBarTextStyle);
    _topBarTp.addText(topBarText);
    canvas.drawParagraph(
        _topBarTp.build()..layout(constraints),
        Offset(config.pagePaddingLeft,
            config.extraInfoBarEdgeInsets.top + config.infoBarPadding));

    _bottomBarTp.pushStyle(config.uiInfoBarTextStyle);
    _bottomBarTp.addText(bottomBarText);

    canvas.drawParagraph(
        _bottomBarTp.build()..layout(constraints),
        Offset(
            config.pagePaddingLeft,
            size.height -
                config.infoBarPadding -
                config.infoBarFontSize -
                config.extraInfoBarEdgeInsets.bottom));

    canvas.save();
    do {
      final info = _paragraphInfos.removeAt(0);
      ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: TextAlign.justify,
      ));
      pb.pushStyle(info.isTitle ? config.uiTitleTextStyle : config.uiTextStyle);
      if (info.indent) {
        // 这里并不准确 鲜血 前的空白也是由于此处引起
        pb.addPlaceholder(
          config.singleTextSize.width * 2,
          config.singleTextSize.height,
          PlaceholderAlignment.middle,
        );
      }
      pb.addText(info.paragraph);
      if (info.forceJustify) {
        pb.pushStyle(ui.TextStyle(color: Colors.transparent));
        pb.addPlaceholder(config.singleTextSize.width * 3,
            config.singleTextSize.height * 3, PlaceholderAlignment.middle);
      }
      canvas.drawParagraph(pb.build()..layout(constraints), info.offset);
    } while (_paragraphInfos.isNotEmpty);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
