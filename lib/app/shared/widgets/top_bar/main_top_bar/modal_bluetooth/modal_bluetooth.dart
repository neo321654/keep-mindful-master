import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../features/features.dart';
import '../../../modal/modal.dart';
import 'connection_fragment/connection_fragment.dart';
import 'devices_fragment/devices_fragment.dart';

class ModalBluetooth extends StatefulWidget {
  const ModalBluetooth({super.key});

  @override
  State<ModalBluetooth> createState() => _ModalBluetoothState();
}

class _ModalBluetoothState extends State<ModalBluetooth> {
  final _notifier = GetIt.instance<BluetoothAdapterStateNotifier>();

  @override
  Widget build(BuildContext context) {
    final modalHeight = MediaQuery.of(context).size.height / 2;
    return ModalBottomOrigin(
      props: ModalBottomOriginProps(
        enableInnerScroll: false,
        height: modalHeight,
        child: ListenableBuilder(
            listenable: _notifier,
            builder: (_, __) {
              if (_notifier.adapterState == BluetoothAdapterState.on) {
                return DevicesFragment();
              }

              return ConnectionFragment(
                props: ConnectionFragmentProps(
                  onPressed: _notifier.enable,
                ),
              );
            }),
      ),
    );
  }
}
