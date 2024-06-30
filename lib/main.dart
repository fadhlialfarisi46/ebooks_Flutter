import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:get/get.dart';

import 'app/common/constant.dart';
import 'app/data/model/author.dart';
import 'app/data/model/book.dart';
import 'app/data/model/formats.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

Future<void> _initHive() async {
  var appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(BookAdapter());
  Hive.registerAdapter(AuthorAdapter());
  Hive.registerAdapter(FormatsAdapter());

  Hive.openBox<Book>(tableBook);
}
