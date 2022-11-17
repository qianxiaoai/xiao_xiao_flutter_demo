import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flow_line_delegate.dart';

///wrap 自动换行
Widget buildWrapAutoWidget(List<String> labels) {
  return Container(
      width: 200,
      height: 200,
      color: const Color(0x22880F00),
      child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 6, right: 12),
          child: Wrap(
              direction: Axis.horizontal,
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

///flutter官方demo https://api.flutter-io.cn/flutter/widgets/Wrap-class.html
Widget buildFlutterOfficialFlow() {
  return Wrap(
    spacing: 8.0, // gap between adjacent chips
    runSpacing: 4.0, // gap between lines
    children: <Widget>[
      Chip(
        avatar: CircleAvatar(
            backgroundColor: Colors.blue.shade900, child: const Text('AH')),
        label: Text('Hamilton'),
      ),
      Chip(
        avatar: CircleAvatar(
            backgroundColor: Colors.blue.shade900, child: const Text('ML')),
        label: const Text('Lafayette'),
      ),
      Chip(
        avatar: CircleAvatar(
            backgroundColor: Colors.blue.shade900, child: const Text('HM')),
        label: const Text('Mulligan'),
      ),
      Chip(
        avatar: CircleAvatar(
            backgroundColor: Colors.blue.shade900, child: const Text('JL')),
        label: const Text('Laurens'),
      ),
    ],
  );
}

/// flow 支持设置最多显示几行
Widget buildFlowMaxLineWidget(List<String> labels) {
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
            delegate: FlowLineDelegate(
              maxLine: 2,
              spacing: 4,
              runSpacing: 6,
              itemHeight: 18,
            ),
          )));
}

///flutter 官网demo
class FlowMenu extends StatefulWidget {
  const FlowMenu({Key? key}) : super(key: key);

  @override
  State<FlowMenu> createState() => _FlowMenuState();
}

class _FlowMenuState extends State<FlowMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController menuAnimation;
  IconData lastTapped = Icons.notifications;
  final List<IconData> menuItems = <IconData>[
    Icons.home,
    Icons.new_releases,
    Icons.notifications,
    Icons.settings,
    Icons.menu,
  ];

  void _updateMenu(IconData icon) {
    if (icon != Icons.menu) {
      setState(() => lastTapped = icon);
    }
  }

  @override
  void initState() {
    super.initState();
    menuAnimation = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  Widget flowMenuItem(IconData icon) {
    final double buttonDiameter =
        MediaQuery.of(context).size.width / menuItems.length;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RawMaterialButton(
        fillColor: lastTapped == icon ? Colors.amber[700] : Colors.blue,
        splashColor: Colors.amber[100],
        shape: const CircleBorder(),
        constraints: BoxConstraints.tight(Size(buttonDiameter, buttonDiameter)),
        onPressed: () {
          _updateMenu(icon);
          menuAnimation.status == AnimationStatus.completed
              ? menuAnimation.reverse()
              : menuAnimation.forward();
        },
        child: Icon(
          icon,
          color: Colors.white,
          size: 45.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(menuAnimation: menuAnimation),
      children:
          menuItems.map<Widget>((IconData icon) => flowMenuItem(icon)).toList(),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate({required this.menuAnimation})
      : super(repaint: menuAnimation);

  final Animation<double> menuAnimation;

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    return menuAnimation != oldDelegate.menuAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      dx = context.getChildSize(i)!.width * i;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          dx * menuAnimation.value,
          0,
          0,
        ),
      );
    }
  }
}
