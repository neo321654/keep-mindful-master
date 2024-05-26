import 'package:flutter/material.dart';

import '../../shared.dart';

const _shadowDistance = Offset(10.0, 10.0);
const _shadowBlur = 20.0;
const _shadowDecorationOpacity = 0.4;

class Input extends StatelessWidget {
  const Input({required this.props, super.key});

  final InputProps props;

  BoxDecoration _buildShadowDecoration(ThemeData theme) {
    final borderRadius =
        BorderRadius.circular(props.style.shapeStyle.boderRadius);

    return BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            blurRadius: _shadowBlur,
            color: theme.shadowColor.withOpacity(_shadowDecorationOpacity),
            offset: _shadowDistance,
          ),
          BoxShadow(
            blurRadius: _shadowBlur,
            color: theme.colorScheme.shadow,
            offset: -_shadowDistance,
          ),
        ]);
  }

  InputBorder _emptyBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius:
            BorderRadius.circular(props.style.shapeStyle.boderRadius));
  }

  Widget? _suffixIcon() {
    final inputStyle = props.style;

    if (props.trailingIcon == null) {
      return null;
    }
    return Padding(
      padding: inputStyle.paddingsStyle.trailingIconPadding ?? EdgeInsets.zero,
      child: props.trailingIcon!.svg(
        height: inputStyle.contentStyle.iconSize,
        width: inputStyle.contentStyle.iconSize,
        colorFilter: inputStyle.contentStyle.iconColor == null
            ? null
            : ColorFilter.mode(
                inputStyle.contentStyle.iconColor!, BlendMode.srcIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final shadowDecoration = _buildShadowDecoration(theme);

    final inputStyle = props.style;

    final suffixIcon = _suffixIcon();

    final inputDecoration = InputDecoration(
        filled: true,
        fillColor: theme.colorScheme.surface,
        hintText: props.hintText,
        isDense: true,
        contentPadding: inputStyle.paddingsStyle.padding,
        hintStyle: inputStyle.contentStyle.hintStyle,
        errorStyle: const TextStyle(height: 0.0),
        border: inputStyle.shapeStyle.border ?? _emptyBorder(),
        enabledBorder: inputStyle.shapeStyle.enabledBorder ?? _emptyBorder(),
        focusedBorder: inputStyle.shapeStyle.focusedBorder ?? _emptyBorder(),
        errorBorder: inputStyle.shapeStyle.errorBorder ?? _emptyBorder(),
        focusedErrorBorder:
            inputStyle.shapeStyle.focusedErrorBorder ?? _emptyBorder(),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 2,
          minHeight: 2,
        ),
        suffixIcon: suffixIcon);

    final maxLines = props.expands ? null : 1;

    final textField = ConstrainedBox(
      constraints:
          BoxConstraints(minWidth: props.minWidth, maxWidth: props.maxWidth),
      child: IntrinsicWidth(
        child: TextFormField(
          cursorHeight: inputStyle.contentStyle.textStyle?.fontSize,
          cursorColor: theme.colorScheme.onSurface,
          enabled: props.enabled,
          keyboardType: props.keyboardType,
          controller: props.controller,
          initialValue: props.initialValue,
          maxLength: props.maxLength,
          decoration: inputDecoration,
          onChanged: props.onChanged,
          validator: props.validator,
          maxLines: maxLines,
          expands: props.expands,
          autovalidateMode: props.autovalidateMode,
          inputFormatters: props.inputFormatters,
          style: inputStyle.contentStyle.textStyle,
          textAlign: props.textAlign,
          textCapitalization: props.textCapitalization,
        ),
      ),
    );

    if (!inputStyle.shapeStyle.enableShadow) {
      return textField;
    }

    return DecoratedBox(decoration: shadowDecoration, child: textField);
  }
}
