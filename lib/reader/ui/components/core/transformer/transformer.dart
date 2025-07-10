// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:ubuntu_logger/ubuntu_logger.dart';
// import 'package:wenku8x/reader/helper/layout.dart';

// class TransformerCore extends StatefulWidget {
//   final List<PageLayout> pages;
//   final int initialPage;
//   final Duration animationDuration;
//   final Curve animationCurve;

//   const TransformerCore({
//     super.key,
//     required this.pages,
//     this.initialPage = 0,
//     this.animationDuration = const Duration(milliseconds: 280),
//     this.animationCurve = Curves.easeOutCubic,
//   });

//   @override
//   State<TransformerCore> createState() => _TransformerCoreState();
// }

// class _TransformerCoreState extends State<TransformerCore>
//     with TickerProviderStateMixin {
//   final logger = Logger("TransformerCore");
//   late AnimationController _animationController;
//   late Animation<double> _offsetAnimation;

//   int _currentPage = 0;
//   int _targetPage = 0;
//   double _currentOffset = 0;
//   bool _isDragging = false;
//   bool _isAnimating = false;

//   double _dragStartX = 0;
//   double _screenWidth = 0;
//   double _screenHeight = 0;

//   // 手势区域配置
//   static const double _menuAreaRatio = 0.4;
//   static const double _swipeAreaRatio = 0.3;

//   @override
//   void initState() {
//     super.initState();

//     _currentPage = widget.initialPage.clamp(0, widget.pages.length - 1);
//     _targetPage = _currentPage;

//     _animationController = AnimationController(
//       duration: widget.animationDuration,
//       vsync: this,
//     );

//     _offsetAnimation = Tween<double>(begin: 0, end: 0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: widget.animationCurve,
//       ),
//     );

//     _offsetAnimation.addListener(() {
//       setState(() {
//         _currentOffset = _offsetAnimation.value;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _handleTapUp(TapUpDetails details) {
//     logger.debug("Tap up at: ${details.globalPosition.dx}");
//     if (_isAnimating) return;

//     final tapX = details.globalPosition.dx;
//     final tapRatio = tapX / _screenWidth;

//     logger.debug("Tap position: $tapX, Ratio: $tapRatio");

//     // 左右区域翻页，中央区域唤起菜单
//     if (tapRatio <= _swipeAreaRatio) {
//       // 左侧区域，上一页
//       _goToPreviousPage();
//     } else if (tapRatio >= (1 - _swipeAreaRatio)) {
//       // 右侧区域，下一页
//       _goToNextPage();
//     } else {
//       // 中央区域，唤起菜单
//       HapticFeedback.lightImpact();
//       // widget.onMenuTap?.call();
//     }
//   }

//   void _goToPreviousPage() {
//     if (_currentPage > 0) {
//       _animateToPage(_currentPage - 1);
//     } else {
//       _animateToOffset(0); // 已经是第一页，回弹
//       HapticFeedback.lightImpact();
//     }
//   }

//   void _goToNextPage() {
//     if (_currentPage < widget.pages.length - 1) {
//       _animateToPage(_currentPage + 1);
//     } else {
//       _animateToOffset(0); // 已经是最后一页，回弹
//       HapticFeedback.lightImpact();
//     }
//   }

//   void _animateToPage(int targetPage) {
//     if (_isAnimating) return;

//     final newPage = targetPage.clamp(0, widget.pages.length - 1);

//     if (_currentPage != newPage) {
//       setState(() {
//         _targetPage = newPage; // 设置目标页面，但不立即更新当前页面
//         _isAnimating = true;
//       });

//       // 计算动画方向：向右翻页（下一页）offset 变负，向左翻页（上一页）offset 变正
//       final direction = newPage > _currentPage ? -1.0 : 1.0;
//       _animateToOffset(_screenWidth * direction);
//     } else {
//       // 回弹动画
//       _animateToOffset(0);
//     }
//   }

//   void _animateToOffset(double targetOffset) {
//     if (_isAnimating && targetOffset != 0) return;

//     setState(() {
//       _isAnimating = true;
//     });

//     _offsetAnimation = Tween<double>(begin: _currentOffset, end: targetOffset)
//         .animate(
//           CurvedAnimation(
//             parent: _animationController,
//             curve: widget.animationCurve,
//           ),
//         );

//     _animationController.reset();
//     _animationController.forward();
//   }

//   Widget _buildPage(int index) {
//     if (index < 0 || index >= widget.pages.length) {
//       return Container(); // 空页面
//     }

//     return RepaintBoundary(
//       key: ValueKey(index),
//       child: ChineseLayoutView(page: widget.pages[index]),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     _screenWidth = MediaQuery.of(context).size.width;
//     _screenHeight = MediaQuery.of(context).size.height;
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTapUp: _handleTapUp,
//       onTapDown: (details) {
//         logger.debug("Tap down at: ${details.globalPosition.dx}");
//       },
//       child: SizedBox(
//         width: _screenWidth,
//         height: _screenHeight,
//         child: Stack(
//           children: [
//             // 当前页面
//             Positioned(
//               left: _currentOffset,
//               top: 0,
//               child: SizedBox(
//                 width: _screenWidth,
//                 height: _screenHeight,
//                 child: _buildPage(_currentPage),
//               ),
//             ),

//             // 目标页面（仅在动画时显示）
//             if (_isAnimating && _targetPage != _currentPage)
//               Positioned(
//                 left: _targetPage > _currentPage
//                     ? _screenWidth +
//                           _currentOffset // 下一页从右侧进入
//                     : -_screenWidth + _currentOffset, // 上一页从左侧进入
//                 top: 0,
//                 child: SizedBox(
//                   width: _screenWidth,
//                   height: _screenHeight,
//                   child: _buildPage(_targetPage),
//                 ),
//               ),

//             // 非动画状态下的相邻页面预览（用于拖拽）
//             if (!_isAnimating) ...[
//               // 上一页（左侧）
//               if (_currentPage > 0 && _currentOffset > 0)
//                 Positioned(
//                   left: -_screenWidth + _currentOffset,
//                   top: 0,
//                   child: SizedBox(
//                     width: _screenWidth,
//                     height: _screenHeight,
//                     child: _buildPage(_currentPage - 1),
//                   ),
//                 ),

//               // 下一页（右侧）
//               if (_currentPage < widget.pages.length - 1 && _currentOffset < 0)
//                 Positioned(
//                   left: _screenWidth + _currentOffset,
//                   top: 0,
//                   child: SizedBox(
//                     width: _screenWidth,
//                     height: _screenHeight,
//                     child: _buildPage(_currentPage + 1),
//                   ),
//                 ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
