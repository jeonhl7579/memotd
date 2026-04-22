import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memotd/core/database/app_database.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'core/router/app_router.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final dbFolder = await getApplicationDocumentsDirectory();
  // final file = File(p.join(dbFolder.path, 'app.db'));
  // if (await file.exists()) {
  //   await file.delete();
  // }
  runApp(const ProviderScope(child: MemotdApp()));
}

class MemotdApp extends ConsumerWidget {
  const MemotdApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Memotd',
      localizationsDelegates: [FlutterQuillLocalizations.delegate],
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
