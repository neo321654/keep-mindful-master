import 'package:flutter/material.dart';

import '../../themes/themes.dart';
import 'src/src.dart';

enum ButtonType {
  circleIconSmall,
  circleIconMedium,
  circleIconLarge,
  rectangleText,
  rectangleIconSmall,
  rectanlgeIconSmallSecondary,
  circleTitleSubtitle,
  rectangleTextPrimary,
  borderlessTextError,
  borderlessTextSecondary
}

class ButtonStyles {
  ButtonStyles._();

  static ButtonBaseStyle byType(ThemeData theme, ButtonType type) {
    switch (type) {
      case ButtonType.circleIconSmall:
        return _circleIconSmall(theme);
      case ButtonType.circleIconMedium:
        return _circleIconMedium(theme);
      case ButtonType.circleIconLarge:
        return _circleIconLarge(theme);
      case ButtonType.rectangleText:
        return _rectangleText(theme);
      case ButtonType.rectangleIconSmall:
        return _rectangleIconSmall(theme);
      case ButtonType.rectanlgeIconSmallSecondary:
        return _rectangleIconSmallSecondary(theme);
      case ButtonType.circleTitleSubtitle:
        return _circleTitleSubtitle(theme);
      case ButtonType.rectangleTextPrimary:
        return _rectangleTextPrimary(theme);
      case ButtonType.borderlessTextError:
        return _borderlessTextError(theme);
      case ButtonType.borderlessTextSecondary:
        return _borderlessTextSecondary(theme);
    }
  }

  static ButtonBaseStyle _circleIconLarge(ThemeData theme) {
    return ButtonBaseStyle(
      shapeStyle:
          const ButtonShapeStyle(shape: BoxShape.circle, innerShadowDeph: 4.0),
      contentStyles: const ButtonContentStyle(
        iconStyle: ButtonIconStyle(
          iconSize: 30.0,
        ),
      ),
      colorsStyle: ButtonColorsStyle(
          backgroundColor: theme.colorScheme.background,
          shadowColors: [
            theme.shadowColor.withOpacity(0.6),
            theme.colorScheme.shadow,
          ]),
      paddingStyles: const ButtonPaddingsStyle(
        padding: EdgeInsets.all(16.0),
      ),
    );
  }

  static ButtonBaseStyle _circleIconMedium(ThemeData theme) {
    return ButtonBaseStyle(
      shapeStyle:
          const ButtonShapeStyle(shape: BoxShape.circle, innerShadowDeph: 4.0),
      contentStyles: ButtonContentStyle(
        iconStyle: ButtonIconStyle(primaryColor: theme.colorScheme.onSurface),
      ),
      colorsStyle: ButtonColorsStyle(
          backgroundColor: theme.colorScheme.background,
          shadowColors: [
            theme.shadowColor.withOpacity(0.6),
            theme.colorScheme.shadow,
          ]),
      paddingStyles: const ButtonPaddingsStyle(
        padding: EdgeInsets.all(14.0),
      ),
    );
  }

  static ButtonBaseStyle _circleIconSmall(ThemeData theme) {
    return ButtonBaseStyle(
      shapeStyle:
          const ButtonShapeStyle(shape: BoxShape.circle, innerShadowDeph: 4.0),
      contentStyles: ButtonContentStyle(
        iconStyle: ButtonIconStyle(
            primaryColor: theme.colorScheme.onSurface, iconSize: 18.0),
      ),
      colorsStyle: ButtonColorsStyle(
          backgroundColor: theme.colorScheme.background,
          shadowColors: [
            theme.shadowColor.withOpacity(0.6),
            theme.colorScheme.shadow,
          ]),
      paddingStyles: const ButtonPaddingsStyle(
        padding: EdgeInsets.all(12.0),
      ),
    );
  }

  static ButtonBaseStyle _rectangleText(ThemeData theme) {
    return ButtonBaseStyle(
      shapeStyle:
          const ButtonShapeStyle(innerShadowDeph: 3.0, borderRadius: 50.0),
      contentStyles: ButtonContentStyle(
          titleStyle: theme.textTheme.labelLarge
              ?.copyWith(color: theme.colorScheme.primary)),
      colorsStyle: ButtonColorsStyle(
          backgroundColor: theme.colorScheme.background,
          shadowColors: [
            theme.shadowColor.withOpacity(0.6),
            theme.colorScheme.shadow,
          ]),
      paddingStyles: const ButtonPaddingsStyle(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      ),
    );
  }

  static ButtonBaseStyle _rectangleTextPrimary(ThemeData theme) {
    final colorsExtension = theme.extension<ColorsExtension>();
    return ButtonBaseStyle(
      enableConcave: false,
      shapeStyle: const ButtonShapeStyle(
          innerShadowDeph: 3.0,
          borderRadius: 24.0,
          shadowBlurRadius: 2.0,
          shadowDistance: Offset.zero),
      contentStyles: ButtonContentStyle(
        titleStyle: theme.textTheme.labelLarge
            ?.copyWith(color: theme.colorScheme.onPrimary),
      ),
      colorsStyle: ButtonColorsStyle(
          backgroundColor: theme.colorScheme.primary,
          shadowColors: [
            colorsExtension!.primarySwatch!.shade900,
            colorsExtension.primarySwatch!.shade900,
          ]),
      paddingStyles: const ButtonPaddingsStyle(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      ),
    );
  }

  static ButtonBaseStyle _rectangleIconSmall(ThemeData theme) {
    return ButtonBaseStyle(
      shapeStyle:
          const ButtonShapeStyle(innerShadowDeph: 3.0, borderRadius: 12.0),
      contentStyles: ButtonContentStyle(
        iconStyle: ButtonIconStyle(
            primaryColor: theme.colorScheme.onSurface,
            disabledColor: theme.colorScheme.onSurface.withOpacity(0.8),
            secondaryColor: theme.colorScheme.onSurface.withOpacity(0.8),
            iconSize: 18.0),
      ),
      colorsStyle: ButtonColorsStyle(
          backgroundColor: theme.colorScheme.background,
          shadowColors: [
            theme.shadowColor.withOpacity(0.6),
            theme.colorScheme.shadow,
          ]),
      paddingStyles: const ButtonPaddingsStyle(
        padding: EdgeInsets.all(15.0),
      ),
    );
  }

  static ButtonBaseStyle _rectangleIconSmallSecondary(ThemeData theme) {
    return ButtonBaseStyle(
      shapeStyle:
          const ButtonShapeStyle(innerShadowDeph: 3.0, borderRadius: 12.0),
      contentStyles: ButtonContentStyle(
        iconStyle: ButtonIconStyle(
            primaryColor: theme.colorScheme.onSurface,
            disabledColor: theme.colorScheme.secondary,
            iconSize: 18.0),
      ),
      colorsStyle: ButtonColorsStyle(
          backgroundColor: theme.colorScheme.background,
          borderColor: theme.colorScheme.onPrimary,
          shadowColors: [
            theme.shadowColor.withOpacity(0.6),
            theme.colorScheme.shadow,
          ]),
      paddingStyles: const ButtonPaddingsStyle(
        padding: EdgeInsets.all(15.0),
      ),
    );
  }

  static ButtonBaseStyle _circleTitleSubtitle(ThemeData theme) {
    return ButtonBaseStyle(
      shapeStyle:
          const ButtonShapeStyle(innerShadowDeph: 4.0, shape: BoxShape.circle),
      contentStyles: ButtonContentStyle(
          titleStyle: theme.textTheme.bodySmall
              ?.copyWith(color: theme.colorScheme.onSurface),
          subtitleStyle: theme.textTheme.labelMedium
              ?.copyWith(color: theme.colorScheme.onSurface)),
      colorsStyle: ButtonColorsStyle(
          borderColor: theme.colorScheme.onSurface.withOpacity(0.1),
          backgroundColor: theme.colorScheme.surface,
          shadowColors: [
            theme.shadowColor.withOpacity(0.6),
            theme.colorScheme.shadow,
          ]),
      paddingStyles: const ButtonPaddingsStyle(
        padding: EdgeInsets.all(12.0),
      ),
    );
  }

  static ButtonBaseStyle _borderlessTextError(ThemeData theme) {
    return ButtonBaseStyle(
      contentStyles: ButtonContentStyle(
          titleStyle: theme.textTheme.labelLarge
              ?.copyWith(color: theme.colorScheme.error)),
      colorsStyle: ButtonColorsStyle(shadowColors: [
        theme.colorScheme.surface.withOpacity(0.0),
        theme.colorScheme.surface.withOpacity(0.0),
      ]),
      paddingStyles: const ButtonPaddingsStyle(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      ),
    );
  }

  static ButtonBaseStyle _borderlessTextSecondary(ThemeData theme) {
    return ButtonBaseStyle(
      contentStyles: ButtonContentStyle(
        titleStyle: theme.textTheme.titleLarge
            ?.copyWith(color: theme.colorScheme.secondary),
        disabledTitleStyle: theme.textTheme.titleLarge
            ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.25)),
      ),
      colorsStyle: ButtonColorsStyle(shadowColors: [
        theme.colorScheme.surface.withOpacity(0.0),
        theme.colorScheme.surface.withOpacity(0.0),
      ]),
      paddingStyles: const ButtonPaddingsStyle(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      ),
    );
  }
}
