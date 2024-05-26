import 'package:flutter/material.dart';

import '../generated/l10n.dart';

extension AppLocExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}
