import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/service_data_model.dart';
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
  int quantity = 1;

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.option.name.validate(),
            style: boldTextStyle(size: LABEL_TEXT_SIZE)),
        Observer(
          builder: (context) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                child: FaIcon(FontAwesomeIcons.minus),
                onTap: decrement,
              ),
              8.width,
              Text(
                bookingStore
                    .getOption(widget.option.id.validate())['quantity']
                    .toString(),
                style: boldTextStyle(size: 18),
              ),
              8.width,
              GestureDetector(
                child: FaIcon(FontAwesomeIcons.plus),
                onTap: increment,
              )
            ],
          ),
        )
      ],
    );
  }
}