import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_loc_extension.dart';
import '../../shared/shared.dart';

const _padding = 24.0;
const _horizontalPadding = 35.0;

@RoutePage()
class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);
    return Semantics(
      label: loc.termsConditionsTitle,
      child: ColoredBox(
        color: theme.colorScheme.background,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TODO: Make title multiline
              SecondaryTopBar(
                props: SecondaryTopBarProps(title: loc.termsConditionsTitle),
              ),
              const HeightSpacer(_padding),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: Text(
                  '',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
