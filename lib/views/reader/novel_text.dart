// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'dart:math' as math;

T cast<T>(x, T defaultValue) => x is T ? x : defaultValue; // 安全转换

const indentation = "　";

class NovelText {
  // 要展示的文字
  final String text;

  // 阅读器配置
  final TextConfig config;

  // 章节列表
  // final List<String> chapters;

  // 名字
  final String chapterName;

  // 书名
  final String bookName;

  // TickerProvider
  final TickerProvider tickerProvider;

  // 动画控制器
  final List<AnimationController> _controllers = [];

  // 文字分段函数
  final Function splitter;

  // 获取当前页函数
  final Function getCurrentPage;

  final _pages = <TextPage>[];

  NovelText(this.text,
      {required this.config,
      // required this.chapters,
      required this.chapterName,
      required this.bookName,
      required this.tickerProvider,
      required this.getCurrentPage,
      this.splitter = _splitParagraphs}) {
    final paragraphs = splitter(text);
    final size = ui.window.physicalSize / ui.window.devicePixelRatio;
    final columns = config.columns > 0
        ? config.columns
        : size.width > 580
            ? 2
            : 1;
    final _columnWidth = (size.width -
            config.leftPadding -
            config.rightPadding -
            (columns - 1) * config.columnPadding) /
        columns;
    final _renderwidth = _columnWidth - config.fontSize;
    final _columnHeight = size.height -
        (config.showInfo ? config.infoHeight : 0) -
        config.bottomPadding -
        config.topPadding -
        (config.showStatus
            ? ui.window.padding.bottom / ui.window.devicePixelRatio
            : 0);
    final _renderHeight = _columnHeight - config.fontSize * config.fontHeight;

    final tp = TextPainter(textDirection: TextDirection.ltr, maxLines: 1);
    final offset = Offset(_columnWidth, 1);
    final _dx = config.leftPadding;
    final _dy = config.topPadding +
        (config.showStatus
            ? ui.window.padding.top / ui.window.devicePixelRatio
            : 0) +
        (config.showInfo ? config.infoHeight : 0);

    var lines = <TextLine>[];
    var columnNum = 1;
    var dx = _dx;
    var dy = _dy;
    var startLine = 0;

    final titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: config.fontSize + 2,
      fontFamily: config.fontFamily,
      color: config.fontColor,
      height: config.fontHeight,
    );
    final textStyle = TextStyle(
      fontSize: config.fontSize,
      fontFamily: config.fontFamily,
      color: config.fontColor,
      height: config.fontHeight,
    );

    // String t = chapters[index].replaceAll(RegExp("^\s*|\n|\s\$"), "");
    // final chapter = chapters[index].isEmpty ? "第$index章" : chapters[index];
    // const chapter = '测试测试 chapter';
    var _t = chapterName;

    dy += config.titlePaddingTop;

    while (true) {
      tp.text = TextSpan(text: _t, style: titleStyle);
      tp.layout(maxWidth: _columnWidth);
      final textCount = tp.getPositionForOffset(offset).offset;
      final text = _t.substring(0, textCount);
      double? spacing;
      if (tp.width > _renderwidth) {
        tp.text = TextSpan(text: text, style: titleStyle);
        tp.layout();
        double _spacing = (_columnWidth - tp.width) / textCount;
        if (_spacing < -0.1 || _spacing > 0.1) {
          spacing = _spacing;
        }
      }
      lines.add(TextLine(text, dx, dy, spacing, true));
      dy += tp.height;
      if (_t.length == textCount) {
        break;
      } else {
        _t = _t.substring(textCount);
      }
    }
    dy += config.titlePaddingBottom;

    var pageIndex = 1;

    /// 下一页 判断分页 依据: `_boxHeight` `_boxHeight2`是否可以容纳下一行
    void newPage([bool shouldJustifyHeight = true, bool lastPage = false]) {
      if (shouldJustifyHeight && config.justifyHeight) {
        final len = lines.length - startLine;
        double justify = (_columnHeight - dy) / (len - 1);
        for (var i = 0; i < len; i++) {
          lines[i + startLine].justifyDy(justify * i);
        }
      }
      if (columnNum == columns || lastPage) {
        _pages.add(TextPage(
          lines: lines,
          info: pageIndex == 1 ? bookName : chapterName,
          height: dy,
          number: pageIndex++,
          chIndex: 0,
          column: _columnWidth,
        ));
        lines = <TextLine>[];
        columnNum = 1;
        dx = _dx;
      } else {
        columnNum++;
        dx += _columnWidth + config.columnPadding;
      }
      dy = _dy;
      startLine = lines.length;
    }

    for (var p in paragraphs) {
      p = indentation * config.indentation + p;
      while (true) {
        tp.text = TextSpan(text: p, style: textStyle);
        tp.layout(maxWidth: _columnWidth);
        final textCount = tp.getPositionForOffset(offset).offset;
        double? spacing;
        final text = p.substring(0, textCount);
        if (tp.width > _renderwidth) {
          tp.text = TextSpan(text: text, style: textStyle);
          tp.layout();
          spacing = (_columnWidth - tp.width) / textCount;
        }
        lines.add(TextLine(text, dx, dy, spacing));
        dy += tp.height;
        if (p.length == textCount) {
          if (dy > _renderHeight) {
            newPage();
          } else {
            dy += config.paragraphPadding;
          }
          break;
        } else {
          p = p.substring(textCount);
          if (dy > _renderHeight) {
            newPage();
          }
        }
      }
    }
    if (lines.isNotEmpty) {
      newPage(false, true);
    }
    if (_pages.isEmpty) {
      _pages.add(TextPage(
        lines: [],
        height: config.topPadding + config.bottomPadding,
        number: 1,
        info: chapterName,
        chIndex: 0,
        column: _columnWidth,
      ));
    }

    const basePercent = 0 / 200;
    final total = _pages.length;
    for (var i = 0; i < _pages.length; i++) {
      _controllers.add(AnimationController(
        value: 1,
        duration: const Duration(milliseconds: 400),
        vsync: tickerProvider,
      ));
      var page = _pages[i];
      page.total = total;
      page.percent = page.number / _pages.length / 200 + basePercent;
    }
    // if (name != null) {
    //   _pages[0].info = name!;
    // }
  }

  // List<TextPage> get pages => _pages;
  List<Widget> get pages {
    return [
      for (var i = 0; i < _pages.length; i++)
        CustomPaint(
          painter: NovelPainter(
              config: config,
              index: i,
              textPage: _pages[i],
              controller: _controllers[i],
              getCurrentPage: getCurrentPage),
        )
    ].reversed.toList();
  }

  // 获取全部的控制器
  List<AnimationController> get controllers => _controllers;

  List get chapters {
    final arr = [];
    for (var i = 0; i < _pages.length; i++) {
      arr.add({'text': pages[i], 'ctrl': controllers[i]});
    }
    return arr;
  }

  // 默认的段落分割函数
  static List<String> _splitParagraphs(String text) {
    return text.split("\n\n").map((paragraph) => paragraph.trim()).toList();
  }
}

class TextPage {
  double percent;
  int number;
  int total;
  int chIndex;
  String info;
  final double height;
  final double column;
  final List<TextLine> lines;

  TextPage(
      {this.percent = 0.0,
      this.total = 1,
      this.chIndex = 0,
      this.info = "",
      required this.column,
      required this.number,
      required this.height,
      required this.lines});
}

class TextLine {
  final String text;
  double dx;
  double _dy;
  double get dy => _dy;
  final double? letterSpacing;
  final bool isTitle;
  TextLine(this.text, this.dx, double dy,
      [this.letterSpacing = 0, this.isTitle = false])
      : _dy = dy;

  justifyDy(double dy) {
    _dy += dy;
  }
}

class TextConfig {
  bool showStatus;
  bool showInfo; // 上下栏
  double infoHeight;
  bool justifyHeight; // 底部对齐
  bool oneHand; // 单手翻页
  bool underLine; //下划线
  bool animationStatus; //动画覆盖状态栏
  bool animationHighImage; // 背景跟随动画？
  String animation = "cover"; // 动画
  int animationDuration; // 动画时长

  // padding
  double topPadding;
  double leftPadding;
  double bottomPadding;
  double rightPadding;
  double titlePaddingTop;
  double titlePaddingBottom;
  double paragraphPadding;
  double columnPadding;

  // font
  int columns;
  int indentation;
  Color fontColor;
  double fontSize;
  double fontHeight;
  String fontFamily;

  // string
  String background; // 图片 未实现
  Color backgroundColor;

  TextConfig({
    this.showStatus = true,
    this.showInfo = true,
    this.infoHeight = 36.0,
    this.justifyHeight = true,
    this.oneHand = false,
    this.underLine = true,
    this.animationStatus = true,
    this.animationHighImage = false,
    this.animation = 'cover',
    this.animationDuration = 450,
    this.topPadding = 16,
    this.leftPadding = 16,
    this.bottomPadding = 16,
    this.rightPadding = 16,
    this.titlePaddingTop = 30,
    this.titlePaddingBottom = 30,
    this.paragraphPadding = 18,
    this.columnPadding = 30,
    this.columns = 0,
    this.indentation = 2,
    this.fontColor = const Color(0xFF303133),
    this.fontSize = 20,
    this.fontHeight = 1.6,
    this.fontFamily = '',
    this.background = '#FFFFFFCC',
    this.backgroundColor = const Color(0xFFFFFFCC),
  });

  bool updateConfig({
    bool? showStatus,
    bool? showInfo,
    double? infoHeight,
    bool? justifyHeight,
    bool? oneHand,
    bool? underLine,
    bool? animationStatus,
    bool? animationHighImage,
    String? animation,
    int? animationDuration,
    double? topPadding,
    double? leftPadding,
    double? bottomPadding,
    double? rightPadding,
    double? titlePaddingTop,
    double? titlePaddingBottom,
    double? paragraphPadding,
    double? columnPadding,
    int? columns,
    int? indentation,
    Color? fontColor,
    double? fontSize,
    double? fontHeight,
    String? fontFamily,
    String? background,
    Color? backgroundColor,
  }) {
    bool? update;

    if (showStatus != null && this.showStatus != showStatus) {
      this.showStatus = showStatus;
      update ??= true;
    }
    if (showInfo != null && this.showInfo != showInfo) {
      this.showInfo = showInfo;
      update ??= true;
    }
    if (infoHeight != null && this.infoHeight != infoHeight) {
      this.infoHeight = infoHeight;
      update ??= true;
    }
    if (justifyHeight != null && this.justifyHeight != justifyHeight) {
      this.justifyHeight = justifyHeight;
      update ??= true;
    }
    if (oneHand != null && this.oneHand != oneHand) {
      this.oneHand = oneHand;
      update ??= true;
    }
    if (underLine != null && this.underLine != underLine) {
      this.underLine = underLine;
      update ??= true;
    }
    if (animationStatus != null && this.animationStatus != animationStatus) {
      this.animationStatus = animationStatus;
      update ??= true;
    }
    if (animationHighImage != null &&
        this.animationHighImage != animationHighImage) {
      this.animationHighImage = animationHighImage;
      update ??= true;
    }
    if (animation != null && this.animation != animation) {
      this.animation = animation;
      update ??= true;
    }
    if (animationDuration != null &&
        this.animationDuration != animationDuration) {
      this.animationDuration = animationDuration;
      update ??= true;
    }
    if (topPadding != null && this.topPadding != topPadding) {
      this.topPadding = topPadding;
      update ??= true;
    }
    if (leftPadding != null && this.leftPadding != leftPadding) {
      this.leftPadding = leftPadding;
      update ??= true;
    }
    if (bottomPadding != null && this.bottomPadding != bottomPadding) {
      this.bottomPadding = bottomPadding;
      update ??= true;
    }
    if (rightPadding != null && this.rightPadding != rightPadding) {
      this.rightPadding = rightPadding;
      update ??= true;
    }
    if (titlePaddingTop != null && this.titlePaddingTop != titlePaddingTop) {
      this.titlePaddingTop = titlePaddingTop;
      update ??= true;
    }
    if (titlePaddingBottom != null &&
        this.titlePaddingBottom != titlePaddingBottom) {
      this.titlePaddingTop = titlePaddingBottom;
      update ??= true;
    }
    if (paragraphPadding != null && this.paragraphPadding != paragraphPadding) {
      this.paragraphPadding = paragraphPadding;
      update ??= true;
    }
    if (columnPadding != null && this.columnPadding != columnPadding) {
      this.columnPadding = columnPadding;
      update ??= true;
    }
    if (columns != null && this.columns != columns) {
      this.columns = columns;
      update ??= true;
    }
    if (indentation != null && this.indentation != indentation) {
      this.indentation = indentation;
      update ??= true;
    }
    if (fontColor != null && this.fontColor != fontColor) {
      this.fontColor = fontColor;
      update ??= true;
    }
    if (fontSize != null && this.fontSize != fontSize) {
      this.fontSize = fontSize;
      update ??= true;
    }
    if (fontHeight != null && this.fontHeight != fontHeight) {
      this.fontHeight = fontHeight;
      update ??= true;
    }
    if (fontFamily != null && this.fontFamily != fontFamily) {
      this.fontFamily = fontFamily;
      update ??= true;
    }
    if (background != null && this.background != background) {
      this.background = background;
      update ??= true;
    }
    if (backgroundColor != null && this.backgroundColor != backgroundColor) {
      this.backgroundColor = backgroundColor;
      update ??= true;
    }

    return update == true;
  }

  /// Creates an instance of this class from a JSON object.
  factory TextConfig.fromJSON(Map<String, dynamic> encoded) {
    return TextConfig(
      showStatus: cast(encoded['showStatus'], true),
      showInfo: cast(encoded['showInfo'], true),
      infoHeight: cast(encoded['infoHeight'], 36.0),
      justifyHeight: cast(encoded['justifyHeight'], true),
      oneHand: cast(encoded['oneHand'], false),
      underLine: cast(encoded['underLine'], true),
      animationStatus: cast(encoded['animationStatus'], true),
      animationHighImage: cast(encoded['animationHighImage'], false),
      animation: cast(encoded['animation'], 'cover'),
      animationDuration: cast(encoded['animationDuration'], 400),
      topPadding: cast(encoded['topPadding'], 16),
      leftPadding: cast(encoded['leftPadding'], 16),
      bottomPadding: cast(encoded['bottomPadding'], 16),
      rightPadding: cast(encoded['rightPadding'], 16),
      titlePaddingTop: cast(encoded['titlePaddingTop'], 30),
      titlePaddingBottom: cast(encoded['titlePaddingBottom'], 30),
      paragraphPadding: cast(encoded['paragraphPadding'], 18),
      columnPadding: cast(encoded['columnPadding'], 30),
      columns: cast(encoded['columns'], 0),
      indentation: cast(encoded['indentation'], 2),
      fontColor: Color(cast(encoded['fontColor'], 0xFF303133)),
      fontSize: cast(encoded['fontSize'], 20),
      fontHeight: cast(encoded['fontHeight'], 1.6),
      fontFamily: cast(encoded['fontFamily'], ''),
      background: cast(encoded['background'], '#FFFFFFCC'),
      backgroundColor: Color(cast(encoded['backgroundColor'], 0xFFFFFFCC)),
    );
  }

  /// Returns a representation of this object as a JSON object.
  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'showStatus': showStatus,
      'showInfo': showInfo,
      'infoHeight': infoHeight,
      'justifyHeight': justifyHeight,
      'oneHand': oneHand,
      'underLine': underLine,
      'animationStatus': animationStatus,
      'animationHighImage': animationHighImage,
      'animation': animation,
      'animationDuration': animationDuration,
      'topPadding': topPadding,
      'leftPadding': leftPadding,
      'bottomPadding': bottomPadding,
      'rightPadding': rightPadding,
      'titlePaddingTop': titlePaddingTop,
      'titlePaddingBottom': titlePaddingBottom,
      'paragraphPadding': paragraphPadding,
      'columnPadding': columnPadding,
      'columns': columns,
      'indentation': indentation,
      'fontColor': fontColor.value,
      'fontSize': fontSize,
      'fontHeight': fontHeight,
      'fontFamily': fontFamily,
      'background': background,
      'backgroundColor': backgroundColor.value,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TextConfig &&
        other.showStatus == showStatus &&
        other.showInfo == showInfo &&
        other.infoHeight == infoHeight &&
        other.justifyHeight == justifyHeight &&
        other.oneHand == oneHand &&
        other.underLine == underLine &&
        other.animationStatus == animationStatus &&
        other.animationHighImage == animationHighImage &&
        other.animation == animation &&
        other.animationDuration == animationDuration &&
        other.topPadding == topPadding &&
        other.leftPadding == leftPadding &&
        other.bottomPadding == bottomPadding &&
        other.rightPadding == rightPadding &&
        other.titlePaddingTop == titlePaddingTop &&
        other.titlePaddingBottom == titlePaddingBottom &&
        other.paragraphPadding == paragraphPadding &&
        other.columnPadding == columnPadding &&
        other.columns == columns &&
        other.indentation == indentation &&
        other.fontColor == fontColor &&
        other.fontSize == fontSize &&
        other.fontHeight == fontHeight &&
        other.fontFamily == fontFamily &&
        other.background == background &&
        other.backgroundColor == backgroundColor;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}

class NovelPainter extends CustomPainter {
  NovelPainter({
    required this.index,
    required this.config,
    required this.controller,
    required this.textPage,
    required this.getCurrentPage,
    // this.animation,
    this.radius = 0.18,
  }) : super(repaint: controller);
  final int index;
  final TextPage textPage;
  final TextConfig config;
  final Animation<double> controller;
  final double radius;
  final Function getCurrentPage;
  // final String? animation;
  ui.Image? image;
  bool? toImageIng;
  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    // ReaderController readerController = Get.find<ReaderController>();
    var currentPage = getCurrentPage();
    // var currentPage = 26;
    if (index > currentPage + 2 || index < currentPage - 2) {
      return;
    }

    final animation = config.animation;

    final picture = getPicture(textPage, size, config);
    if (animation == 'cover' && image == null && toImageIng != true) {
      toImageIng = true;
      toImage(picture, size);
    }
    // Log.d(controller.value);
    // if (controller.value > 0.998) {
    //   return;
    // }
    final pos = controller.value; // 1 / 500 = 0.002 也就是500宽度相差1像素 忽略掉动画
    if (pos > 0.998) {
      canvas.drawPicture(picture);
    } else if (pos < 0.002) {
      return;
    } else {
      switch (animation) {
        case 'cover':
          // if (image == null) {
          //   if (toImageIng == true) return;
          //   toImageIng = true;
          //   toImage(picture, size);
          // } else {
          //   paintCurl(canvas, size, pos, image!, config.backgroundColor, null);
          // }
          final right = pos * size.width;
          final shadowSigma = Shadow.convertRadiusToSigma(16);
          final pageRect = Rect.fromLTRB(0.0, 0.0, right, size.height);
          canvas.drawRect(
            pageRect,
            Paint()
              ..color = Colors.black54
              ..maskFilter = MaskFilter.blur(BlurStyle.outer, shadowSigma),
          );
          canvas.translate(right - size.width, 0);
          canvas.drawPicture(picture);
          break;
      }
    }
  }

  @override
  bool shouldRepaint(covariant NovelPainter oldDelegate) {
    return oldDelegate.image != image ||
        oldDelegate.controller.value != controller.value ||
        index != oldDelegate.index;
  }

  /// 原始动效
  void paintCurl(ui.Canvas canvas, ui.Size size, double pos, ui.Image image,
      ui.Color? backgroundColor, ui.Image? backImage) {
    final movX = (1.0 - pos) * 0.85;
    final calcR = (movX < 0.20) ? radius * movX * 5 : radius;
    final wHRatio = 1 - calcR;
    final hWRatio = image.height / image.width;
    final hWCorrection = (hWRatio - 1.0) / 2.0;

    final w = size.width.toDouble();
    final h = size.height.toDouble();
    final c = canvas;
    final shadowXf = (wHRatio - movX);
    final shadowSigma =
        Shadow.convertRadiusToSigma(8.0 + (32.0 * (1.0 - shadowXf)));
    final pageRect = Rect.fromLTRB(0.0, 0.0, w * shadowXf, h);
    if (backImage != null) {
      c.drawImageRect(backImage, pageRect, pageRect, Paint());
    } else if (backgroundColor != null) {
      c.drawRect(pageRect, Paint()..color = backgroundColor);
    }
    if (pos != 0) {
      c.drawRect(
        pageRect,
        Paint()
          ..color = Colors.black54
          ..maskFilter = MaskFilter.blur(BlurStyle.outer, shadowSigma),
      );
    }

    final ip = Paint();
    for (double x = 0; x < size.width; x++) {
      final xf = (x / w);
      final v = (calcR * (math.sin(math.pi / 0.5 * (xf - (1.0 - pos)))) +
          (calcR * 1.1));
      final xv = (xf * wHRatio) - movX;
      if (xv < 0) continue;
      final sx = (xf * image.width);
      final sr = Rect.fromLTRB(sx, 0.0, sx + 1.0, image.height.toDouble());
      final yv = ((h * calcR * movX) * hWRatio) - hWCorrection;
      final ds = (yv * v);
      final dr = Rect.fromLTRB(xv * w, 0.0 - ds, xv * w + 1.0, h + ds);
      c.drawImageRect(image, sr, dr, ip);
      // canvas.save();
      // canvas.clipRect(dr);
      // canvas.transform((Matrix4.diagonal3Values(1, 1 + 2 * ds / h, 1)
      //       ..translate(xv * w - sx, -ds, 0))
      //     .storage);
      // canvas.drawPicture(picture);
      // canvas.restore();
    }
  }

  void paintText(
      ui.Canvas canvas, ui.Size size, TextPage page, TextConfig config) {
    // Log.d("paintText ${page.chIndex} ${page.number} / ${page.total}");
    final lineCount = page.lines.length;
    final tp = TextPainter(textDirection: TextDirection.ltr, maxLines: 1);
    final titleStyle = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: config.fontSize + 3,
      fontFamily: config.fontFamily,
      color: config.fontColor,
      height: config.fontHeight,
    );
    final style = TextStyle(
      fontSize: config.fontSize,
      fontFamily: config.fontFamily,
      color: config.fontColor,
      height: config.fontHeight,
    );
    final _lineHeight = config.fontSize * config.fontHeight;
    for (var i = 0; i < lineCount; i++) {
      final line = page.lines[i];
      if (line.letterSpacing != null &&
          (line.letterSpacing! < -0.1 || line.letterSpacing! > 0.1)) {
        tp.text = TextSpan(
          text: line.text,
          style: line.isTitle
              ? TextStyle(
                  letterSpacing: line.letterSpacing,
                  fontWeight: FontWeight.normal,
                  fontSize: config.fontSize + 3,
                  fontFamily: config.fontFamily,
                  color: config.fontColor,
                  height: config.fontHeight,
                )
              : TextStyle(
                  letterSpacing: line.letterSpacing,
                  fontSize: config.fontSize,
                  fontFamily: config.fontFamily,
                  color: config.fontColor,
                  height: config.fontHeight,
                ),
        );
      } else {
        tp.text =
            TextSpan(text: line.text, style: line.isTitle ? titleStyle : style);
      }
      final offset = Offset(line.dx, line.dy);
      tp.layout();
      tp.paint(canvas, offset);
      if (config.underLine) {
        canvas.drawLine(
            Offset(line.dx, line.dy + _lineHeight),
            Offset(line.dx + page.column, line.dy + _lineHeight),
            Paint()..color = Colors.grey);
      }
    }
    if (config.showInfo) {
      final styleInfo = TextStyle(
        fontSize: 13,
        fontFamily: config.fontFamily,
        color: config.fontColor.withOpacity(0.4),
      );
      tp.text = TextSpan(text: page.info, style: styleInfo);
      // canvas.drawRect(Rect.fromLTRB(0.0, 0.0, size.width, config.infoHeight),
      //     Paint()..color = Colors.teal);
      // canvas.drawRect(
      //     Rect.fromLTRB(0.0, config.infoHeight, size.width,
      //         size.height - config.infoHeight),
      //     Paint()..color = Colors.red.withOpacity(0.1));
      // canvas.drawRect(
      //     Rect.fromLTRB(
      //         0.0, size.height - config.infoHeight, size.width, size.height),
      //     Paint()..color = Colors.teal);
      tp.layout(
          maxWidth: size.width - config.leftPadding - config.rightPadding - 60);
      tp.paint(
          canvas,
          Offset(
              config.leftPadding,
              (config.infoHeight - tp.height) / 2 +
                  (config.showStatus
                      ? ui.window.padding.top / ui.window.devicePixelRatio
                      : 0)));

      tp.text = TextSpan(
        text: '${page.number}/${page.total}',
        style: styleInfo,
      );
      tp.layout();
      tp.paint(
          canvas,
          Offset(
              size.width - config.rightPadding - tp.width,
              size.height -
                  (config.infoHeight + tp.height) / 2 -
                  MediaQueryData.fromWindow(ui.window).padding.bottom));
    }
  }

  ui.Picture getPicture(TextPage textPage, Size size, TextConfig config) {
    // if (textPage == null) return null;
    final pic = ui.PictureRecorder();
    final c = Canvas(pic);
    final pageRect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    c.drawRect(pageRect, Paint()..color = config.backgroundColor);
    // if (_backImage != null) c.drawImage(_backImage!, Offset.zero, Paint());
    paintText(c, size, textPage, config);
    return pic.endRecording();
  }

  toImage(ui.Picture picture, ui.Size size) {
    if (config.animationHighImage) {
      final r = ui.PictureRecorder();
      final size = ui.window.physicalSize;
      Canvas(r)
        ..scale(ui.window.devicePixelRatio)
        ..drawPicture(picture);
      r
          .endRecording()
          .toImage(size.width.round(), size.height.round())
          .then((value) {
        image = value;
        toImageIng = false;
      });
    } else {
      picture.toImage(size.width.round(), size.height.round()).then((value) {
        image = value;
        toImageIng = false;
      });
    }
  }
}
