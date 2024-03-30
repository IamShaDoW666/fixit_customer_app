import 'dart:io';

import 'package:booking_system_flutter/component/custom_image_picker.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/service_detail_response.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/model_keys.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../model/package_data_model.dart';

class BookingServiceImage extends StatefulWidget {
  final ServiceDetailResponse data;
  final bool? isSlotAvailable;

  const BookingServiceImage(
      {super.key, required this.data, this.isSlotAvailable});

  @override
  State<BookingServiceImage> createState() => _BookingServiceImageState();
}

class _BookingServiceImageState extends State<BookingServiceImage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<File> imageFiles = [];
  List<Attachments> tempAttachments = [];
  UniqueKey uniqueKey = UniqueKey();
  bool isUpdate = false;

  //region Remove Attachment
  Future<void> removeAttachment({required int id}) async {
    appStore.setLoading(true);

    Map req = {
      CommonKeys.type: 'booking_attachment',
      CommonKeys.id: id,
    };

    await deleteImage(req).then((value) {
      tempAttachments.validate().removeWhere((element) => element.id == id);
      setState(() {});

      uniqueKey = UniqueKey();

      appStore.setLoading(false);
      toast(value.message.validate(), print: true);
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
  }

  //endregion

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        8.height,
        Text(language.uploadimg, style: boldTextStyle(size: LABEL_TEXT_SIZE)),
        20.height,
        Text(language.uploadimage, style: primaryTextStyle(size: 12)),
        20.height,
        Padding(
            padding: EdgeInsets.all(16),
            child: CustomImagePicker(
              key: uniqueKey,
              onRemoveClick: (value) {
                if (tempAttachments.validate().isNotEmpty &&
                    imageFiles.isNotEmpty) {
                  showConfirmDialogCustom(
                    context,
                    dialogType: DialogType.DELETE,
                    positiveText: language.lblDelete,
                    negativeText: language.lblCancel,
                    onAccept: (p0) {
                      imageFiles
                          .removeWhere((element) => element.path == value);
                      removeAttachment(
                          id: tempAttachments
                              .validate()
                              .firstWhere((element) => element.url == value)
                              .id
                              .validate());
                    },
                  );
                } else {
                  showConfirmDialogCustom(
                    context,
                    dialogType: DialogType.DELETE,
                    positiveText: language.lblDelete,
                    negativeText: language.lblCancel,
                    onAccept: (p0) {
                      imageFiles
                          .removeWhere((element) => element.path == value);
                      if (isUpdate) {
                        uniqueKey = UniqueKey();
                      }
                      setState(() {});
                    },
                  );
                }
              },
              selectedImages:
                  imageFiles.validate().map((e) => e.path.validate()).toList(),
              onFileSelected: (List<File> files) async {
                setState(() {
                  imageFiles = files;
                  widget.data.imageList = files;
                });
              },
            ))
      ],
    );
  }
}
