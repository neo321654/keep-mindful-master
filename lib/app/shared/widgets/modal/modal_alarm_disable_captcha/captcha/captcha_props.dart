class CaptchaProps {
  const CaptchaProps({this.onRefresh, required this.text});
  final void Function()? onRefresh;
  final String text;
}
