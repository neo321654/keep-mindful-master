class ModalAlarmDisabelQrScanProps {
  const ModalAlarmDisabelQrScanProps(
      {required this.qr, this.onTryAnotherWayPressed});

  final String qr;
  final void Function()? onTryAnotherWayPressed;
}
