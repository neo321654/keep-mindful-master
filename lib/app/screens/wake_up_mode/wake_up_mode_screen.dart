import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../features/features.dart';
import '../../../l10n/app_loc_extension.dart';
import '../../shared/shared.dart';

const _topPadding = 10.0;
const _padding = 24.0;
const _tilePadding = EdgeInsets.symmetric(horizontal: 30.0);
const _tileInnerPadding =
    EdgeInsets.only(left: 24.0, bottom: 5.0, top: 5.0, right: 10.0);

@RoutePage()
class WakeUpModeScreen extends StatefulWidget {
  const WakeUpModeScreen({super.key});

  @override
  State<WakeUpModeScreen> createState() => _WakeUpModeScreenState();
}

class _WakeUpModeScreenState extends State<WakeUpModeScreen> {
  late final _notifier = GetIt.instance<WakeUpModeNotifier>();

  void _showQrModal(BuildContext context) {
    showModalBottomSheet<Duration?>(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        builder: (_) {
          return const ModalAlarmDisableQr();
        });
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);
    return Semantics(
      label: loc.wakeUpModeTitle,
      child: ColoredBox(
        color: theme.colorScheme.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeightSpacer(_topPadding),
            SecondaryTopBar(
              props: SecondaryTopBarProps(title: loc.wakeUpModeTitle),
            ),
            const HeightSpacer(_padding),
            ListenableBuilder(
                listenable: _notifier,
                builder: (_, __) {
                  return Padding(
                    padding: _tilePadding,
                    child: SelectableListTile(
                      props: SelectableListTileProps(
                        padding: _tileInnerPadding,
                        title: loc.wakeUpModeQr,
                        onPressed: () => _notifier
                            .setQrCodeEnabled(!_notifier.qrCodeEnabled),
                        trailing: CheckBox(
                          props: CheckBoxProps(
                              isSelected: _notifier.qrCodeEnabled,
                              onPressed: () => _notifier
                                  .setQrCodeEnabled(!_notifier.qrCodeEnabled)),
                        ),
                      ),
                    ),
                  );
                }),
            const HeightSpacer(_padding),
            ListenableBuilder(
                listenable: _notifier,
                builder: (_, __) {
                  return Padding(
                    padding: _tilePadding,
                    child: SelectableListTile(
                      props: SelectableListTileProps(
                        padding: _tileInnerPadding,
                        title: loc.wakeUpModeMathExcercise,
                        onPressed: () => _notifier
                            .setMathQuizEnabled(!_notifier.mathQuizEnabled),
                        trailing: CheckBox(
                          props: CheckBoxProps(
                              isSelected: _notifier.mathQuizEnabled,
                              onPressed: () => _notifier.setMathQuizEnabled(
                                  !_notifier.mathQuizEnabled)),
                        ),
                      ),
                    ),
                  );
                }),
            const HeightSpacer(_padding),
            ListenableBuilder(
                listenable: _notifier,
                builder: (_, __) {
                  return Padding(
                    padding: _tilePadding,
                    child: SelectableListTile(
                      props: SelectableListTileProps(
                        padding: _tileInnerPadding,
                        title: loc.wakeUpCaptcha,
                        onPressed: () => _notifier
                            .setCaptchaEnabled(!_notifier.captchaEnabled),
                        trailing: CheckBox(
                          props: CheckBoxProps(
                              isSelected: _notifier.captchaEnabled,
                              onPressed: () => _notifier.setCaptchaEnabled(
                                  !_notifier.captchaEnabled)),
                        ),
                      ),
                    ),
                  );
                }),
            const Expanded(child: SizedBox()),
            Center(
              child: Button(
                props: ButtonProps(
                  title: loc.settingsWakeUpShowQrButton,
                  onPressed: () => _showQrModal(context),
                  buttonStyle: ButtonStyles.byType(
                    theme,
                    ButtonType.borderlessTextSecondary,
                  ),
                ),
              ),
            ),
            const HeightSpacer(_padding),
          ],
        ),
      ),
    );
  }
}
