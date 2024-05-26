import 'button_colors_style.dart';
import 'button_content_style.dart';
import 'button_paddings_style.dart';
import 'button_shape_style.dart';

class ButtonBaseStyle {
  const ButtonBaseStyle(
      {this.enableConcave = true,
      this.shapeStyle = const ButtonShapeStyle(),
      this.colorsStyle = const ButtonColorsStyle(),
      this.paddingStyles = const ButtonPaddingsStyle(),
      this.contentStyles = const ButtonContentStyle()});

  final bool enableConcave;
  final ButtonShapeStyle shapeStyle;
  final ButtonColorsStyle colorsStyle;
  final ButtonPaddingsStyle paddingStyles;
  final ButtonContentStyle contentStyles;
}
