import 'package:flutter/material.dart';

import 'secondary_top_bar_props.dart';

const _horizontalPadding = 30.0;
const _emtyBoxWidth = 40.0;
const _secondaryTopBarHeight = 76.0;

class SecondaryTopBar extends StatelessWidget implements PreferredSizeWidget {
  const SecondaryTopBar({required this.props, super.key});

  final SecondaryTopBarProps props;

  @override
  Size get preferredSize => const Size.fromHeight(_secondaryTopBarHeight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: AppBar(
        toolbarHeight: _secondaryTopBarHeight,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                props.title,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: const [
          SizedBox(
            width: _emtyBoxWidth,
          )
        ],
      ),
    );
  }
}
