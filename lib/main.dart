import 'package:flutter/material.dart';
import 'package:xiao_xiao_flutter_demo/wrap_line_delegate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XiaoXiao Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'XiaoXiao Demo Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var labels = [
      '标签1号标签1号',
      '你的小可爱出没',
      '呦呦呦~',
      '我是谁我在哪哈哈哈',
      '你的小可爱又来了',
      '呵呵哈哈哈哈哈哈哈',
      '就是这么开心~'
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(height: 20),
          _buildWrapAutoWidget(labels),
          _buildFlowMaxLineWidget(labels),
        ],
      ),
    );
  }

  Widget _buildWrapAutoWidget(List<String> labels) {
    return Container(
        width: 200,
        height: 200,
        color: const Color(0x22880F00),
        child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 6, right: 12),
            child: Wrap(
                clipBehavior: Clip.hardEdge,
                spacing: 4,
                runSpacing: 6,
                children: labels
                    .map<Widget>((str) => Container(
                        decoration: const BoxDecoration(
                            color: Color(0XFFF9f6EF),
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 2, top: 1, right: 2, bottom: 1),
                            child: Text(
                              str,
                              style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF685B51)),
                            ))))
                    .toList())));
  }

  Widget _buildFlowMaxLineWidget(List<String> labels) {
    return Container(
        width: 200,
        height: 200,
        color: const Color(0x22FF00FF),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Flow(
              children: labels
                  .map<Widget>((tag) => Container(
                      height: 16,
                      decoration: const BoxDecoration(
                          color: Color(0XFFF9f6EF),
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                      child: Padding(
                          padding: const EdgeInsets.only(
                            left: 2,
                            top: 1,
                            bottom: 1,
                            right: 2,
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF685B51)),
                          ))))
                  .toList(),
              delegate: WrapLineDelegate(
                maxLine: 2,
                spacing: 4,
                runSpacing: 6,
                itemHeight: 18,
              ),
            )));
  }
}
