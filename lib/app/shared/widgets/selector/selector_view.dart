import 'package:flutter/material.dart';

import '../concave_decoration.dart';
import '../separated/separated.dart';
import '../spacer/spacer.dart';
import 'selectable_item/selectable_item.dart';
import 'selector_props.dart';

const _padding = 10.0;
const _borderRadius = 24.0;
const _concaveDepth = 5.0;

class Selector extends StatelessWidget {
  const Selector({required this.props, super.key});

  final SelectorProps props;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final items = props.items.map((item) {
      return SelectableItem(
          props: SelectableItemProps(
              value: item.value,
              title: item.title,
              groupValue: props.groupValue,
              onPressed: props.onPressed));
    }).toList();

    return DecoratedBox(
        decoration: ConcaveDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_borderRadius)),
            depth: _concaveDepth,
            colors: [
              theme.colorScheme.shadow,
              theme.shadowColor,
            ]),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(_padding),
          scrollDirection: Axis.horizontal,
          child: SeparatedRow(
            children: items,
            separatorBuilder: (_, __) => const WidthSpacer(_padding),
          ),
        ));
  }
}
