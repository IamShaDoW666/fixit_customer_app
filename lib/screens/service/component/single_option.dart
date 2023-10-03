import 'package:booking_system_flutter/model/service_data_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:booking_system_flutter/utils/constant.dart';

import '../../../utils/colors.dart';

class SingleOption extends StatefulWidget {
  final Option option;

  SingleOption(
    this.option, {
    super.key,
  });

  @override
  State<SingleOption> createState() => _SingleOptionState();
}

class _SingleOptionState extends State<SingleOption> {
  int selected = 0;

  bool checkSelected(int id) {
    return (selected == id);
  }

  void selectVariant(int id) {
    setState(() {
      selected = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.option.name.validate(),
        style: boldTextStyle(size: LABEL_TEXT_SIZE),
      ),
      8.height,
      Wrap(
          children: List.generate(
              widget.option.variants!.length,
              (idx) => ChoiceChip(
                    label: Text(widget.option.variants![idx].name.validate()),
                    labelStyle: boldTextStyle(
                        color: checkSelected(
                                widget.option.variants![idx].id.validate())
                            ? Colors.white
                            : primaryColor),
                    showCheckmark: false,
                    selectedColor: primaryColor,
                    side: BorderSide(color: primaryColor),
                    selected: checkSelected(
                        widget.option.variants![idx].id.validate()),
                    onSelected: (newValue) {
                      selectVariant(widget.option.variants![idx].id.validate());
                    },
                  ).paddingAll(8)))
    ]);
  }
}
