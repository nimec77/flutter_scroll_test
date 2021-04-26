import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_scroll_test/domain/entities/timeline_paint_data.dart';
import 'package:flutter_scroll_test/domain/entities/volume_paint_data.dart';
import 'package:flutter_scroll_test/domain/entities/volume_range.dart';
import 'package:flutter_scroll_test/domain/enums/stock_interval.dart';
import 'package:flutter_scroll_test/presentation/widgets/constants.dart';

import '../widgets/axis_x_widget.dart';
import '../widgets/axis_y_widget.dart';

class StocksPage extends StatefulWidget {
  final double height;
  final double width;

  const StocksPage({Key? key, required this.height, required this.width}) : super(key: key);

  @override
  _StocksPageState createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  late final ScrollController scrollController;
  late final double scrollThreshold;
  late double width;
  late TimelinePaintData timelinePaintData;
  late VolumePaintData volumePaintData;
  late bool showPrice;
  late Offset position;
  late Size size;

  @override
  void initState() {
    super.initState();
    showPrice = false;
    position = Offset.zero;
    size = Size.zero;
    width = widget.width * 2;
    timelinePaintData = TimelinePaintData(
      startTime: DateTime.utc(2021, 4, 23, 16, 32),
      stockInterval: StockInterval.fifteenMin,
      width: width,
    );
    volumePaintData = VolumePaintData(
      volumeRange: const VolumeRange(minVolume: 76833, maxVolume: 77730),
      height: widget.height,
    );
    scrollThreshold = math.max(widget.width / 5, 200);
    scrollController = ScrollController();
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      if (maxScroll - currentScroll <= scrollThreshold) {
        setState(() {
          width += widget.width;
          timelinePaintData = TimelinePaintData(
            startTime: DateTime.utc(2021, 4, 23, 16, 32),
            stockInterval: StockInterval.fifteenMin,
            width: width,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constrains) {
          return Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  controller: scrollController,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: widget.height,
                        width: width,
                        child: GestureDetector(
                          onDoubleTap: () {
                            setState(() {
                              showPrice = !showPrice;
                              debugPrint('Showing ${showPrice ? "On" : "Off"}');
                            });
                          },
                          onPanStart: showPrice
                              ? (details) {
                                  debugPrint('Pan start');
                                  setState(() {
                                    final box = context.findRenderObject()! as RenderBox;
                                    size = box.size;
                                    position = details.globalPosition;
                                    debugPrint(position.toString());
                                  });
                                }
                              : null,
                          onPanUpdate: showPrice
                              ? (details) {
                                  setState(() {
                                    final box = context.findRenderObject()! as RenderBox;
                                    size = box.size;
                                    position = details.globalPosition;
                                    debugPrint('global:$position, size:$size');
                                  });
                                }
                              : null,
                          // onPanEnd: (details) {
                          //   debugPrint('Pan end');
                          //   // setState(() {
                          //   //   showPrice = false;
                          //   // });
                          // },
                          child: AxisXWidget(timelinePaintData: timelinePaintData, volumePaintData: volumePaintData),
                        ),
                      ),
                      if (showPrice)
                        Positioned(
                          // TODO: я не знаю откуда эти магические цифры
                          // TODO: разобраться с координатами x при прокрутки
                          top: position.dy - 55,
                          right: size.width - position.dx - 115,
                          height: 100,
                          width: 100,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: widget.height,
                width: kIndentationX,
                child: AxisYWidget(volumePaintData: volumePaintData),
              ),
            ],
          );
        },
      ),
    );
  }
}
