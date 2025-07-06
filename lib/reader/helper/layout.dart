import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:flutter/material.dart';

final logger = Logger("LayoutHelper");

/// 一个用于处理中文文本排版布局计算的辅助类
class ChineseLayoutHelper {
  /// 标题文字
  final String? title;

  /// 标题样式
  final TextStyle titleStyle;

  /// 标题与顶部正文的距离
  final double titleTopSpacing;

  /// 标题与底部正文的距离
  final double titleBottomBodySpacing;

  /// 排版宽度，不传则使用屏幕宽度
  final double? width;

  /// 排版高度，不传则使用屏幕高度
  final double? height;

  /// 段落间距
  final double paragraphSpacing;

  /// 绘制区域的内边距
  final EdgeInsets padding;

  /// 正文文本样式
  final TextStyle bodyTextStyle;

  /// 段落缩进尺寸，为null时使用两个正文文字尺寸的缩进，为int时使用指定尺寸
  final int? indent;

  /// 构造函数
  ChineseLayoutHelper({
    this.title,
    this.titleStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    this.titleTopSpacing = 20.0,
    this.titleBottomBodySpacing = 20.0,
    this.width,
    this.height,
    this.paragraphSpacing = 10.0,
    this.padding = const EdgeInsets.all(20.0),
    required this.bodyTextStyle,
    this.indent,
  }) : assert(indent == null || indent >= 0, 'indent 不可为负数');

  /// 获取实际的缩进值
  double get _actualIndent {
    if (indent == null) {
      // 使用两个正文文字尺寸的缩进
      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: '字', style: bodyTextStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      return textPainter.width * 2;
    }
    return indent!.toDouble();
  }

  /// 计算文本布局，返回分页结果
  LayoutResult calculateLayout(String text, {BuildContext? context}) {
    // 获取布局尺寸，如果未指定则使用屏幕尺寸
    final Size layoutSize = Size(
      width ??
          (context != null
              ? MediaQuery.of(context).size.width
              : WidgetsBinding.instance.window.physicalSize.width /
                    WidgetsBinding.instance.window.devicePixelRatio),
      height ??
          (context != null
              ? MediaQuery.of(context).size.height
              : WidgetsBinding.instance.window.physicalSize.height /
                    WidgetsBinding.instance.window.devicePixelRatio),
    );

    // 检查布局尺寸是否有效
    if (layoutSize.width <= 0 || layoutSize.height <= 0) {
      throw ArgumentError('布局尺寸必须为正值');
    }

    // 计算可绘制区域
    final Rect drawingArea = Rect.fromLTWH(
      padding.left,
      padding.top,
      layoutSize.width - padding.left - padding.right,
      layoutSize.height - padding.top - padding.bottom,
    );

    // 创建结果容器
    List<PageLayout> pages = [];

    // 计算标题区域高度
    double titleHeight = 0;
    TextPainter? titlePainter;
    if (title != null && title!.isNotEmpty) {
      titlePainter = TextPainter(
        text: TextSpan(text: title, style: titleStyle),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      titlePainter.layout(maxWidth: drawingArea.width);
      titleHeight = titlePainter.height + titleBottomBodySpacing;
    }

    // 将文本拆分为段落
    final List<String> paragraphs = text.split('\n');

    // 追踪当前处理状态
    int currentParagraphIndex = 0;
    double currentY =
        drawingArea.top +
        titleTopSpacing +
        (title != null ? titleHeight : 0); // 修改此行，加入titleTopBodySpacing
    List<ParagraphLayout> currentPageParagraphs = [];
    bool isFirstPage = true;

    // 处理每个段落
    while (currentParagraphIndex < paragraphs.length) {
      String paragraph = paragraphs[currentParagraphIndex];

      // 跳过空段落
      if (paragraph.trim().isEmpty) {
        currentParagraphIndex++;
        continue;
      }

      // 移除段落开头的空白字符
      paragraph = paragraph.trimLeft();

      // 计算可用宽度（扣除缩进）
      final double availableWidth = drawingArea.width - _actualIndent;

      // 创建TextPainter处理当前段落
      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: paragraph, style: bodyTextStyle),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.justify,
      );
      textPainter.layout(maxWidth: availableWidth);

      // 获取该段落的所有行指标
      final List<LineMetrics> lineMetrics = textPainter.computeLineMetrics();

      if (lineMetrics.isEmpty) {
        currentParagraphIndex++;
        continue;
      }

      // 检查剩余空间是否至少能放下段落的第一行
      final double firstLineHeight = lineMetrics.first.height;
      final double remainingHeight = drawingArea.bottom - currentY;

      // 如果剩余空间不足以放下一行，开启新页面
      if (firstLineHeight > remainingHeight) {
        if (currentPageParagraphs.isNotEmpty) {
          _adjustLineSpacingForPage(
            currentPageParagraphs,
            drawingArea,
            isFirstPage,
            isLastContent: false, // 这不是最后一页，因为有内容无法放下
          );

          // 添加当前页面到结果中
          pages.add(
            PageLayout(
              paragraphs: List.from(currentPageParagraphs),
              drawingArea: drawingArea,
              title: isFirstPage ? title : null,
              titlePainter: isFirstPage ? titlePainter : null,
            ),
          );

          // 重置为新页面
          currentPageParagraphs = [];
          currentY = drawingArea.top;
          isFirstPage = false;
        }
      }

      // 存储当前段落的所有行
      List<LineLayout> paragraphLines = [];

      // 处理每一行
      for (int i = 0; i < lineMetrics.length; i++) {
        final bool isLastLine = i == lineMetrics.length - 1;
        final bool isFirstLine = i == 0; // 判断是否是段落的第一行
        final LineMetrics metrics = lineMetrics[i];

        // 计算行高
        final double lineHeight = metrics.height;

        // 检查是否需要新建页面
        if (currentY + lineHeight > drawingArea.bottom) {
          // 如果当前段落已经有处理的行，则保存这些行到当前页面
          if (paragraphLines.isNotEmpty) {
            currentPageParagraphs.add(
              ParagraphLayout(
                paragraphIndex: currentParagraphIndex,
                lines: List.from(paragraphLines),
              ),
            );

            paragraphLines = [];
          }

          // 调整当前页面的行间距
          if (currentPageParagraphs.isNotEmpty) {
            _adjustLineSpacingForPage(
              currentPageParagraphs,
              drawingArea,
              isFirstPage,
              isLastContent: false, // 这不是最后一页，因为有内容无法放下
            );

            // 添加当前页面到结果中
            pages.add(
              PageLayout(
                paragraphs: List.from(currentPageParagraphs),
                drawingArea: drawingArea,
                title: isFirstPage ? title : null,
                titlePainter: isFirstPage ? titlePainter : null,
              ),
            );

            // 重置为新页面
            currentPageParagraphs = [];
            currentY = drawingArea.top;
            isFirstPage = false;
          }
        }

        // 提取该行的文本
        String lineText = _extractLineText(textPainter, metrics, i, paragraph);

        // 为该行创建TextPainter
        final TextPainter linePainter = TextPainter(
          text: TextSpan(text: lineText, style: bodyTextStyle),
          textDirection: TextDirection.ltr,
          textAlign: isLastLine ? TextAlign.left : TextAlign.justify,
        );

        // 非首行应该使用完整宽度而不是缩进后的宽度
        final double lineWidth = isFirstLine
            ? availableWidth
            : drawingArea.width;
        linePainter.layout(maxWidth: lineWidth);

        // 创建行布局数据，只有第一行应用缩进
        final LineLayout lineLayout = LineLayout(
          paragraphIndex: currentParagraphIndex,
          lineIndex: i,
          text: lineText,
          painter: linePainter,
          bounds: Rect.fromLTWH(
            drawingArea.left + (isFirstLine ? _actualIndent : 0), // 只对第一行应用缩进
            currentY,
            lineWidth, // 使用对应行的宽度
            lineHeight,
          ),
          isLastLineInParagraph: isLastLine,
          isFirstLineInParagraph: isFirstLine,
        );

        paragraphLines.add(lineLayout);
        currentY += lineHeight;

        // 如果是段落的最后一行且不是最后一个段落，检查添加段落间距
        if (isLastLine && currentParagraphIndex < paragraphs.length - 1) {
          // 如果添加段落间距会导致超出页面，则不添加段落间距，新段落会在下一页开始
          if (currentY + paragraphSpacing > drawingArea.bottom) {
            // 不添加段落间距
          } else {
            currentY += paragraphSpacing;
          }
        }
      }

      // 如果当前段落有行，添加到当前页面
      if (paragraphLines.isNotEmpty) {
        currentPageParagraphs.add(
          ParagraphLayout(
            paragraphIndex: currentParagraphIndex,
            lines: paragraphLines,
          ),
        );
      }

      currentParagraphIndex++;
    }

    // 添加最后一页（如果有内容）
    if (currentPageParagraphs.isNotEmpty) {
      // 这是最后一页
      _adjustLineSpacingForPage(
        currentPageParagraphs,
        drawingArea,
        isFirstPage,
        isLastContent: true, // 这是最后一页
      );

      pages.add(
        PageLayout(
          paragraphs: currentPageParagraphs,
          drawingArea: drawingArea,
          title: isFirstPage ? title : null,
          titlePainter: isFirstPage ? titlePainter : null,
        ),
      );
    }

    return LayoutResult(pages: pages);
  }

  /// 从TextPainter中提取特定行的文本
  String _extractLineText(
    TextPainter textPainter,
    LineMetrics metrics,
    int lineIndex,
    String paragraph,
  ) {
    // 计算当前行的垂直范围
    final double lineTop = metrics.baseline - metrics.ascent;

    // 查找行的开始和结束位置
    final TextPosition startPosition = textPainter.getPositionForOffset(
      Offset(0, lineTop + 1),
    );
    final TextPosition endPosition = textPainter.getPositionForOffset(
      Offset(textPainter.width, lineTop + 1),
    );

    // 如果是最后一行，确保包含到段落结尾
    int endOffset = endPosition.offset;
    if (lineIndex == textPainter.computeLineMetrics().length - 1) {
      endOffset = paragraph.length;
    }

    // 提取文本
    if (startPosition.offset < endOffset && endOffset <= paragraph.length) {
      return paragraph.substring(startPosition.offset, endOffset);
    }

    // 安全回退
    return lineIndex == textPainter.computeLineMetrics().length - 1
        ? paragraph.substring(startPosition.offset)
        : "";
  }

  /// 调整行间距，确保最后一行紧贴底部
  void _adjustLineSpacingForPage(
    List<ParagraphLayout> paragraphs,
    Rect drawingArea,
    bool isFirstPage, {
    bool isLastContent = false,
  }) {
    if (paragraphs.isEmpty) return;

    // 如果是最后一页内容，不进行上下贴边对齐调整
    if (isLastContent) return;

    // 计算总行数
    int totalLines = 0;
    for (var paragraph in paragraphs) {
      totalLines += paragraph.lines.length;
    }

    if (totalLines <= 1) return; // 单行不需要调整

    // 计算当前使用的总高度
    double totalUsedHeight = 0;
    for (int p = 0; p < paragraphs.length; p++) {
      final paragraph = paragraphs[p];

      for (var line in paragraph.lines) {
        totalUsedHeight += line.bounds.height;
      }

      // 为除最后一段外的所有段落添加段落间距
      if (p < paragraphs.length - 1) {
        totalUsedHeight += paragraphSpacing;
      }
    }

    // 计算可用高度
    double availableHeight = drawingArea.height;
    if (isFirstPage && title != null) {
      final titlePainter = TextPainter(
        text: TextSpan(text: title, style: titleStyle),
        textDirection: TextDirection.ltr,
      );
      titlePainter.layout(maxWidth: drawingArea.width);
      availableHeight -=
          (titlePainter.height + titleTopSpacing + titleBottomBodySpacing);
    }

    // 计算额外空间
    final double extraSpace = availableHeight - totalUsedHeight;

    if (extraSpace <= 0) return; // 无需调整

    // 计算每行额外间距
    final double additionalSpacingPerGap = extraSpace / (totalLines - 1);

    // 应用间距调整
    double currentY = drawingArea.top;
    if (isFirstPage && title != null) {
      final titlePainter = TextPainter(
        text: TextSpan(text: title, style: titleStyle),
        textDirection: TextDirection.ltr,
      );
      titlePainter.layout(maxWidth: drawingArea.width);
      currentY +=
          titleTopSpacing + titlePainter.height + titleBottomBodySpacing;
    }

    for (int p = 0; p < paragraphs.length; p++) {
      final paragraph = paragraphs[p];

      for (int l = 0; l < paragraph.lines.length; l++) {
        final line = paragraph.lines[l];

        // 更新行位置
        line.bounds = Rect.fromLTWH(
          line.bounds.left,
          currentY,
          line.bounds.width,
          line.bounds.height,
        );

        currentY += line.bounds.height;

        // 为除最后一行外的所有行添加额外间距
        if (!(p == paragraphs.length - 1 && l == paragraph.lines.length - 1)) {
          currentY += additionalSpacingPerGap;
        }
      }

      // 为除最后一段外的所有段落添加段落间距
      if (p < paragraphs.length - 1) {
        currentY += paragraphSpacing;
      }
    }
  }
}

/// 布局计算结果
class LayoutResult {
  /// 所有页面的布局
  final List<PageLayout> pages;

  LayoutResult({required this.pages});

  /// 获取总页数
  int get pageCount => pages.length;

  /// 根据段落和行索引查找所在页面
  int findPageByPosition(int paragraphIndex, int lineIndex) {
    for (int i = 0; i < pages.length; i++) {
      for (var paragraph in pages[i].paragraphs) {
        if (paragraph.paragraphIndex == paragraphIndex) {
          for (var line in paragraph.lines) {
            if (line.paragraphIndex == paragraphIndex &&
                line.lineIndex == lineIndex) {
              return i;
            }
          }
        }
      }
    }
    return -1; // 未找到
  }
}

/// 页面布局信息
class PageLayout {
  /// 该页包含的段落
  final List<ParagraphLayout> paragraphs;

  /// 绘制区域
  final Rect drawingArea;

  /// 标题（仅第一页可能有）
  final String? title;

  /// 标题的TextPainter（用于绘制）
  final TextPainter? titlePainter;

  PageLayout({
    required this.paragraphs,
    required this.drawingArea,
    this.title,
    this.titlePainter,
  });
}

/// 段落布局信息
class ParagraphLayout {
  /// 段落在原文中的索引
  final int paragraphIndex;

  /// 段落包含的所有行
  final List<LineLayout> lines;

  ParagraphLayout({required this.paragraphIndex, required this.lines});
}

/// 行布局信息
class LineLayout {
  /// 所属段落索引
  final int paragraphIndex;

  /// 在段落中的行索引
  final int lineIndex;

  /// 行文本内容
  final String text;

  /// 用于绘制的TextPainter
  final TextPainter painter;

  /// 行的边界矩形
  Rect bounds;

  /// 是否是段落的最后一行
  final bool isLastLineInParagraph;

  /// 是否是段落的第一行
  final bool isFirstLineInParagraph;

  LineLayout({
    required this.paragraphIndex,
    required this.lineIndex,
    required this.text,
    required this.painter,
    required this.bounds,
    this.isLastLineInParagraph = false,
    this.isFirstLineInParagraph = false,
  });
}

/// 用于绘制布局结果的自定义画布
class ChineseLayoutPainter extends CustomPainter {
  /// 布局结果
  final LayoutResult layoutResult;

  /// 要绘制的页面索引
  final int pageIndex;

  /// 缩进值
  final double indent;

  ChineseLayoutPainter({
    required this.layoutResult,
    required this.pageIndex,
    this.indent = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 检查页面索引是否有效
    if (pageIndex < 0 || pageIndex >= layoutResult.pages.length) {
      return;
    }

    final PageLayout page = layoutResult.pages[pageIndex];

    // 绘制背景（可选）
    // canvas.drawRect(Offset.zero & size, Paint()..color = Colors.white);

    // 绘制标题（如果有）
    if (page.title != null && page.titlePainter != null) {
      page.titlePainter!.paint(
        canvas,
        Offset(
          // (size.width - page.titlePainter!.width) / 2, // 居中
          page.drawingArea.left,
          page.drawingArea.top,
        ),
      );
    }

    // 绘制段落
    for (var paragraph in page.paragraphs) {
      for (var line in paragraph.lines) {
        // 根据对齐方式绘制
        if (line.isLastLineInParagraph) {
          // 段落最后一行左对齐
          line.painter.paint(canvas, Offset(line.bounds.left, line.bounds.top));
        } else {
          // 其他行两端对齐，需要特殊处理中文字符间距
          _drawJustifiedChineseText(
            canvas,
            line.text,
            line.painter,
            Offset(line.bounds.left, line.bounds.top),
            line.bounds.width,
          );
        }
      }
    }
  }

  /// 绘制两端对齐的中文文本
  void _drawJustifiedChineseText(
    Canvas canvas,
    String text,
    TextPainter painter,
    Offset position,
    double maxWidth,
  ) {
    // 如果文本已经占满整行或接近占满，直接使用原始painter绘制
    if (painter.width >= maxWidth - 5) {
      painter.paint(canvas, position);
      return;
    }

    // 计算需要分配的额外空间 - 使用传入的maxWidth而不是painter的width
    final double extraSpace = maxWidth - painter.width;

    // 计算字符间需要插入的间距
    final int charCount = text.characters.length;
    if (charCount <= 1) {
      painter.paint(canvas, position);
      return;
    }

    final double extraSpacingPerGap = extraSpace / (charCount - 1);

    // 逐字符绘制，添加额外间距
    double currentX = position.dx;
    for (int i = 0; i < text.characters.length; i++) {
      final String char = text.characters.elementAt(i);

      // 为单个字符创建TextPainter
      final TextPainter charPainter = TextPainter(
        text: TextSpan(text: char, style: painter.text!.style),
        textDirection: TextDirection.ltr,
      );
      charPainter.layout();

      // 绘制字符
      charPainter.paint(canvas, Offset(currentX, position.dy));

      // 移动到下一个字符位置，添加额外间距
      currentX += charPainter.width;
      if (i < text.characters.length - 1) {
        currentX += extraSpacingPerGap;
      }
    }
  }

  @override
  bool shouldRepaint(ChineseLayoutPainter oldDelegate) {
    return oldDelegate.layoutResult != layoutResult ||
        oldDelegate.pageIndex != pageIndex ||
        oldDelegate.indent != indent;
  }
}

/// 用于显示布局结果的Widget
class ChineseLayoutView extends StatelessWidget {
  /// 布局结果
  final LayoutResult layoutResult;

  /// 要显示的页面索引
  final int pageIndex;

  const ChineseLayoutView({
    super.key,
    required this.layoutResult,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    // 检查页面索引是否有效
    if (pageIndex < 0 || pageIndex >= layoutResult.pages.length) {
      return Container();
    }

    final PageLayout page = layoutResult.pages[pageIndex];

    return CustomPaint(
      foregroundPainter: ChineseLayoutPainter(
        layoutResult: layoutResult,
        pageIndex: pageIndex,
      ),
      size: Size(
        page.drawingArea.width + page.drawingArea.left * 2,
        page.drawingArea.height + page.drawingArea.top * 2,
      ),
    );
  }
}

/// 使用 PageController 实现的多页面中文排版视图
class ChineseLayoutPageView extends StatelessWidget {
  /// 布局结果
  final LayoutResult layoutResult;

  /// 页面控制器
  final PageController pageController;

  const ChineseLayoutPageView({
    Key? key,
    required this.layoutResult,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: layoutResult.pages.length,
      itemBuilder: (context, index) {
        return ChineseLayoutView(layoutResult: layoutResult, pageIndex: index);
      },
    );
  }
}

/// 用于保存和恢复阅读进度的辅助类
class ReadingProgress {
  /// 当前阅读的段落索引
  final int paragraphIndex;

  /// 当前阅读的行索引
  final int lineIndex;

  /// 当前页码
  final int pageIndex;

  ReadingProgress({
    required this.paragraphIndex,
    required this.lineIndex,
    required this.pageIndex,
  });

  /// 从JSON创建阅读进度
  factory ReadingProgress.fromJson(Map<String, dynamic> json) {
    return ReadingProgress(
      paragraphIndex: json['paragraphIndex'] ?? 0,
      lineIndex: json['lineIndex'] ?? 0,
      pageIndex: json['pageIndex'] ?? 0,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'paragraphIndex': paragraphIndex,
      'lineIndex': lineIndex,
      'pageIndex': pageIndex,
    };
  }
}
