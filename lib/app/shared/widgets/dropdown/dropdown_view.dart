import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../generated/assets.gen.dart';
import '../spacer/spacer.dart';
import 'dropdown_item_props.dart';
import 'dropdown_props.dart';

const _borderRadius = 12.0;
const _horizontalPadding = 16.0;
const _verticalPadding = 10.0;
const _iconSize = 18.0;
const _titleRightPadding = 4.0;
const _outerShadowDistance = Offset(10.0, 10.0);
const _outerShadowBlur = 20.0;
const _outerDecorationOpacity = 0.4;

class Dropdown extends StatefulWidget {
  const Dropdown({required this.props, super.key});

  final DropdownProps props;

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  bool _isExpanded = false;
  DropdownItemProps? _value;
  late List<DropdownMenuItem<DropdownItemProps>> _items;

  void _onMenuStateChanged(bool isOpen) {
    setState(() {
      _isExpanded = isOpen;
    });
  }

  void _makeInit() {
    _value = widget.props.value;
    _items = widget.props.values
        .map(
          (e) => DropdownMenuItem<DropdownItemProps>(
            value: e,
            child: Text(e.title),
          ),
        )
        .toList();
  }

  @override
  void didUpdateWidget(covariant Dropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.props.value != oldWidget.props.value) {
      setState(() {
        _value = widget.props.value;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _makeInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final borderRadius = BorderRadius.circular(_borderRadius);

    final decoration = BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            blurRadius: _outerShadowBlur,
            color: theme.shadowColor.withOpacity(_outerDecorationOpacity),
            offset: _outerShadowDistance,
          ),
          BoxShadow(
            blurRadius: _outerShadowBlur,
            color: theme.colorScheme.shadow,
            offset: -_outerShadowDistance,
          ),
        ]);

    final icon =
        _isExpanded ? Assets.icons.chevronTop : Assets.icons.chevronBottom;

    return DropdownButtonHideUnderline(
      child: DropdownButton2<DropdownItemProps>(
        onMenuStateChange: _onMenuStateChanged,
        style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface, fontWeight: FontWeight.w300),
        customButton: DecoratedBox(
          decoration: decoration,
          child: SizedBox(
            width: widget.props.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: _horizontalPadding, vertical: _verticalPadding),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_value?.title ?? ''),
                    const WidthSpacer(_titleRightPadding),
                    icon.svg(
                      height: _iconSize,
                      width: _iconSize,
                      colorFilter: ColorFilter.mode(
                          theme.colorScheme.onSurface, BlendMode.srcIn),
                    )
                  ]),
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
            decoration: decoration, offset: const Offset(0.0, -10.0)),
        value: _value,
        isDense: true,
        items: _items,
        onChanged: widget.props.onChanged,
      ),
    );
  }
}
