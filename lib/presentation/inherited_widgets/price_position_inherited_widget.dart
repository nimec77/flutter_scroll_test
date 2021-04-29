import 'package:flutter/widgets.dart';

class PricePositionInheritedWidget extends InheritedWidget {
  final ValueNotifier<Offset> priceNotifier;

  const PricePositionInheritedWidget({Key? key, required Widget child, required this.priceNotifier})
      : super(key: key, child: child);

  static ValueNotifier<Offset> of(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<PricePositionInheritedWidget>()!.priceNotifier;
    }
    final inheritedWidget = context.getElementForInheritedWidgetOfExactType<PricePositionInheritedWidget>()!.widget;
    assert(inheritedWidget is PricePositionInheritedWidget, 'PricePositionInheritedWidget not found');
    return (inheritedWidget as PricePositionInheritedWidget).priceNotifier;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget is! PricePositionInheritedWidget || oldWidget.priceNotifier != priceNotifier;
}
