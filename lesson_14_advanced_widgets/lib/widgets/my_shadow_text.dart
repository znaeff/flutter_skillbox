import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyShadowText extends SingleChildRenderObjectWidget {
  final Color color;

  const MyShadowText({required this.color, required Widget child, Key? key})
      : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderMyTint(color: color);
}

class RenderMyTint extends RenderProxyBox {
  final Color? _color;

  RenderMyTint({Color? color, RenderBox? child})
      : _color = color,
        super(child);

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      Rect rectOuter = offset & size;
      Paint shadowPaint = Paint()
        ..colorFilter = ColorFilter.mode(_color!, BlendMode.srcATop)
        ..imageFilter = ImageFilter.blur(sigmaX: 1.0, sigmaY: 3.0);
      context.canvas.saveLayer(rectOuter, shadowPaint);
      context.paintChild(child!, Offset(offset.dx + 3, offset.dy + 5));
      context.canvas.restore();
      context.paintChild(child!, offset);
    }
  }
}
