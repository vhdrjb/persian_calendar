import 'package:flutter/material.dart';

class HeaderClickBehavior {
  final Curve curve;
  final Duration duration;
  final bool clickable;

  const HeaderClickBehavior({
    required this.curve,
    required this.duration,
    this.clickable = true,
  });
}
