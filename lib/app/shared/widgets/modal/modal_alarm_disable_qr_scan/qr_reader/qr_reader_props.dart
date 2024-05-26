class QrReaderProps {
  const QrReaderProps({this.isConfirmed = false, this.onQrsReceived});

  final void Function(List<String?>)? onQrsReceived;
  final bool isConfirmed;
}
