import 'package:flutter/material.dart';

import 'modal_bottom_origin_props.dart';

class ModalBottomOrigin extends StatelessWidget {
  const ModalBottomOrigin({required this.props, super.key});

  final ModalBottomOriginProps props;

  @override
  Widget build(BuildContext context) {
    late final Widget child;

    if (props.enableInnerScroll) {
      child = SingleChildScrollView(
        padding: props.padding,
        child: props.child,
      );
    } else {
      child = Padding(
        padding: props.padding ?? EdgeInsets.zero,
        child: props.child,
      );
    }

    return ConstrainedBox(
        constraints: BoxConstraints.expand(height: props.height), child: child);
  }
}
