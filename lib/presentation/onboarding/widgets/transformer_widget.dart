// ignore_for_file: library_prefixes, constant_identifier_names

import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as Math;

// ignore: import_of_legacy_library_into_null_safe

class CustomTransformer extends PageTransformer {
  static const double MIN_SCALE = 0.6;
  int count = 0;
  double before = 0;
  late double after;

  @override
  Widget transform(Widget child, TransformInfo info) {
    double? position = info.position;
    double? pageWidth = info.width;
    double? pageHeight = info.height;

    double? opacity = Math.max(1.0 - Math.pow(position!.abs(), .5), 0);

    double? scaleFactor = Math.max(MIN_SCALE, 1 - position.abs());
    double vertMargin = pageHeight! * (1 - scaleFactor) / 2;
    double horzMargin = pageWidth! * (1 - scaleFactor) / 2;
    double dx;
    if (position < 0) {
      dx = (horzMargin - vertMargin / 2);
    } else {
      dx = (-horzMargin + vertMargin / 2);
    }

    return Opacity(
      opacity: opacity,
      child: Transform.translate(
        offset: Offset(dx, 0.0),
        child: Transform.scale(
          scale: scaleFactor,
          child: child,
        ),
      ),
    );
  }
}