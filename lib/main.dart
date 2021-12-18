// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/services.dart';
import 'package:my_app/list_items.dart';
import 'package:flutter/cupertino.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(0, 0, 0, 0),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Welcome to Flutter',
      home: ListItems(),
    );
  }
}
