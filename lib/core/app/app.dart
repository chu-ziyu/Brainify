import 'package:brainify/core/app/theme_provider.dart';
import 'package:brainify/core/navigation/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Brainify extends ConsumerWidget {
  const Brainify({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    
    return MaterialApp.router(
      title: 'Brainify',
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
