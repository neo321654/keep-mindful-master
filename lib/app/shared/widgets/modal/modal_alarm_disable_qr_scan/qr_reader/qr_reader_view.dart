import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'alarm_confirmed.dart';
import 'qr_reader_props.dart';
import 'view_finder_painter.dart';

const _containerBorderRadius = 16.0;
const _size = 250.0;
const _containerPadding = 2.0;
const _borderWidth = 3.0;
const _innerBoxSize = Size(190.0, 190.0);
const _animationDuration = Duration(milliseconds: 400);

class QrReader extends StatelessWidget {
  const QrReader({required this.props, super.key});

  final QrReaderProps props;

  void _onQrReceived(BarcodeCapture capture) {
    final stringBarcodes = capture.barcodes.map((e) => e.rawValue).toList();
    props.onQrsReceived?.call(stringBarcodes);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_containerBorderRadius),
        border: Border.all(color: theme.primaryColor, width: _borderWidth),
      ),
      child: Padding(
        padding: const EdgeInsets.all(_containerPadding),
        child: SizedBox(
          height: _size,
          width: _size,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_containerBorderRadius),
                  child: MobileScanner(
                    startDelay: true,
                    onDetect: _onQrReceived,
                  ),
                ),
              ),
              Center(
                child: AnimatedSwitcher(
                  duration: _animationDuration,
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  child: props.isConfirmed
                      ? SizedBox.fromSize(
                          size: _innerBoxSize, child: const AlarmConfirmed())
                      : CustomPaint(
                          size: _innerBoxSize,
                          painter: ViewFinderPainter(
                              strokeColor: theme.hintColor.withOpacity(0.6)),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
