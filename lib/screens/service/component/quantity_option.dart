import 'package:booking_system_flutter/model/service_data_model.dart';
import 'package:booking_system_flutter/screens/service/service_detail_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:booking_system_flutter/utils/constant.dart';

import '../../../store/booking_store.dart';

class QuantityOption extends StatefulWidget {
  final Option option;
  final BookingStore bookingStore;
  QuantityOption(
    this.option,
    this.bookingStore, {
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

  bool checkSelected(int id) =>
      widget.bookingStore.getOption(id)['quantity'] > 0;

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: white,
                border: Border.all(
                  color: primaryColor, // Change the color to your desired color
                  width: 1.0, // Change the width to your desired thickness
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: context.width() * 0.6,
                            child: Text('${widget.option.name.validate()}',
                                // textAlign: TextAlign.center,
                                style: boldTextStyle(
                                    size: LABEL_TEXT_SIZE,
                                    color: primaryColor)),
                          ),
                        ],
                      ),
                      Observer(
                        builder: (context) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.minus,
                                color: primaryColor,
                              ),
                              onTap: decrement,
                            ),
                            8.width,
                            Text(
                              bookingStore
                                  .getOption(
                                      widget.option.id.validate())['quantity']
                                  .toString(),
                              style:
                                  boldTextStyle(size: 18, color: primaryColor),
                            ),
                            8.width,
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.plus,
                                color: primaryColor,
                              ),
                              onTap: increment,
                            )
                          ],
                        ),
                      )
                    ],
                  ).paddingSymmetric(horizontal: 10, vertical: 8),
                  if (checkSelected(widget.option.id.validate()) &&
                      widget.option.description != null)
                    Container(
                      // width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Html(
                            data: widget.option.description.validate(),
                            style: {
                              'p': Style(color: black),
                              'h1': Style(color: white)
                            },
                            // Apply styles or configurations if needed
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ).paddingSymmetric(vertical: 8));
  }
}
