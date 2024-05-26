import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../l10n/app_loc_extension.dart';
import '../../button/button.dart';
import '../../separated/separated.dart';
import '../../spacer/spacer.dart';
import '../modal_bottom_origin/modal_bottom_origin.dart';
import 'modal_alarm_disable_qr_scan_props.dart';
import 'qr_reader/qr_reader.dart';

const _horizontalPadding = 24.0;
const _verticalPadding = 54.0;
const _elementsPadding = 36.0;
const _height = 480.0;
const _closeDelayDuration = Duration(seconds: 2);

class ModalAlarmDisableQrScan extends StatefulWidget {
  const ModalAlarmDisableQrScan({required this.props, super.key});

  final ModalAlarmDisabelQrScanProps props;

  @override
  State<ModalAlarmDisableQrScan> createState() => _ModalAlarmDisableQrState();
}

class _ModalAlarmDisableQrState extends State<ModalAlarmDisableQrScan> {
  Timer? _timer;

  bool _received = false;
  bool _isClosable = false;

  void _startCloseTimer() {
    _timer = Timer(_closeDelayDuration, () {
      setState(() {
        _isClosable = true;
      });
      Navigator.of(context).pop(true);
    });
  }

  void _handleReceivedQrs(List<String?> qrs) {
    if (_received) {
      return;
    }
    for (final receivedQr in qrs) {
      if (receivedQr != widget.props.qr) {
        continue;
      }

      setState(() {
        _received = true;
      });
      _startCloseTimer();
      break;
    }
  }

  void _onChangeToAnotherWay() {
    if (_timer?.isActive ?? false) {
      return;
    }
    setState(() {
      _isClosable = true;
    });
    Navigator.of(context).pop();
    widget.props.onTryAnotherWayPressed?.call();
  }

  @override
  void dispose() {
    if (_timer?.isActive ?? false) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);

    final isOnTryAnotherWayEmpty = widget.props.onTryAnotherWayPressed == null;

    return PopScope(
      canPop: _isClosable,
      child: ModalBottomOrigin(
        props: ModalBottomOriginProps(
          height: _height,
          padding: const EdgeInsets.symmetric(
              horizontal: _horizontalPadding, vertical: _verticalPadding),
          child: SeparatedColumn(
            separatorBuilder: (_, __) => const HeightSpacer(_elementsPadding),
            children: [
              Text(
                loc.alarmDisableQrTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w300),
              ),
              QrReader(
                props: QrReaderProps(
                    onQrsReceived: _handleReceivedQrs, isConfirmed: _received),
              ),
              Center(
                child: Button(
                  props: ButtonProps(
                    title: loc.alarmDisableAnotherWayButton,
                    isDisabled: isOnTryAnotherWayEmpty,
                    onPressed: _onChangeToAnotherWay,
                    buttonStyle: ButtonStyles.byType(
                      theme,
                      ButtonType.borderlessTextSecondary,
                    ),
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
