import '../../../../../generated/assets.gen.dart';
import 'button_base_style.dart';

class ButtonProps {
  const ButtonProps(
      {this.isDisabled = false,
      this.onPressed,
      this.isPressed,
      this.title,
      this.subtitle,
      this.leftIcon,
      this.rightIcon,
      this.usePrimaryIconColor = true,
      this.semanticsLabel,
      required this.buttonStyle})
      : assert(title != null || leftIcon != null || rightIcon != null,
            'Provide at least one child widget');
  final String? semanticsLabel;
  final bool isDisabled;
  final void Function()? onPressed;
  final bool? isPressed;
  final String? title;
  final String? subtitle;
  final SvgGenImage? leftIcon;
  final SvgGenImage? rightIcon;
  final ButtonBaseStyle buttonStyle;
  final bool usePrimaryIconColor;
}
