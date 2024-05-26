import '../../../features/features.dart';

class AlarmDisableHandler {
  AlarmDisableHandler({this.onAlarmConfirmed, this.showDialog});

  final void Function()? onAlarmConfirmed;
  final void Function(AlarmDisableMode mode, bool hasNextDialog)? showDialog;

  bool _isDialogOpened = false;
  AlarmDisableMode? _lastMode;

  void onAlarmTriggered(
      {bool isWaitingForConfirm = false,
      List<AlarmDisableMode> modes = const []}) {
    if (_isDialogOpened) {
      return;
    }
    if (!isWaitingForConfirm) {
      return;
    }
    if (modes.isEmpty) {
      onAlarmConfirmed?.call();
      return;
    }

    _isDialogOpened = true;
    openDialog(modes);
  }

  void openDialog(List<AlarmDisableMode> modes) {
    final isMoreThanOne = modes.length > 1;

    if (_lastMode == null) {
      _lastMode = modes[0];
      showDialog?.call(_lastMode!, isMoreThanOne);
      return;
    }

    final currentModePos = modes.indexOf(_lastMode!) + 1;

    if (currentModePos > modes.length - 1) {
      _lastMode = modes[0];
      showDialog?.call(_lastMode!, isMoreThanOne);
      return;
    }
    _lastMode = modes[currentModePos];
    showDialog?.call(_lastMode!, isMoreThanOne);
  }

  void onModalClosed(bool? isConfirmed) {
    if (isConfirmed == null || !isConfirmed) {
      return;
    }

    _isDialogOpened = false;
    _lastMode = null;
    onAlarmConfirmed?.call();
  }
}
