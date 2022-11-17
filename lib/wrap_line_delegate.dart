import 'package:flutter/cupertino.dart';

/// max line delegate。支持设置最多显示几行。需要指定单行高度。
class WrapLineDelegate extends FlowDelegate {
  WrapLineDelegate({
    this.maxLine = 0,
    this.spacing = 0,
    this.runSpacing = 0,
    required this.itemHeight,
    this.line = 0,
    this.lineMaxLength = 0,
  });

  final int maxLine;
  final double spacing;
  final double runSpacing;
  final double itemHeight;
  final int line;
  final int lineMaxLength;

  @override
  void paintChildren(FlowPaintingContext context) {
    // horizontal maximum width
    var screenW = context.size.width;

    double offsetX = 0; // x坐标
    double offsetY = 0; // y坐标

    int nowLine = 1;
    int lineLength = 0;

    for (int i = 0; i < context.childCount; i++) {
      // 如果当前x加子控件的宽度小于最大宽度，则继续绘制，否则换行
      if (offsetX + (context.getChildSize(i)?.width ?? 0) <= screenW &&
          getLineLimit(lineLength)) {
        // paint child
        context.paintChild(i,
            transform: Matrix4.translationValues(offsetX, offsetY, 0));
        // update x
        offsetX = offsetX + (context.getChildSize(i)?.width ?? 0) + spacing;
        lineLength++;
      } else {
        // next line
        nowLine++;
        lineLength = 0;

        if (maxLine != 0 && nowLine > maxLine) {
          break;
        } else {
          // reset the x to 0

          offsetX = 0;
          // Calculate the value of the y after a newline

          offsetY = offsetY + itemHeight + runSpacing;
          // paint child
          context.paintChild(i,
              transform: Matrix4.translationValues(offsetX, offsetY, 0));
          // update x
          offsetX = offsetX + (context.getChildSize(i)?.width ?? 0) + spacing;
        }
      }
    }
  }

  bool getLineLimit(int lineLength) {
    if (lineMaxLength == 0) {
      return true;
    }
    if (lineLength >= lineMaxLength) {
      return false;
    } else {
      return true;
    }
  }

  ///当前行能否绘制下折行
  bool canAddToFoldWidget(int i, double offsetX, double screenW,
      FlowPaintingContext context, int lastIndex) {
    if ((offsetX +
            (context.getChildSize(i)?.width ?? 0) +
            spacing +
            (context.getChildSize(lastIndex)?.width ?? 0)) <=
        screenW) {
      return true;
    }
    return false;
  }

  double toMaxHeight(double oldMaxHeight, newMaxHeight) {
    if (oldMaxHeight > newMaxHeight) {
      return oldMaxHeight;
    } else {
      return newMaxHeight;
    }
  }

  double getFoldWidgetOffsetX(
      double foldWidgetWidth, double offsetX, double screenWidth) {
    return offsetX;
  }

  @override
  Size getSize(BoxConstraints constraints) {
    int kLine = line;
    if (maxLine != 0 && line > maxLine) {
      kLine = maxLine;
    }
    return Size(
        constraints.maxWidth, itemHeight * kLine + runSpacing * (kLine - 1));
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints(
        maxWidth: constraints.maxWidth,
        minWidth: 0,
        maxHeight: itemHeight,
        minHeight: 0);
  }

  @override
  bool shouldRepaint(covariant WrapLineDelegate oldDelegate) {
    if (line != oldDelegate.line) {
      return true;
    }
    return false;
  }

  @override
  bool shouldRelayout(covariant WrapLineDelegate oldDelegate) {
    return (line != oldDelegate.line);
  }
}
