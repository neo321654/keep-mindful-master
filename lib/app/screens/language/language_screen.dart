import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../features/features.dart';
import '../../../l10n/app_loc_extension.dart';
import '../../shared/shared.dart';

const _padding = 24.0;
const _tilePadding = EdgeInsets.symmetric(horizontal: 30.0);
const _tileInnerPadding =
    EdgeInsets.only(left: 24.0, bottom: 5.0, top: 5.0, right: 10.0);

@RoutePage()
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final _languageNotifier = GetIt.instance<AppLanguageNotifier>();

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);

    return Semantics(
      label: loc.languageTitle,
      child: ColoredBox(
        color: theme.colorScheme.background,
        child: ListenableBuilder(
            listenable: _languageNotifier,
            builder: (_, __) {
              return SeparatedColumn(
                separatorBuilder: (_, __) => const HeightSpacer(_padding),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SecondaryTopBar(
                    props: SecondaryTopBarProps(title: loc.languageTitle),
                  ),
                  ...AppLanguages.supportedLanguages
                      .map((lang) => Padding(
                            padding: _tilePadding,
                            child: SelectableListTile(
                              props: SelectableListTileProps(
                                padding: _tileInnerPadding,
                                title: lang.name,
                                onPressed: () =>
                                    _languageNotifier.updateLanguage(lang),
                                trailing: RadioBox(
                                  props: RadioBoxProps(
                                      value: lang,
                                      groupValue: _languageNotifier.language,
                                      onPressed: (_) => _languageNotifier
                                          .updateLanguage(lang)),
                                ),
                              ),
                            ),
                          ))
                      .toList()
                ],
              );
            }),
      ),
    );
  }
}
