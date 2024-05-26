import 'package:flutter/material.dart';

import '../../../../generated/assets.gen.dart';
import '../concave_decoration.dart';
import '../spacer/spacer.dart';
import 'src/src.dart';

const _animationDuration = Duration(milliseconds: 100);
const _titlePaddingBottom = 2.0;

class Button extends StatefulWidget {
  const Button({required this.props, super.key});

  final ButtonProps props;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  late bool _isPressed;

  @override
  void initState() {
    super.initState();

    _isPressed = widget.props.isPressed ?? false;
  }

  void _onPressed(bool isPressed) {
    if (widget.props.isDisabled) {
      return;
    }

    if (widget.props.onPressed == null) {
      return;
    }

    if (isPressed) {
      widget.props.onPressed!.call();
    }

    if (widget.props.isPressed != null) {
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _isPressed = isPressed;
    });
  }

  @override
  void didUpdateWidget(covariant Button oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.props.isPressed != oldWidget.props.isPressed) {
      setState(() {
        _isPressed = widget.props.isPressed ?? false;
      });
    }
  }

  Decoration _buildInnerDecorationShape() {
    final buttonStyle = widget.props.buttonStyle;

    final border = buttonStyle.colorsStyle.borderColor == null
        ? BorderSide.none
        : BorderSide(color: buttonStyle.colorsStyle.borderColor!);

    final shape = buttonStyle.shapeStyle.shape == BoxShape.circle
        ? const CircleBorder()
        : RoundedRectangleBorder(
            side: border,
            borderRadius:
                BorderRadius.circular(buttonStyle.shapeStyle.borderRadius));

    return ConcaveDecoration(
      depth: buttonStyle.shapeStyle.innerShadowDeph,
      colors: buttonStyle.colorsStyle.shadowColors.reversed.toList(),
      shape: shape,
    );
  }

  Decoration _buildOuterDecorationShape() {
    final buttonStyle = widget.props.buttonStyle;

    final borderRadius = buttonStyle.shapeStyle.shape == BoxShape.circle
        ? null
        : BorderRadius.circular(buttonStyle.shapeStyle.borderRadius);

    final border = buttonStyle.colorsStyle.borderColor == null
        ? null
        : Border.all(color: buttonStyle.colorsStyle.borderColor!);

    return BoxDecoration(
        color: buttonStyle.colorsStyle.backgroundColor,
        shape: buttonStyle.shapeStyle.shape,
        borderRadius: borderRadius,
        border: border,
        boxShadow: [
          BoxShadow(
            blurRadius: buttonStyle.shapeStyle.shadowBlurRadius,
            color: buttonStyle.colorsStyle.shadowColors.first,
            offset: buttonStyle.shapeStyle.shadowDistance,
          ),
          BoxShadow(
            blurRadius: buttonStyle.shapeStyle.shadowBlurRadius,
            color: buttonStyle.colorsStyle.shadowColors.last,
            offset: -buttonStyle.shapeStyle.shadowDistance,
          ),
        ]);
  }

  Decoration? _buildDecoration(BuildContext context) {
    final props = widget.props;

    if (props.isDisabled) {
      return null;
    }

    final outerDecoration = _buildOuterDecorationShape();

    if (!props.buttonStyle.enableConcave) {
      return outerDecoration;
    }

    final innerDecoration = _buildInnerDecorationShape();

    return _isPressed ? innerDecoration : outerDecoration;
  }

  Widget _attachIconStyle(SvgGenImage icon) {
    final props = widget.props;
    final style = props.buttonStyle.contentStyles.iconStyle;

    Color? color = style.primaryColor;

    if (props.isDisabled && style.disabledColor != null) {
      color = style.disabledColor;
    }

    if (!props.usePrimaryIconColor && style.secondaryColor != null) {
      color = style.secondaryColor;
    }

    return SizedBox(
      height: style.iconSize,
      width: style.iconSize,
      child: icon.svg(
          colorFilter:
              color == null ? null : ColorFilter.mode(color, BlendMode.srcIn)),
    );
  }

  Widget? _getTextsWidget() {
    final props = widget.props;
    if (props.title == null && props.subtitle == null) {
      return null;
    }

    final contentStyles = props.buttonStyle.contentStyles;

    final titleStyle = props.isDisabled
        ? contentStyles.disabledTitleStyle ?? contentStyles.titleStyle
        : contentStyles.titleStyle;

    final subTitleStyle = props.isDisabled
        ? contentStyles.disabledSubtitleStyle ?? contentStyles.subtitleStyle
        : contentStyles.subtitleStyle;

    if (props.title == null) {
      return Text(
        props.subtitle!,
        style: subTitleStyle,
      );
    }
    if (props.subtitle == null) {
      return Text(
        props.title!,
        style: titleStyle,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          props.title!,
          style: titleStyle,
        ),
        const HeightSpacer(_titlePaddingBottom),
        Text(
          props.subtitle!,
          style: subTitleStyle,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final props = widget.props;
    final style = props.buttonStyle;

    final decoration = _buildDecoration(context);

    final children = <Widget>[];

    if (props.leftIcon != null) {
      children.add(
        Padding(
          padding: EdgeInsets.only(
            right: style.paddingStyles.paddingBetweenElements,
          ),
          child: _attachIconStyle(props.leftIcon!),
        ),
      );
    }

    final textWidgets = _getTextsWidget();

    if (textWidgets != null) {
      children.add(textWidgets);
    }

    if (props.rightIcon != null) {
      children.add(
        Padding(
          padding: EdgeInsets.only(
            left: style.paddingStyles.paddingBetweenElements,
          ),
          child: _attachIconStyle(props.rightIcon!),
        ),
      );
    }

    return Semantics(
      button: true,
      label: props.title ?? props.semanticsLabel ?? 'Button',
      excludeSemantics: true,
      onTap: () {
        _onPressed(true);
        _onPressed(false);
      },
      child: Listener(
        onPointerUp: (_) => _onPressed(false),
        onPointerDown: (_) => _onPressed(true),
        child: AnimatedContainer(
          padding: style.paddingStyles.padding,
          duration: _animationDuration,
          decoration: decoration,
          child: Row(
            mainAxisAlignment: style.contentStyles.contentAlignment,
            mainAxisSize: style.contentStyles.contentExpand
                ? MainAxisSize.max
                : MainAxisSize.min,
            children: children,
          ),
        ),
      ),
    );
  }
}
