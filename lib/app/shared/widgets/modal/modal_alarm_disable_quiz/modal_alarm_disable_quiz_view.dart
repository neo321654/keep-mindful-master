import 'package:flutter/material.dart';

import '../../../../../l10n/app_loc_extension.dart';
import '../../../shared.dart';
import 'math_quiz/math_quiz.dart';

const _horizontalPadding = 24.0;
const _verticalPadding = 54.0;
const _elementsPadding = 36.0;
const _height = 300.0;

class ModalAlarmDisableQuiz extends StatefulWidget {
  const ModalAlarmDisableQuiz({required this.props, super.key});

  final ModalAlarmDisableQuizProps props;

  @override
  State<ModalAlarmDisableQuiz> createState() => _ModalAlarmDisableQrState();
}

class _ModalAlarmDisableQrState extends State<ModalAlarmDisableQuiz> {
  late final MathQuizGenerator _quizGenerator;

  bool _isPassed = false;
  bool _isClosable = false;

  @override
  void initState() {
    super.initState();
    _quizGenerator = MathQuizGenerator();
    _quizGenerator.getQuiz();
  }

  void _onQuizPassed() {
    if (_isPassed) {
      return;
    }
    _isPassed = true;

    setState(() {
      _isClosable = true;
    });

    WidgetsBinding.instance
        .addPostFrameCallback((_) => Navigator.of(context).pop(true));
  }

  void _onChangeToAnotherWay() {
    setState(() {
      _isClosable = true;
    });
    Navigator.of(context).pop();
    widget.props.onTryAnotherWayPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);

    final isOnTryAnotherWayEmpty = widget.props.onTryAnotherWayPressed == null;

    return PopScope(
      canPop: _isClosable,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ModalBottomOrigin(
          props: ModalBottomOriginProps(
            height: _height,
            padding: const EdgeInsets.symmetric(
                horizontal: _horizontalPadding, vertical: _verticalPadding),
            child: SeparatedColumn(
              separatorBuilder: (_, __) => const HeightSpacer(_elementsPadding),
              children: [
                Text(
                  loc.alarmDisableMathExcerciseTitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w300),
                ),
                MathQuiz(
                  props: MathQuizProps(
                    onQuizPassed: _onQuizPassed,
                    quiz: _quizGenerator.quiz!,
                    answer: _quizGenerator.answer!,
                  ),
                ),
                Center(
                  child: Button(
                    props: ButtonProps(
                      title: loc.alarmDisableAnotherWayButton,
                      onPressed: _onChangeToAnotherWay,
                      isDisabled: isOnTryAnotherWayEmpty,
                      buttonStyle: ButtonStyles.byType(
                        theme,
                        ButtonType.borderlessTextSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
