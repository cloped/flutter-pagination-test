// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Welcome to Flutter',
      home: MyPageState(),
    );
  }
}

class MyPageState extends StatefulWidget {
  const MyPageState({Key? key}) : super(key: key);

  @override
  _MyPageStateState createState() => _MyPageStateState();
}

class _MyPageStateState extends State<MyPageState> {
  List<String> items = [];
  bool loading = false;
  final _biggerFont = const TextStyle(fontSize: 18);
  final ScrollController _scrollController = ScrollController();

  fetch() async {
    setState(() {
      loading = true;
    });

    await Future.delayed(const Duration(milliseconds: 200));

    Iterable<WordPair> temp = generateWordPairs().take(15);
    List<String> newData = temp.map((e) => e.asString).toList();
    items.addAll(newData);

    setState(() {
      loading = false;
    });
  }

  Widget _renderHeader() {
    return Container(
      child: const Center(
        child: Text('Testando um header maior que a tela'),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.blueGrey,
      ),
      padding: const EdgeInsets.symmetric(vertical: 500),
    );
  }

  Widget _buildRow(int index) {
    return ListTile(
      title: Text(
        'Index:$index\t-\t${items[index]}',
        style: _biggerFont,
      ),
    );
  }

  Widget _buildItems(BuildContext context, int index) {
    if (index == 0) {
      return _renderHeader();
    }
    return _buildRow(index - 1);
  }

  Widget _buildSeparator(BuildContext context, int index) {
    return const Divider();
  }

  @override
  void initState() {
    super.initState();
    fetch();
    _scrollController.addListener(() {
      double position = 600 + _scrollController.position.pixels;
      double finalPosition = _scrollController.position.maxScrollExtent;
      if (!loading && position >= finalPosition) {
        fetch();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste paginação 200ms 10 itens'),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        {
          if (items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Scrollbar(
              child: ListView.separated(
                  controller: _scrollController,
                  itemBuilder: _buildItems,
                  separatorBuilder: _buildSeparator,
                  itemCount: items.length + 1),
            );
          }
        }
      }),
    );
  }
}
