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
      // Column(
      //     children: List.generate(
      //         widget.option.variants!.length,
      //         (idx) => ChoiceChip(
      //               label: Container(
      //                 width: context.width(),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Container(
      //                       width: context.width() * 0.6,
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Marquee(
      //                             animationDuration: Duration(seconds: 1),
      //                             pauseDuration: Duration(seconds: 2),
      //                             backDuration: Duration(seconds: 1),
      //                             child: Text(
      //                               widget.option.variants![idx].name
      //                                   .validate(),
      //                               style: TextStyle(fontSize: 18),
      //                             ),
      //                           ),
      //                           16.height,
      //                           if (checkSelected(
      //                               widget.option.variants![idx].id.validate()))
      //                             Container(
      //                                 width: MediaQuery.of(context).size.width,
      //                                 child: SingleChildScrollView(
      //                                   child: Html(
      //                                     data: widget.option.variants![idx]
      //                                         .description,
      //                                   ),
      //                                 ))
      //                         ],
      //                       ),
      //                     ),
      //                     Text(widget.option.variants![idx].priceFormat
      //                         .validate())
      //                   ],
      //                 ),
      //               ),
      //               labelStyle: boldTextStyle(
      //                   color: checkSelected(
      //                           widget.option.variants![idx].id.validate())
      //                       ? Colors.white
      //                       : primaryColor),
      //               showCheckmark: false,
      //               selectedColor: primaryColor,
      //               side: BorderSide(color: primaryColor),
      //               selected: checkSelected(
      //                   widget.option.variants![idx].id.validate()),
      //               onSelected: (newValue) {
      //                 selectVariant(widget.option.id.validate(),
      //                     widget.option.variants![idx].id.validate());
      //               },
      //             ).paddingSymmetric(vertical: 8))),

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
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return checkSelected(
                          widget.option.variants![idx].id.validate())
                      ? primaryColor // Change to selected color
                      : Colors.white; // Change to default color
                },
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      6.0), // Set BorderRadius.zero for no rounded corners
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.all(12.0), // Set the padding as needed
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
                                  ? Colors.white // Change to selected color
                                  : primaryColor),
                        ),
                        SizedBox(height: 16),
                        if (checkSelected(
                            widget.option.variants![idx].id.validate()))
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              child: Html(
                                data: widget.option.variants![idx].description,
                                style: {
                                  'p': Style(color: white),
                                  'h1': Style(color: white)
                                },
                                // Apply styles or configurations if needed
                              ),
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
                            ? Colors.white // Change to selected color
                            : primaryColor),
                  ),
                ],
              ),
            ),

            // Other ElevatedButton properties
          ).paddingSymmetric(vertical: 6),
        ),
      )
    ]);
  }
}
