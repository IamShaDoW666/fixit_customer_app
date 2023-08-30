import 'dart:io';

import 'package:booking_system_flutter/component/custom_stepper.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/service_detail_response.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingServiceImage extends StatefulWidget {
  final ServiceDetailResponse data;
  final bool? isSlotAvailable;

  const BookingServiceImage(
      {super.key, required this.data, this.isSlotAvailable});

  @override
  State<BookingServiceImage> createState() => _BookingServiceImageState();
}

class _BookingServiceImageState extends State<BookingServiceImage> {
  List<XFile> _imageList = [];

  Future<void> _pickImages() async {
    List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _imageList = images;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 24, right: 16, left: 16),
              child: Column(
                children: [
                  8.height,
                  Text("Upload Images",
                      style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                  20.height,
                  Text("Kindly upload images related to the service",
                      style: TextStyle(fontSize: 12)),
                  20.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () async {},
                          child: Row(
                            children: [
                              Text('Use Camera'),
                              8.width,
                              Icon(Icons.camera_alt)
                            ],
                          )),
                      ElevatedButton(
                          onPressed: _pickImages,
                          child: Row(
                            children: [
                              Text('Upload Image'),
                              8.width,
                              Icon(Icons.image)
                            ],
                          )),
                    ],
                  ),
                ],
              )),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              children: [
                AppButton(
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: radius(),
                      side: BorderSide(color: context.primaryColor)),
                  onTap: () {
                    customStepperController.previousPage(
                        duration: 200.milliseconds, curve: Curves.easeInOut);
                  },
                  text: language.lblPrevious,
                  textColor: textPrimaryColorGlobal,
                ).expand(),
                16.width,
                AppButton(
                  onTap: () {
                    hideKeyboard(context);
                  },
                  text: language.btnNext,
                  textColor: Colors.white,
                  width: context.width(),
                  color: context.primaryColor,
                ).expand(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
