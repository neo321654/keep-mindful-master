import 'input_content_style.dart';
import 'input_paddings_style.dart';
import 'input_shape_style.dart';

class InputStyle {
  const InputStyle({
    this.contentStyle = const InputContentStyle(),
    this.paddingsStyle = const InputPaddingsStyle(),
    this.shapeStyle = const InputShapeStyle(),
  });
  
  final InputContentStyle contentStyle;
  final InputPaddingsStyle paddingsStyle;
  final InputShapeStyle shapeStyle;
}
