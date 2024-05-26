import 'package:flutter/material.dart';

import '../../../../../../generated/assets.gen.dart';
import '../../../../../../generated/fonts.gen.dart';
import 'captcha.dart';

const _captchaHeight = 94.0;
const _captchaWidth = 264.0;
const _capchaBorderRadius = 16.0;

class Captcha extends StatelessWidget {
  const Captcha({required this.props, super.key});

  final CaptchaProps props;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: _captchaHeight,
      width: _captchaWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_capchaBorderRadius),
        child: GestureDetector(
          onTap: props.onRefresh,
          child: Stack(
            children: [
              Positioned.fill(
                  child:
                      Assets.images.captchaBackground.image(fit: BoxFit.cover)),
              Center(
                child: Text(
                  props.text,
                  style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontFamily: FontFamily.rampartOne,
                      letterSpacing: 10.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
