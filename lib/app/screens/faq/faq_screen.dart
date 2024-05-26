import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_loc_extension.dart';
import '../../shared/shared.dart';

const _padding = 24.0;
const _horizontalPadding = 35.0;

@RoutePage()
class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);
    return Semantics(
      label: loc.faqTitle,
      child: ColoredBox(
        color: theme.colorScheme.background,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: _padding),
          child: SeparatedColumn(
            separatorBuilder: (_, __) => const HeightSpacer(_padding),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SecondaryTopBar(
                props: SecondaryTopBarProps(title: loc.faqTitle),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: ExpandablePanel(
                  props: ExpandablePanelProps(
                      title: loc.faqQuestion, body: loc.faqAnswer),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: ExpandablePanel(
                  props: ExpandablePanelProps(
                      title: loc.faqQuestion1, body: loc.faqAnswer1),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: ExpandablePanel(
                  props: ExpandablePanelProps(
                      title: loc.faqQuestion2, body: loc.faqAnswer2),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: ExpandablePanel(
                  props: ExpandablePanelProps(
                      title: loc.faqQuestion3, body: loc.faqAnswer3),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: ExpandablePanel(
                  props: ExpandablePanelProps(
                      title: loc.faqQuestion4, body: loc.faqAnswer4),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: ExpandablePanel(
                  props: ExpandablePanelProps(
                      title: loc.faqQuestion5, body: loc.faqAnswer5),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: ExpandablePanel(
                  props: ExpandablePanelProps(
                      title: loc.faqQuestion6, body: loc.faqAnswer6),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: ExpandablePanel(
                  props: ExpandablePanelProps(
                      title: loc.faqQuestion7, body: loc.faqAnswer7),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: ExpandablePanel(
                  props: ExpandablePanelProps(
                      title: loc.faqQuestion8, body: loc.faqAnswer8),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: ExpandablePanel(
                  props: ExpandablePanelProps(
                      title: loc.faqQuestion9, body: loc.faqAnswer9),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: ExpandablePanel(
                  props: ExpandablePanelProps(
                      title: loc.faqQuestion10, body: loc.faqAnswer10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
