import 'package:flutter/material.dart';
import 'package:wenku8x/service/navigation.dart';

final currentColorScheme = Theme.of(NavigationService.navigatorKey.currentContext!).colorScheme;

final readerBackgroundColor = currentColorScheme.background;

final pannelBackgroundColor = currentColorScheme.primary.withOpacity(.08);

final pannelTextColor = currentColorScheme.onBackground;

final primaryColor = currentColorScheme.primary;

final dividerColor = currentColorScheme.onBackground.withOpacity(.08);

final pannelContainerColor = currentColorScheme.surfaceVariant.withOpacity(.8);

final pannelContainerColorSelected = currentColorScheme.secondary.withOpacity(.8);
