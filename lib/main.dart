import 'package:flutter/material.dart';
import 'package:xiao_xiao_flutter_demo/wrap_widget.dart';

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
          buildWrapAutoWidget(labels),
          buildFlutterOfficialFlow(),
          buildFlowMaxLineWidget(labels),
          Container(height: 100,color: Colors.lightGreen, child: FlowMenu()),
        ],
      ),
    );
  }
}
