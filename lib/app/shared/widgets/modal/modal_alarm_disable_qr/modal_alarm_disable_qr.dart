import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';

import '../../../../../features/features.dart';
import '../../../../../l10n/app_loc_extension.dart';
import '../../../shared.dart';
import 'alarm_disable_qr/alarm_disable_qr.dart';

const _padding = 24.0;
const _elementsPadding = 36.0;

class ModalAlarmDisableQr extends StatefulWidget {
  const ModalAlarmDisableQr({super.key});

  @override
  State<ModalAlarmDisableQr> createState() => _ModalAlarmDisableQrState();
}

class _ModalAlarmDisableQrState extends State<ModalAlarmDisableQr> {
  final _qrService = GetIt.instance<AlarmDisableQrCodeService>();

  final GlobalKey _qrBounderyKey = GlobalKey();
  late final QrSaver _qrSaver;

  @override
  void initState() {
    super.initState();
    _qrSaver = QrSaver();
  }

  Future<void> _onDownloadTapped(BuildContext context) async {
    final boundary = _qrBounderyKey.currentContext!.findRenderObject()
        as RenderRepaintBoundary;
    await _qrSaver.saveImageToGallery(boundary);
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);

    final screenHeight = MediaQuery.of(context).size.height;

    return ModalBottomOrigin(
      props: ModalBottomOriginProps(
        height: screenHeight * 5 / 8,
        padding: const EdgeInsets.all(_padding),
        child: SeparatedColumn(
          separatorBuilder: (_, __) => const HeightSpacer(_elementsPadding),
          children: [
            Text(
              loc.awakeningAlarmDisableQrTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w300),
            ),
            RepaintBoundary(
                key: _qrBounderyKey,
                child: AlarmDisableQr(
                    props: AlarmDisableQrProps(qr: _qrService.getQr()!))),
            Text(
              loc.awakeningAlarmDisableQrHint,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor, fontWeight: FontWeight.w300),
            ),
            Button(
              props: ButtonProps(
                title: loc.awakeningAlarmQrDownload,
                onPressed: () => _onDownloadTapped(context),
                buttonStyle:
                    ButtonStyles.byType(theme, ButtonType.rectangleText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
