import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyCenter extends SingleChildRenderObjectWidget {
  const MyCenter({super.key, required super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMyCenter();
  }
}

class _RenderMyCenter extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints.loosen(), parentUsesSize: true);

      double dx = (constraints.maxWidth - child!.size.width) / 2;
      double dy = (constraints.maxHeight - child!.size.height) / 2;

      BoxParentData childParentData = child!.parentData as BoxParentData;
      childParentData.offset = Offset(dx, dy);

      size = constraints.biggest;
    } else {
      size = const Size(0, 0);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final parentData = child!.parentData as BoxParentData;
      context.paintChild(child!, offset + parentData.offset);
    }
  }
}
