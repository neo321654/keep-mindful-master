import 'package:flutter/material.dart';

import 'src/src.dart';

enum InputType { noDecoration, decoratedText, decoratedTextIcon }

class InputStyles {
  InputStyles._();

  static InputStyle byType(ThemeData theme, InputType type) {
    switch (type) {
      case InputType.noDecoration:
        return _noDecoration(theme);
      case InputType.decoratedText:
        return _decoratedText(theme);
      case InputType.decoratedTextIcon:
        return _decoratedTextIcon(theme);
    }
  }

  static InputStyle _noDecoration(ThemeData theme) {
    return InputStyle(
        contentStyle: InputContentStyle(
          textStyle: theme.textTheme.headlineLarge?.copyWith(
              color: theme.colorScheme.onSurface, fontWeight: FontWeight.w300),
          hintStyle: theme.textTheme.headlineLarge
              ?.copyWith(color: theme.hintColor, fontWeight: FontWeight.w300),
        ),
        shapeStyle: const InputShapeStyle(enableShadow: false));
  }

  static InputStyle _decoratedText(ThemeData theme) {
    final borderRadius = BorderRadius.circular(24.0);
    return InputStyle(
      paddingsStyle: const InputPaddingsStyle(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0)),
      shapeStyle: InputShapeStyle(
        errorBorder: OutlineInputBorder(
          gapPadding: 0.0,
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: theme.colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          gapPadding: 0.0,
          borderSide: BorderSide(
            color: theme.colorScheme.error,
          ),
        ),
      ),
      contentStyle: InputContentStyle(
        textStyle: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onSurface, fontWeight: FontWeight.w300),
        hintStyle: theme.textTheme.bodySmall
            ?.copyWith(color: theme.hintColor, fontWeight: FontWeight.w300),
      ),
    );
  }

  static InputStyle _decoratedTextIcon(ThemeData theme) {
    return InputStyle(
      paddingsStyle: const InputPaddingsStyle(
          padding:
              EdgeInsets.only(left: 24.0, top: 12.0, bottom: 12.0, right: 12.0),
          trailingIconPadding: EdgeInsets.only(right: 20.0)),
      contentStyle: InputContentStyle(
          textStyle: theme.textTheme.displaySmall?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          hintStyle: theme.textTheme.displaySmall?.copyWith(
            color: theme.hintColor,
          ),
          iconSize: 16.0,
          iconColor: theme.colorScheme.onSurface),
    );
  }
}
