import 'package:flutter/material.dart';

Alignment toAlignment(String alignment) {
  switch (alignment) {
    case 'Alignment.topLeft':
      return Alignment.topLeft;
    case 'Alignment.topCenter':
      return Alignment.topCenter;
    case 'Alignment.topRight':
      return Alignment.topRight;
    case 'Alignment.centerLeft':
      return Alignment.centerLeft;
    case 'Alignment.center':
      return Alignment.center;
    case 'Alignment.centerRight':
      return Alignment.centerRight;
    case 'Alignment.bottomLeft':
      return Alignment.bottomLeft;
    case 'Alignment.bottomCenter':
      return Alignment.bottomCenter;
    case 'Alignment.bottomRight':
      return Alignment.bottomRight;
    default:
      return Alignment.center;
  }
}
