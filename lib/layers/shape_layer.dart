import 'package:flutter/material.dart';
import 'package:image_editor_plus/data/layer.dart';
import 'package:image_editor_plus/data/shape_item.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/modules/shape_layer_overlay.dart';

class ShapeLayer extends StatefulWidget {
  final ShapeLayerData layerData;
  final VoidCallback? onUpdate;
  final bool editable;
  const ShapeLayer({
    super.key,
    required this.layerData,
    this.onUpdate,
    this.editable = false,
  });

  @override
  State<ShapeLayer> createState() => _ShapeLayerState();
}

class _ShapeLayerState extends State<ShapeLayer> {
  double initialSize = 0;
  double initialRotation = 0;

  @override
  Widget build(BuildContext context) {
    initialSize = widget.layerData.size;
    initialRotation = widget.layerData.rotation;

    return Positioned(
      left: widget.layerData.offset.dx,
      top: widget.layerData.offset.dy,
      child: GestureDetector(
        onTap: widget.editable
            ? () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return ShapeLayerOverlay(
                      index: layers.indexOf(widget.layerData),
                      layer: widget.layerData,
                      onUpdate: () {
                        if (widget.onUpdate != null) widget.onUpdate!();
                        setState(() {});
                      },
                    );
                  },
                );
              }
            : null,
        onScaleUpdate: widget.editable
            ? (detail) {
                if (detail.pointerCount == 1) {
                  widget.layerData.offset = Offset(
                    widget.layerData.offset.dx + detail.focalPointDelta.dx,
                    widget.layerData.offset.dy + detail.focalPointDelta.dy,
                  );
                } else if (detail.pointerCount == 2) {
                  final scaleFactor = detail.scale - 1;
                  // widget.layerData.size = initialSize + detail.scale * (detail.scale > 1 ? 1 : -1);
                  widget.layerData.size = initialSize + scaleFactor * 10;
                  // clap the size
                  if (widget.layerData.size < 10) widget.layerData.size = 10;
                  widget.layerData.rotation = detail.rotation;
                }
                setState(() {});
              }
            : null,
        child: Transform.rotate(
          angle: widget.layerData.rotation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: widget.layerData.getSizeForWidget(),
                width: widget.layerData.getSizeForWidget(),
                color: Colors.transparent,
                child: widget.layerData.shape.build(
                  color: widget.layerData.color,
                  filled: widget.layerData.filled,
                  size: widget.layerData.size,
                ),
              ),
              if (widget.layerData.shape == ShapeType.arrow)
                Container(
                  height: widget.layerData.getSizeForWidget(),
                  width: widget.layerData.getSizeForWidget(),
                  color: Colors.transparent,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
