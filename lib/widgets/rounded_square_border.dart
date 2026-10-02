// lib/widgets/rounded_square_border.dart
import 'dart:math';
import 'package:flutter/material.dart';

/// A [ShapeBorder] that renders as a rounded-corner square,
/// centered within the provided bounding box.
class RoundedSquareBorder extends OutlinedBorder {
  final double borderRadius;
  final double? size;

  const RoundedSquareBorder({
    this.borderRadius = 14.0,
    this.size,
    super.side,
  });

  @override
  OutlinedBorder copyWith({
    BorderSide? side,
    double? borderRadius,
    double? size,
  }) {
    return RoundedSquareBorder(
      side: side ?? this.side,
      borderRadius: borderRadius ?? this.borderRadius,
      size: size ?? this.size,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect.deflate(side.width), textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final s = size ?? min(rect.width, rect.height);
    final squareRect = Rect.fromCenter(
      center: rect.center,
      width: s,
      height: s,
    );
    final r = RRect.fromRectAndRadius(
      squareRect,
      Radius.circular(borderRadius),
    );
    return Path()..addRRect(r);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none) return;
    final s = size ?? min(rect.width, rect.height);
    final squareRect = Rect.fromCenter(
      center: rect.center,
      width: s,
      height: s,
    );
    final r = RRect.fromRectAndRadius(
      squareRect,
      Radius.circular(borderRadius),
    );
    canvas.drawRRect(r, side.toPaint());
  }

  @override
  ShapeBorder scale(double t) {
    return RoundedSquareBorder(
      side: side.scale(t),
      borderRadius: borderRadius * t,
      size: size != null ? size! * t : null,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is RoundedSquareBorder &&
        other.side == side &&
        other.borderRadius == borderRadius &&
        other.size == size;
  }

  @override
  int get hashCode => Object.hash(side, borderRadius, size);

  @override
  String toString() =>
      'RoundedSquareBorder(side: $side, borderRadius: $borderRadius, size: $size)';
}
