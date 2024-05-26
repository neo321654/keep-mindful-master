import 'package:flutter/widgets.dart';

mixin SeparatorMixin {
  List<Widget> separateWidgets(BuildContext context, List<Widget> children,
      Widget Function(BuildContext context, int pos) itemBuilder) {
    List<Widget> spacedList = [];

    if (children.isEmpty) {
      return spacedList;
    }

    final lenght = children.length - 1;

    for (int pos = 0; pos <= lenght; pos++) {
      spacedList.add(children[pos]);
      if (pos < lenght) {
        spacedList.add(itemBuilder(context, pos));
      }
    }
    return spacedList;
  }
}
