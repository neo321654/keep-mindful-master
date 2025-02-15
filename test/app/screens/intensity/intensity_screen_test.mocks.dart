// Mocks generated by Mockito 5.4.4 from annotations
// in keep_mindful/test/app/screens/intensity/intensity_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:ui' as _i6;

import 'package:flutter_blue_plus/flutter_blue_plus.dart' as _i7;
import 'package:keep_mindful/features/bluetooth/bluetooth.dart' as _i3;
import 'package:keep_mindful/features/intensity/constants/constants.dart'
    as _i4;
import 'package:keep_mindful/features/intensity/intensity_notifier.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [IntensityNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockIntensityNotifier extends _i1.Mock implements _i2.IntensityNotifier {
  @override
  double get intensity => (super.noSuchMethod(
        Invocation.getter(#intensity),
        returnValue: 0.0,
        returnValueForMissingStub: 0.0,
      ) as double);

  @override
  _i3.NotificationType get selectedNotifyType => (super.noSuchMethod(
        Invocation.getter(#selectedNotifyType),
        returnValue: _i3.NotificationType.shock,
        returnValueForMissingStub: _i3.NotificationType.shock,
      ) as _i3.NotificationType);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  void setMode(_i4.IntensityMode? mode) => super.noSuchMethod(
        Invocation.method(
          #setMode,
          [mode],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void updateSelectedType(_i3.NotificationType? selectedNotifyType) =>
      super.noSuchMethod(
        Invocation.method(
          #updateSelectedType,
          [selectedNotifyType],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void updateIntensity(double? intensity) => super.noSuchMethod(
        Invocation.method(
          #updateIntensity,
          [intensity],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.Future<void> resetIntensity() => (super.noSuchMethod(
        Invocation.method(
          #resetIntensity,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> checkIntensity() => (super.noSuchMethod(
        Invocation.method(
          #checkIntensity,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  void updateDevice(_i3.KeepMindfulDevice? device) => super.noSuchMethod(
        Invocation.method(
          #updateDevice,
          [device],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addListener(_i6.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i6.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [BluetoothDeviceStateNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockBluetoothDeviceStateNotifier extends _i1.Mock
    implements _i3.BluetoothDeviceStateNotifier {
  @override
  _i3.BleDeviceConnectionState get connectionState => (super.noSuchMethod(
        Invocation.getter(#connectionState),
        returnValue: _i3.BleDeviceConnectionState.connected,
        returnValueForMissingStub: _i3.BleDeviceConnectionState.connected,
      ) as _i3.BleDeviceConnectionState);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i5.Future<void> reconnect() => (super.noSuchMethod(
        Invocation.method(
          #reconnect,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> connect(_i7.BluetoothDevice? selectedDevice) =>
      (super.noSuchMethod(
        Invocation.method(
          #connect,
          [selectedDevice],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  void addListener(_i6.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i6.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
