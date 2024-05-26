import 'package:flutter/material.dart';

import '../../../../../l10n/app_loc_extension.dart';
import '../../../shared.dart';
import 'captcha/captcha.dart';

const _horizontalPadding = 24.0;
const _verticalPadding = 54.0;
const _elementsPadding = 36.0;
const _height = 400.0;
const _inputWidth = 300.0;

class ModalAlarmDisableCaptcha extends StatefulWidget {
  const ModalAlarmDisableCaptcha({required this.props, super.key});

  final ModalAlarmDisableCaptchaProps props;

  @override
  State<ModalAlarmDisableCaptcha> createState() => _ModalAlarmDisableQrState();
}

class _ModalAlarmDisableQrState extends State<ModalAlarmDisableCaptcha> {
  final _captchaFormKey = GlobalKey<FormState>();
  final _captchaGenerator = CaptchaWordGenerator();

  late final ValueNotifier<String> _captchaWordNotifier;

  bool _isClosable = false;

  void _onInputChanged(String value) {
    if (_captchaFormKey.currentState?.validate() != true) {
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
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

  void _onRefresh() {
    final word = _captchaGenerator.generateRandomText();
    _captchaWordNotifier.value = word;
  }

  @override
  void initState() {
    super.initState();
    final word = _captchaGenerator.generateRandomText();
    _captchaWordNotifier = ValueNotifier(word);
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
            child: Form(
              key: _captchaFormKey,
              child: SeparatedColumn(
                separatorBuilder: (_, __) =>
                    const HeightSpacer(_elementsPadding),
                children: [
                  Text(
                    loc.alarmDisableMathExcerciseTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w300),
                  ),
                  ValueListenableBuilder(
                      valueListenable: _captchaWordNotifier,
                      builder: (_, value, __) {
                        return Captcha(
                          props:
                              CaptchaProps(onRefresh: _onRefresh, text: value),
                        );
                      }),
                  Input(
                    props: InputProps(
                      minWidth: _inputWidth,
                      maxWidth: _inputWidth,
                      keyboardType: TextInputType.text,
                      hintText: context.loc.captchaInputHint,
                      textAlign: TextAlign.center,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: _onInputChanged,
                      validator: (value) {
                        if (value?.toLowerCase() !=
                            _captchaWordNotifier.value.toLowerCase()) {
                          return '';
                        }
                        return null;
                      },
                      style: InputStyles.byType(
                        theme,
                        InputType.decoratedText,
                      ),
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
      ),
    );
  }
}
