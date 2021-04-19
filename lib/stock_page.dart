import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:flutter_scroll_test/axis_widget.dart';

class StocksPage extends StatefulWidget {
  final Size size;

  const StocksPage({Key? key, required this.size}) : super(key: key);

  @override
  _StocksPageState createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  late final ScrollController scrollController;
  late final double scrollThreshold;
  late double width;
  late bool expanded;

  @override
  void initState() {
    super.initState();
    expanded = false;
    width = widget.size.width * 2;
    scrollThreshold = Math.max(widget.size.width / 5, 200);
    scrollController = ScrollController();
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      // debugPrint('maxScroll:$maxScroll, currentScroll:$currentScroll');
      if (maxScroll - currentScroll <= scrollThreshold) {
        // debugPrint('Need to expand!');
        setState(() {
          width += widget.size.width;
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
                      //   decoration: BoxDecoration(
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
                        height: 500,
                        width: width,
                        child: AxisWidget(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 500,
                width: 50,
                color: Colors.green,
              ),
            ],
          );
        },
      ),
    );
  }
}
