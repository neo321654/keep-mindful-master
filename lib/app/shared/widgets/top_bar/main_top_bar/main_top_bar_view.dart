import 'package:flutter/material.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../l10n/app_loc_extension.dart';
import '../../button/button.dart';
import '../../dropdown/dropdown.dart';
import 'battery_indicator.dart';
import 'main_top_bar_props.dart';
import 'modal_bluetooth/modal_bluetooth.dart';

const _containerBorderRadius = 12.0;
const _horizontalPadding = 30.0;
const _containerHeight = 110.0;
const _topPadding = 20.0;
const _bottomPadding = 10.0;
const _shadowOffset = Offset(0.0, 10.0);
const _shadowSpreadRadius = 10.0;
const _blurRadius = 15.0;

class MainTopBar extends StatelessWidget implements PreferredSizeWidget {
  const MainTopBar({required this.props, super.key});

  final MainTopBarProps props;
  @override
  Size get preferredSize => const Size.fromHeight(_containerHeight);

  void _onBluetoothTapped(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) => const ModalBluetooth(),
    );
  }

  void _onMenuItemPressed(DropdownItemProps? item) {
    if (item == null) {
      return;
    }
    final pos = props.menuItems.indexOf(item);
    props.onMenuItemPressed?.call(pos);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final topInset = MediaQuery.of(context).viewPadding.top;

    final children = <Widget>[
      const BatteryIndicator(),
    ];

    if (props.menuItems.isNotEmpty) {
      final selectedItem = props.selectedMenuItemPosition == null
          ? null
          : props.menuItems[props.selectedMenuItemPosition!];

      children.add(Dropdown(
          props: DropdownProps(
              width: props.menuWidth,
              values: props.menuItems,
              value: selectedItem,
              onChanged: _onMenuItemPressed)));
    }

    children.add(
      Button(
        props: ButtonProps(
          semanticsLabel: context.loc.bluetoothSemanticsLabel,
          onPressed: () => _onBluetoothTapped(context),
          leftIcon: Assets.icons.bluetooth,
          buttonStyle: ButtonStyles.byType(theme, ButtonType.circleIconSmall),
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.only(top: topInset),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.appBarTheme.backgroundColor,
          boxShadow: [
            BoxShadow(
                color: theme.colorScheme.background,
                offset: _shadowOffset,
                spreadRadius: _shadowSpreadRadius,
                blurRadius: _blurRadius)
          ],
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(_containerBorderRadius),
              bottomLeft: Radius.circular(_containerBorderRadius)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(_horizontalPadding, _topPadding,
              _horizontalPadding, _bottomPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          ),
        ),
      ),
    );
  }
}
