import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_scroll_test/domain/entities/timeline_paint_data.dart';
import 'package:flutter_scroll_test/domain/entities/volume_paint_data.dart';
import 'package:flutter_scroll_test/domain/entities/volume_range.dart';
import 'package:flutter_scroll_test/domain/enums/stock_interval.dart';
import 'package:flutter_scroll_test/presentation/constants.dart';
import 'package:flutter_scroll_test/presentation/widgets/price_widget.dart';

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

  @override
  void initState() {
    super.initState();
    showPrice = true;
    width = widget.width * 2;
    timelinePaintData = TimelinePaintData(
      startTime: DateTime.utc(2021, 4, 23, 16, 32),
      stockInterval: StockInterval.oneMin,
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
            stockInterval: StockInterval.oneMin,
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
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollStartNotification) {
                      setState(() {
                        showPrice = false;
                      });
                    } else if (scrollNotification is ScrollEndNotification) {
                      setState(() {
                        showPrice = true;
                      });
                    }
                    return true;
                  },
                  child: SingleChildScrollView(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    controller: scrollController,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: widget.height,
                          width: width,
                          child: AxisXWidget(timelinePaintData: timelinePaintData, volumePaintData: volumePaintData),
                        ),
                        if (showPrice)
                          SizedBox(
                            height: widget.height,
                            width: width,
                            child: PriceWidget(timelinePaintData: timelinePaintData, volumePaintData: volumePaintData),
                          ),
                      ],
                    ),
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
