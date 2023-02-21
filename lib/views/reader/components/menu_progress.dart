import 'package:flutter/material.dart';
import 'package:wenku8x/views/reader/constants/theme.dart';

class MenuProgress extends StatefulWidget {
  const MenuProgress(
      {super.key,
      required this.currentTheme,
      required this.onProgressBarValueChangeEnd,
      required this.totalPage,
      required this.currentPage,
      required this.onPreviousTap,
      required this.onNextTap});

  final ReaderTheme currentTheme;
  final int totalPage;
  final int currentPage;
  final void Function(double) onProgressBarValueChangeEnd;
  final void Function() onPreviousTap;
  final void Function() onNextTap;

  @override
  State<MenuProgress> createState() => MenuProgressState();
}

class MenuProgressState extends State<MenuProgress> {
  bool visible = false;
  double currentPage = 1.0;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentPage = widget.currentPage * 1.0;
    });
  }

  @override
  void didUpdateWidget(covariant MenuProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      currentPage = widget.currentPage * 1.0;
    });
  }

  void open() {
    setState(() {
      visible = true;
    });
  }

  void close() {
    setState(() {
      visible = false;
    });
  }

  void toggle() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = widget.currentTheme;
    final baseHeight = MediaQuery.of(context).viewPadding.bottom + 48 + 132;
    return Positioned(
        bottom: -baseHeight,
        left: 0,
        child: Material(
          child: AnimatedContainer(
            width: MediaQuery.of(context).size.width,
            height: visible ? baseHeight * 2 : baseHeight,
            color: currentTheme.pannelBackgroundColor,
            duration: const Duration(milliseconds: 120),
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                      child: Text(
                        "当前进度 ${currentPage.toInt() + 1} / ${widget.totalPage}",
                        style:
                            TextStyle(fontSize: 16, color: currentTheme.pannelTextColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: IconButton(
                            icon: Icon(
                              Icons.keyboard_double_arrow_left_rounded,
                              color: currentTheme.primaryColor,
                            ),
                            onPressed: widget.onPreviousTap,
                          ),
                        ),
                        Flexible(
                          child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: currentTheme.primaryColor,
                                inactiveTrackColor: currentTheme.pannelContainerColor,
                                trackHeight: 12,
                                overlayShape: SliderComponentShape.noOverlay,
                                thumbColor: Colors.white, //滑块颜色
                                thumbShape: const RoundSliderThumbShape(
                                  disabledThumbRadius: 7, //禁用是滑块大小
                                  enabledThumbRadius: 7, //滑块大小
                                ),
                              ),
                              child: Slider(
                                  value: currentPage,
                                  min: 0,
                                  max:
                                      (widget.totalPage - 1 < currentPage) ? currentPage : (widget.totalPage - 1) * 1.0,
                                  onChanged: (val) {
                                    setState(() {
                                      currentPage = val.round().toDouble();
                                    });
                                  },
                                  onChangeEnd: widget.onProgressBarValueChangeEnd)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: IconButton(
                            icon: Icon(
                              Icons.keyboard_double_arrow_right_rounded,
                              color: currentTheme.primaryColor,
                            ),
                            onPressed: widget.onNextTap,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
