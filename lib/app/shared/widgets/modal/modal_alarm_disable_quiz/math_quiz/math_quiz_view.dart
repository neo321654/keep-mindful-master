import 'package:flutter/material.dart';

import '../../../../../../l10n/app_loc_extension.dart';
import '../../../../shared.dart';
import 'math_quiz_props.dart';

const _spaceBetweenElements = 10.0;

class MathQuiz extends StatelessWidget {
  const MathQuiz({required this.props, super.key});

  final MathQuizProps props;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${props.quiz}=',
          style: theme.textTheme.displaySmall
              ?.copyWith(color: theme.colorScheme.onSurface),
        ),
        const WidthSpacer(_spaceBetweenElements),
        Input(
          props: InputProps(
            maxWidth: 100.0,
            keyboardType: TextInputType.number,
            hintText: context.loc.alarmDisableMathExcerciseInputHint,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              if (val != props.answer) {
                return '';
              }
              FocusScope.of(context).requestFocus(FocusNode());
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                props.onQuizPassed?.call();
              });
              return null;
            },
            style: InputStyles.byType(
              theme,
              InputType.decoratedText,
            ),
          ),
        ),
      ],
    );
  }
}
