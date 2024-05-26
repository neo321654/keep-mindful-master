import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../../features/features.dart';
import '../../../../../../../l10n/app_loc_extension.dart';
import '../../../../../shared.dart';
import 'ble_device/ble_device.dart';
import 'pair_hint.dart';

const _horizontalPadding = 41.0;
const _verticalPadding = 24.0;
const _listVerticalPadding = 12.0;
const _paddingBetweenDevices = 16.0;
const _titleBottomPadding = 10.0;

const _switchAnimationDuration = Duration(milliseconds: 400);

class DevicesFragment extends StatelessWidget {
  DevicesFragment({super.key});

  final _scanNotifier = GetIt.instance<BluetoothDevicesScanNotifier>();
  final _deviceNotifier = GetIt.instance<BluetoothDeviceStateNotifier>();

  BleDeviceConnectionState _getDeviceConnectionState(String? uuid) {
    final isSelected = _deviceNotifier.device?.remoteId == uuid;
    if (!isSelected) {
      return BleDeviceConnectionState.disconnected;
    }
    return _deviceNotifier.connectionState;
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: Text(
              loc.bluetoothAvailableDevices,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          const HeightSpacer(_titleBottomPadding),
          ListenableBuilder(
              listenable: Listenable.merge([_scanNotifier, _deviceNotifier]),
              builder: (_, __) {
                final devices = _scanNotifier.scanResults.map((device) {
                  final state =
                      _getDeviceConnectionState(device.device.remoteId.str);
                  final deviceName = device.advertisementData.advName.isEmpty
                      ? device.device.remoteId.str
                      : device.advertisementData.advName;
                  final showConnectionError = device.device.remoteId.str ==
                      _deviceNotifier.lastErrorConnectionRemoteId;
                  return BleDeviceProps(
                    title: deviceName,
                    showConnectionError: showConnectionError,
                    state: state,
                    onPressed: () => _deviceNotifier.connect(device.device),
                  );
                }).toList();

                return Expanded(
                  child: AnimatedSwitcher(
                    duration: _switchAnimationDuration,
                    child: _scanNotifier.isScanning
                        ? const Center(
                            child: CircleProgressbar(
                              props: CircleProgressbarProps(),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(
                                horizontal: _horizontalPadding,
                                vertical: _listVerticalPadding),
                            itemBuilder: (_, pos) =>
                                BleDevice(props: devices[pos]),
                            separatorBuilder: (_, __) =>
                                const HeightSpacer(_paddingBetweenDevices),
                            itemCount: devices.length),
                  ),
                );
              }),
          ListenableBuilder(
              listenable: _scanNotifier,
              builder: (_, __) {
                return AnimatedSwitcher(
                  duration: _switchAnimationDuration,
                  child: _scanNotifier.isScanning
                      ? const PairHint()
                      : Button(
                          props: ButtonProps(
                            title: loc.bluetoothDevicesSearchButton,
                            onPressed: _scanNotifier.scan,
                            buttonStyle: ButtonStyles.byType(
                                theme, ButtonType.borderlessTextSecondary),
                          ),
                        ),
                );
              })
        ],
      ),
    );
  }
}
