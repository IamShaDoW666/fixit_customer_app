import 'package:booking_system_flutter/model/service_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import '../../../store/booking_store.dart';
import '../../../utils/colors.dart';

class MultiOption extends StatefulWidget {
  final Option option;
  final BookingStore bookingStore;
  MultiOption(
    this.option,
    this.bookingStore, {
    super.key,
  });

  @override
  State<MultiOption> createState() => _MultiOptionState();
}

class _MultiOptionState extends State<MultiOption> {
  bool selected = false;

  bool checkSelected(int id) => widget.bookingStore
      .optionExists({'option': widget.option.id.validate(), 'variant': id});

  void selectVariant(int optionId, int variantId) {
    setState(() {
      widget.bookingStore.addMultiOption({
        'option': optionId,
        'variant': variantId,
        'type': 'normal',
        'price': widget.option.variants!
            .firstWhere((element) => element.id == variantId)
            .price
      });
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
      Column(
        children: List.generate(
          widget.option.variants!.length,
          (idx) => ElevatedButton(
            onPressed: () {
              selectVariant(
                widget.option.id.validate(),
                widget.option.variants![idx].id.validate(),
              );
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: BorderSide(color: primaryColor, width: 1.0)
                    // Set BorderRadius.zero for no rounded corners
                    ),
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.all(12.0),
                // Set the padding as needed
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.option.variants![idx].name.validate(),
                          style: TextStyle(
                              fontSize: 16,
                              color: checkSelected(widget
                                      .option.variants![idx].id
                                      .validate())
                                  ? Color.fromARGB(
                                      255, 15, 6, 6) // Change to selected color
                                  : primaryColor),
                        ),
                        SizedBox(height: 16),
                        // if (checkSelected(
                        //     widget.option.variants![idx].id.validate()))
                        //   Container(
                        //     width: MediaQuery.of(context).size.width,
                        //     child: SingleChildScrollView(
                        //       child: Html(
                        //         data: widget.option.variants![idx].description,
                        //         style: {
                        //           'p': Style(color: black),
                        //           'h1': Style(color: white)
                        //         },
                        //         // Apply styles or configurations if needed
                        //       ),
                        //     ),
                        //   ),
                        if (checkSelected(
                            widget.option.variants![idx].id.validate()))
                          Container(
                            // width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  child: Html(
                                    data: widget
                                        .option.variants![idx].description,
                                    style: {
                                      'p': Style(color: black),
                                      'h1': Style(color: white)
                                    },
                                    // Apply styles or configurations if needed
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    icon: Icon(Icons.check_circle,
                                        color: Colors.green),
                                    onPressed: () {
                                      // Add your onPressed action here
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    widget.option.variants![idx].priceFormat.validate(),
                    style: TextStyle(
                        color: checkSelected(
                                widget.option.variants![idx].id.validate())
                            ? Color.fromARGB(
                                255, 49, 2, 2) // Change to selected color
                            : primaryColor),
                  ),
                ],
              ),
            ),

            // Other ElevatedButton properties
          ).paddingSymmetric(vertical: 6),
        ),
      ),
    ]);
  }
}
