import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

OverlayEntry createLoadingOverlay(BuildContext context) {
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Material(
        color: Colors.black.withOpacity(0.10),
        child: const Center(
          child: SpinKitWaveSpinner(color: Color(0xFF008080), size: 96.0,
          ),
        ),
      ),
    ),
  );

  return overlayEntry;
}
