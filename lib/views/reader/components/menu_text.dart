import 'package:flutter/material.dart';
import 'package:wenku8x/views/reader/constants/theme.dart';

class MenuText extends StatefulWidget {
  const MenuText({
    Key? key,
    required this.fontSize,
    required this.lineSpace,
    required this.onFontSizeSlideBarValueChangeEnd,
    required this.onTextSpaceSlideBarValueChangeEnd,
    required this.currentTheme,
    // required this.backgroundColor,
    // required this.primaryColor,
    // required this.secondColor,
    // required this.tertiaryColor
  }) : super(key: key);

  final double fontSize;
  final double lineSpace;
  final ReaderTheme currentTheme;
  // final Color backgroundColor;
  // final Color primaryColor;
  // final Color secondColor;
  // final Color tertiaryColor;
  final void Function(double) onFontSizeSlideBarValueChangeEnd;
  final void Function(double) onTextSpaceSlideBarValueChangeEnd;

  @override
  State<MenuText> createState() => MenuTextState();
}

class MenuTextState extends State<MenuText> {
  bool visible = false;
  late double fontSize;
  late double lineSpace;

  @override
  void initState() {
    super.initState();
    fontSize = widget.fontSize;
    lineSpace = widget.lineSpace;
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
    final baseHeight = MediaQuery.of(context).viewPadding.bottom + 48 + 180;
    return Positioned(
        bottom: -baseHeight,
        left: 0,
        child: Material(
            child: AnimatedContainer(
                alignment: visible ? Alignment.topCenter : Alignment.bottomCenter,
                duration: const Duration(milliseconds: 120),
                width: MediaQuery.of(context).size.width,
                height: visible ? baseHeight * 2 : baseHeight,
                color: currentTheme.pannelBackgroundColor,
                child: Wrap(
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                        child: Text(
                          "排版",
                          style: TextStyle(fontSize: 16, color: Color(0xff262626), fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: IconButton(
                              icon: Icon(
                                Icons.text_decrease,
                                color: currentTheme.primaryColor,
                              ),
                              onPressed: () {},
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
                                    value: fontSize,
                                    min: 16,
                                    max: 28,
                                    onChanged: (val) {
                                      setState(() {
                                        fontSize = val.round() * 1.0;
                                      });
                                    },
                                    onChangeEnd: (val) => widget.onFontSizeSlideBarValueChangeEnd(fontSize))),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: IconButton(
                              icon: Icon(
                                Icons.text_increase,
                                color: currentTheme.primaryColor,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: IconButton(
                              icon: Icon(
                                Icons.drag_handle,
                                color: currentTheme.primaryColor,
                              ),
                              onPressed: () {},
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
                                  value: lineSpace,
                                  min: 1.3,
                                  max: 2.5,
                                  onChanged: (val) {
                                    setState(() {
                                      lineSpace = double.parse(val.toStringAsFixed(1));
                                    });
                                  },
                                  onChangeEnd: (val) => widget.onTextSpaceSlideBarValueChangeEnd(lineSpace),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: currentTheme.primaryColor,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ])
                  ],
                ))));
  }
}
