import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/service_data_model.dart';
import 'package:booking_system_flutter/screens/service/service_detail_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:booking_system_flutter/utils/constant.dart';

class QuantityOption extends StatefulWidget {
  final Option option;
  // final BookingStore bookingStore;
  QuantityOption(
    this.option, {
    super.key,
  });

  @override
  State<QuantityOption> createState() => _QuantityOptionState();
}

class _QuantityOptionState extends State<QuantityOption> {
  void increment() {
    setState(() {
      bookingStore
          .increment(bookingStore.getOption(widget.option.id.validate()));
    });
  }

  void decrement() {
    setState(() {
      bookingStore
          .decrement(bookingStore.getOption(widget.option.id.validate()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: primaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: context.width() * 0.6,
                        child: Text('${widget.option.name.validate()}',
                            // textAlign: TextAlign.center,
                            style: boldTextStyle(
                                size: LABEL_TEXT_SIZE, color: white)),
                      ),
                      // if (widget.option.typeInt != 3)
                      //   if (widget.option.area != null && widget.option.area! > 0)
                      //     Marquee(
                      //         child: Text(' (' +
                      //             widget.option.area.toString() +
                      //             ' sqft)'))
                      //   else if (widget.option.unitPrice != null &&
                      //       widget.option.unitPrice! > 0)
                      //     Marquee(
                      //         child: Text(' (' +
                      //             widget.option.unitPrice.toString() +
                      //             appStore.currencySymbol +
                      //             ')'))
                    ],
                  ),
                  Observer(
                    builder: (context) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: FaIcon(
                            FontAwesomeIcons.minus,
                            color: white,
                          ),
                          onTap: decrement,
                        ),
                        8.width,
                        Text(
                          bookingStore
                              .getOption(
                                  widget.option.id.validate())['quantity']
                              .toString(),
                          style: boldTextStyle(size: 18, color: white),
                        ),
                        8.width,
                        GestureDetector(
                          child: FaIcon(
                            FontAwesomeIcons.plus,
                            color: white,
                          ),
                          onTap: increment,
                        )
                      ],
                    ),
                  )
                ],
              ).paddingSymmetric(horizontal: 10, vertical: 8),
            ).paddingSymmetric(vertical: 8));
  }
}
