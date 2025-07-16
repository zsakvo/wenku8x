import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './loading_indicator_theme.dart';
import 'package:material_shapes/material_shapes.dart';

const _kContainerSize = 48.0;
const _kActiveIndicatorSize = 38.0;
const _kActiveIndicatorScale = _kActiveIndicatorSize / _kContainerSize;

const _kFullRotationAngle = math.pi * 2;
const _kSingleRotationAngle = math.pi * 3 / 4;
const _kLinearRotationAngle = math.pi / 4;
const _kMorphRotationAngle = _kSingleRotationAngle - _kLinearRotationAngle;

/// A Material Design loading indicator, which shows the progress for a short
/// wait time.
///
/// A widget that displays an animated, morphing shape to indicate ongoing
/// activity. There are two variants of loading indicators:
///
/// - *_Default (Non-contained)_*: the active loading indicator appears without
/// a background container.
/// - *_Contained_*. The active loading indicator is displayed over a container
/// surface.
class LoadingIndicator extends StatefulWidget {
  /// Creates a default (non-contained) version of [LoadingIndicator].
  LoadingIndicator({
    List<RoundedPolygon>? indicatorPolygons,
    Color? activeIndicatorColor,
    Color? containerColor,
    String? semanticsLabel,
    Key? key,
  }) : this._(
         isContained: false,
         indicatorPolygons: indicatorPolygons,
         activeIndicatorColor: activeIndicatorColor,
         containerColor: containerColor,
         semanticsLabel: semanticsLabel,
         key: key,
       );

  /// Creates a contained version of [LoadingIndicator].
  LoadingIndicator.contained({
    List<RoundedPolygon>? indicatorPolygons,
    Color? activeIndicatorColor,
    Color? containerColor,
    String? semanticsLabel,
    Key? key,
  }) : this._(
         isContained: true,
         indicatorPolygons: indicatorPolygons,
         activeIndicatorColor: activeIndicatorColor,
         containerColor: containerColor,
         semanticsLabel: semanticsLabel,
         key: key,
       );

  LoadingIndicator._({
    required bool isContained,
    List<RoundedPolygon>? indicatorPolygons,
    this.activeIndicatorColor,
    this.containerColor,
    this.semanticsLabel,
    super.key,
  }) : _isContained = isContained,
       indicatorPolygons =
           indicatorPolygons ?? LoadingIndicator.indeterminateIndicatorPolygons,
       assert(
         indicatorPolygons == null || indicatorPolygons.length > 1,
         'indicatorPolygons should have, at least, two RoundedPolygons',
       );

  /// Whether this indicator is contained.
  final bool _isContained;

  /// Color of the active indicator shape.
  ///
  /// If [LoadingIndicator.activeIndicatorColor] is null, the value from
  /// [LoadingIndicatorThemeData.activeIndicatorColor] in the ambient theme is
  /// used. If that is also null, the color defaults to [ColorScheme.primary]
  /// for non-contained indicators, and to [ColorScheme.onPrimaryContainer] for
  /// contained indicators.
  final Color? activeIndicatorColor;

  /// Color of the background container.
  ///
  /// If [LoadingIndicator.containerColor] is null, the value from
  /// [LoadingIndicatorThemeData.containerColor] in the ambient theme is used.
  /// If that is also null, the color defaults to
  /// [ColorScheme.primaryContainer].
  final Color? containerColor;

  /// The semantic label for this loading indicator.

  /// This value is read aloud to describe the indicator’s purpose.
  /// It corresponds to [SemanticsProperties.label].
  final String? semanticsLabel;

  /// A list of [RoundedPolygon]s for the sequence of shapes this loading
  /// indicator will morph between as it progresses.
  ///
  /// The loading indicator expects at least two items in this list.
  ///
  /// Defaults to [LoadingIndicator.indeterminateIndicatorPolygons].
  final List<RoundedPolygon> indicatorPolygons;

  /// The sequence of [RoundedPolygon]s that the indeterminate
  /// [LoadingIndicator] will morph between when animating.
  ///
  /// This list is used as the default value for the
  /// [LoadingIndicator.indicatorPolygons] parameter when none is explicitly
  /// provided.
  static final indeterminateIndicatorPolygons = UnmodifiableListView([
    MaterialShapes.softBurst,
    MaterialShapes.cookie9Sided,
    MaterialShapes.pentagon,
    MaterialShapes.pill,
    MaterialShapes.sunny,
    MaterialShapes.cookie4Sided,
    MaterialShapes.oval,
  ]);

  /// The sequence of [RoundedPolygon]s that the determinate [LoadingIndicator]
  /// will morph between when animating.
  static final determinateIndicatorPolygons = UnmodifiableListView([
    MaterialShapes.circle,
    MaterialShapes.softBurst,
  ]);

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  final _globalAngle = ValueNotifier<double>(0);

  final _morphIndex = ValueNotifier<int>(0);

  final List<Morph> _morphs = [];

  var _morphScaleFactor = 1.0;

  late final AnimationController _controller;

  late final _rotation = Tween<double>(begin: 0, end: 1).animate(_controller);

  late final _scale =
      TweenSequence<double>([
            TweenSequenceItem(
              tween: Tween(begin: 1, end: 1.125),
              weight: 200 / 350,
            ),
            TweenSequenceItem(
              tween: Tween(begin: 1.125, end: 1),
              weight: 150 / 350,
            ),
          ])
          .chain(CurveTween(curve: const Interval(300 / 650, 650 / 650)))
          .animate(_controller);

  late final _morphProgress = Tween<double>(begin: 0, end: 1)
      .chain(
        CurveTween(
          curve: const Interval(300 / 650, 550 / 650, curve: Curves.easeOut),
        ),
      )
      .animate(_controller);

  @override
  void initState() {
    super.initState();

    _initMorphs();

    _controller =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 650),
          )
          ..addStatusListener(_statusListener)
          ..forward();
  }

  @override
  void didUpdateWidget(LoadingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.indicatorPolygons != widget.indicatorPolygons) {
      _initMorphs();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _morphIndex.dispose();
    super.dispose();
  }

  void _statusListener(AnimationStatus status) {
    if (status != AnimationStatus.completed) {
      return;
    }

    _globalAngle.value =
        (_globalAngle.value + _kSingleRotationAngle) % _kFullRotationAngle;
    _morphIndex.value = (_morphIndex.value + 1) % _morphs.length;
    _controller.forward(from: 0);
  }

  void _initMorphs() {
    _morphIndex.value = 0;

    _morphs.clear();
    for (var i = 0; i < widget.indicatorPolygons.length; i++) {
      _morphs.add(
        Morph(
          widget.indicatorPolygons[i],
          widget.indicatorPolygons[(i + 1) % widget.indicatorPolygons.length],
        ),
      );
    }

    // Calculate the shapes scale factor that will be applied to the morphed
    // path as it's scaled into the available size.
    // This overall scale factor ensures that the shapes are rendered without
    // clipping and at the correct ratio within the component by taking into
    // account their occupied size as they rotate, and taking into account the
    // spec's _kActiveIndicatorScale.
    _morphScaleFactor = _calculateScaleFactor(widget.indicatorPolygons);
  }

  /// Calculates a scale factor that will be used when scaling the provided
  /// [RoundedPolygon]s into a specified sized container.
  ///
  /// Since the polygons may rotate, a simple [RoundedPolygon.calculateBounds]
  /// is not enough to determine the size the polygon will occupy as it
  /// rotates. Using the simple bounds calculation may result in a clipped
  /// shape.
  ///
  /// This function calculates and returns a scale factor by utilizing the
  /// [RoundedPolygon.calculateMaxBounds] and comparing its result to the
  /// [RoundedPolygon.calculateBounds].
  double _calculateScaleFactor(List<RoundedPolygon> polygons) {
    var scaleFactor = 1.0;
    // Axis-aligned max bounding box for this object, where the rectangles left,
    // top, right, and bottom values will be stored in entries 0, 1, 2, and 3,
    // in that order.
    final bounds = List<double>.filled(4, 0);
    final maxBounds = List<double>.filled(4, 0);
    for (final polygon in polygons) {
      polygon
        ..calculateBounds(bounds: bounds)
        ..calculateMaxBounds(maxBounds);

      final scaleX = (bounds[2] - bounds[0]) / (maxBounds[2] - maxBounds[0]);
      final scaleY = (bounds[3] - bounds[1]) / (maxBounds[3] - maxBounds[1]);
      scaleFactor = math.min(scaleFactor, math.max(scaleX, scaleY));
    }
    return scaleFactor;
  }

  @override
  Widget build(BuildContext context) {
    late final indicatorTheme = LoadingIndicatorTheme.of(context);

    final activeIndicatorColor =
        widget.activeIndicatorColor ??
        indicatorTheme?.activeIndicatorColor ??
        Theme.of(context).colorScheme.primary;

    final containerColor =
        widget.containerColor ??
        indicatorTheme?.containerColor ??
        Theme.of(context).colorScheme.primaryContainer;

    return Semantics(
      label: widget.semanticsLabel,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: _kContainerSize,
          minHeight: _kContainerSize,
        ),
        child: ClipOval(
          child: CustomPaint(
            painter: widget._isContained
                ? _ContainerPainter(containerColor: containerColor)
                : null,
            foregroundPainter: _ActiveIndicatorPainter(
              activeIndicatorColor: activeIndicatorColor,
              morphScaleFactor: _morphScaleFactor,
              morphs: _morphs,
              morphIndex: _morphIndex,
              globalAngle: _globalAngle,
              rotation: _rotation,
              scale: _scale,
              morphProgress: _morphProgress,
            ),
          ),
        ),
      ),
    );
  }
}

class _ContainerPainter extends CustomPainter {
  const _ContainerPainter({required this.containerColor});

  final Color containerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawOval(rect, Paint()..color = containerColor);
  }

  @override
  bool shouldRepaint(_ContainerPainter oldDelegate) {
    return oldDelegate.containerColor != containerColor;
  }
}

class _ActiveIndicatorPainter extends CustomPainter {
  _ActiveIndicatorPainter({
    required this.activeIndicatorColor,
    required this.morphScaleFactor,
    required this.morphs,
    required this.morphIndex,
    required this.globalAngle,
    required this.rotation,
    required this.scale,
    required this.morphProgress,
  }) : super(
         repaint: Listenable.merge([
           morphIndex,
           globalAngle,
           rotation,
           scale,
           morphProgress,
         ]),
       );

  final Color activeIndicatorColor;

  final double morphScaleFactor;

  final List<Morph> morphs;

  final ValueListenable<int> morphIndex;

  final ValueListenable<double> globalAngle;

  final Animation<double> rotation;

  final Animation<double> scale;

  final Animation<double> morphProgress;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final angle =
        globalAngle.value +
        _kLinearRotationAngle * rotation.value +
        _kMorphRotationAngle * morphProgress.value;

    final path = morphs[morphIndex.value].toPath(progress: morphProgress.value);

    final scaleFactor = morphScaleFactor * _kActiveIndicatorScale * scale.value;
    final remainingScaleFactor = 1 - scaleFactor;

    final halfWidth = rect.width / 2;
    final halfHeight = rect.height / 2;

    canvas
      ..save()
      ..translate(halfWidth, halfHeight)
      ..rotate(angle)
      ..translate(-halfWidth, -halfHeight)
      ..translate(
        halfWidth * remainingScaleFactor,
        halfHeight * remainingScaleFactor,
      )
      ..scale(rect.width * scaleFactor, rect.height * scaleFactor)
      ..drawPath(
        path,
        Paint()
          ..style = PaintingStyle.fill
          ..color = activeIndicatorColor,
      )
      ..translate(
        -halfWidth * remainingScaleFactor,
        -halfHeight * remainingScaleFactor,
      )
      ..restore();
  }

  @override
  bool shouldRepaint(_ActiveIndicatorPainter oldDelegate) {
    return oldDelegate.activeIndicatorColor != activeIndicatorColor ||
        oldDelegate.morphScaleFactor != morphScaleFactor ||
        oldDelegate.morphs != morphs ||
        oldDelegate.morphIndex != morphIndex ||
        oldDelegate.globalAngle != globalAngle ||
        oldDelegate.rotation != rotation ||
        oldDelegate.scale != scale ||
        oldDelegate.morphProgress != morphProgress;
  }
}
