import 'package:flutter/material.dart';

import '../../shared.dart';

const _buttonsBottomPadding = 22.0;
const _buttonsTopPadding = 10.0;
const _spaceBetweenItems = 40.0;
const _containerBorderRadius = 12.0;
const _shadowOffset = Offset(0.0, -10.0);
const _shadowSpreadRadius = 10.0;
const _blurRadius = 15.0;

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({required this.props, super.key});

  final BottomNavigationBarProps props;

  List<Widget> _convertToWidgets(ThemeData theme) {
    final menuItems = props.items;
    final items = <Widget>[];

    for (int pos = 0; pos < menuItems.length; pos++) {
      final isSelected = pos == props.selectedPosition;
      final item = menuItems[pos];
      items.add(
        Button(
          props: ButtonProps(
              semanticsLabel: item.semanticsLabel,
              buttonStyle:
                  ButtonStyles.byType(theme, ButtonType.rectangleIconSmall),
              onPressed: () => props.onPressed?.call(pos),
              isPressed: isSelected,
              rightIcon: menuItems[pos].icon,
              usePrimaryIconColor: isSelected),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = _convertToWidgets(theme);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.bottomAppBarTheme.color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(_containerBorderRadius),
          topRight: Radius.circular(_containerBorderRadius),
        ),
        boxShadow: [
          BoxShadow(
              color: theme.colorScheme.background,
              offset: _shadowOffset,
              spreadRadius: _shadowSpreadRadius,
              blurRadius: _blurRadius)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: _buttonsTopPadding, bottom: _buttonsBottomPadding),
        child: SeparatedRow(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items,
          separatorBuilder: (_, __) => const WidthSpacer(_spaceBetweenItems),
        ),
      ),
    );
  }
}
