import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_scroll_test/domain/entities/volume_paint_data.dart';
import 'package:flutter_scroll_test/domain/entities/volume_range.dart';
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
  late VolumePaintData volumePaintData;

  @override
  void initState() {
    super.initState();
    volumePaintData = VolumePaintData(
      volumeRange: const VolumeRange(minVolume: 227.09, maxVolume: 230.26),
      height: widget.height,
    );
    width = widget.width * 2;
    scrollThreshold = math.max(widget.width / 5, 200);
    scrollController = ScrollController();
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      // debugPrint('maxScroll:$maxScroll, currentScroll:$currentScroll');
      if (maxScroll - currentScroll <= scrollThreshold) {
        // debugPrint('Need to expand!');
        setState(() {
          width += widget.width;
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
    final size = MediaQuery.of(context).size;
    debugPrint(size.toString());
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
                      // Container(
                      //   height: 500,
                      //   width: width,
                      //   decoration: const BoxDecoration(
                      //     gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, colors: [
                      //       Colors.red,
                      //       Colors.orange,
                      //       Colors.yellow,
                      //       Colors.green,
                      //       Colors.lightBlue,
                      //       Colors.blue,
                      //       Colors.purple,
                      //     ]),
                      //   ),
                      // ),
                      SizedBox(
                        height: widget.height,
                        width: width,
                        child: AxisXWidget(),
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
