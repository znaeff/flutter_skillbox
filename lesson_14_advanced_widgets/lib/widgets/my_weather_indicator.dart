import 'dart:ui';

import 'package:flutter/material.dart';

import 'utils.dart';

class MyWeatherIndicator extends CustomPainter {
  final double weatherBadness;
  final Color cloudColor;
  static const int widgetSmallBorder = 150;
  static const double weatherBadnessBorder1 = 0.3;
  static const double weatherBadnessBorder2 = 0.7;
  static const String commentTextBright = 'ЯСНО';
  static const String commentTextMiddle = 'СРЕДНЕ';
  static const String commentTextSucks = 'ОТСТОЙ';

  MyWeatherIndicator(this.weatherBadness, {this.cloudColor = Colors.grey});

  Path pathRainDrop(double x, double y, double deltaX, double deltaY) {
    return Path()
      ..moveTo(x, y)
      ..lineTo(x + deltaX, y - deltaY)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    double sizeSmallest = size.width < size.height ? size.width : size.height;

    double startY = 0;
    if (sizeSmallest <= widgetSmallBorder) {
      startY = sizeSmallest / 15;
    }

    double sunRadius = sizeSmallest / 5;
    double sunX = size.width / 2;
    double sunY = size.height / 3 + startY;

    double cloudX = size.width / 2 - size.width / 10;
    double cloudY = size.height / 2 + startY;
    double cloudRadius = sizeSmallest / 8;

    double rainLen = size.height / 8;
    double rainStep = size.width / 5;
    double rainDeltaX = sizeSmallest / 10;
    double rainX1 = size.width / 2 - rainStep;
    double rainX2 = size.width / 2;
    double rainX3 = size.width / 2 + rainStep;
    double rainY = size.height - rainLen * 2.2 + startY;

    double sunOpacity;
    double cloudOpacity;
    double rainOpacity;

    String commentText = '';
    double commentFontSize = sizeSmallest / 8;

    double borderWidth = sizeSmallest / 20;

    if (weatherBadness <= weatherBadnessBorder1) {
      commentText = commentTextBright;
      sunOpacity = 1.0;
      cloudOpacity =
          getPercentFromRange(0.0, weatherBadnessBorder2, weatherBadness);
      rainOpacity = 0.0;
    } else if (weatherBadness <= weatherBadnessBorder2) {
      commentText = commentTextMiddle;
      sunOpacity = 1.0 -
          getPercentFromRange(
              weatherBadnessBorder1, weatherBadnessBorder2, weatherBadness);
      cloudOpacity =
          getPercentFromRange(0.0, weatherBadnessBorder2, weatherBadness);
      rainOpacity = 0.0;
    } else {
      commentText = commentTextSucks;
      sunOpacity = 0.0;
      cloudOpacity = 1.0;
      rainOpacity =
          getPercentFromRange(weatherBadnessBorder2, 1.0, weatherBadness);
    }

    var painterSun = Paint()
      ..color = Colors.yellow.withOpacity(sunOpacity)
      ..style = PaintingStyle.fill;
    var pathSun = Path()
      ..addOval(Rect.fromCircle(center: Offset(sunX, sunY), radius: sunRadius))
      ..close();

    var painterCloud = Paint()
      ..color = cloudColor.withOpacity(cloudOpacity)
      ..style = PaintingStyle.fill;
    var pathCloud = Path()
      ..addOval(
          Rect.fromCircle(center: Offset(cloudX, cloudY), radius: cloudRadius))
      ..addOval(Rect.fromCircle(
          center: Offset(cloudX + cloudRadius * 1.3, cloudY),
          radius: cloudRadius * 1.3))
      ..addOval(Rect.fromCircle(
          center: Offset(cloudX + cloudRadius * 2.5, cloudY),
          radius: cloudRadius * 1.2))
      ..close();

    var painterRain = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = sizeSmallest / 20
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.blueGrey.withOpacity(rainOpacity);

    canvas.drawPath(pathSun, painterSun);

    canvas.drawPath(pathCloud, painterCloud);

    canvas.drawPath(
        pathRainDrop(rainX1, rainY, rainDeltaX, rainLen), painterRain);
    canvas.drawPath(
        pathRainDrop(rainX2, rainY, rainDeltaX, rainLen), painterRain);
    canvas.drawPath(
        pathRainDrop(rainX3, rainY, rainDeltaX, rainLen), painterRain);

    if (sizeSmallest > widgetSmallBorder) {
      final TextStyle commentStyle = TextStyle(
        color: cloudColor,
        fontSize: commentFontSize,
        fontWeight: FontWeight.bold,
      );

      final ParagraphBuilder paragraphBuilder = ParagraphBuilder(
        ParagraphStyle(
          fontSize: commentStyle.fontSize,
          fontFamily: commentStyle.fontFamily,
          fontStyle: commentStyle.fontStyle,
          fontWeight: commentStyle.fontWeight,
          textAlign: TextAlign.center,
        ),
      )
        ..pushStyle(commentStyle.getTextStyle())
        ..addText(commentText);
      final Paragraph paragraph = paragraphBuilder.build()
        ..layout(ParagraphConstraints(width: size.width));
      canvas.drawParagraph(paragraph,
          Offset(0, size.height - paragraph.height - paragraph.height / 2));
    }

    var painterBorder = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeJoin = StrokeJoin.round
      ..color = cloudColor.withOpacity(0.7);
    var pathBorder = Path()
      ..addRRect(RRect.fromLTRBXY(
          borderWidth / 2,
          borderWidth / 2,
          size.width - borderWidth / 2,
          size.height - borderWidth / 2,
          sizeSmallest / 15,
          sizeSmallest / 15))
//      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..close();
    canvas.drawPath(pathBorder, painterBorder);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
