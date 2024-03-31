import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/screens/service/service_detail_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AddressForm extends StatefulWidget {
  final ScrollController scrollController;

  AddressForm({required this.scrollController});
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  String selectedAddressType = 'Home';
  TextEditingController cityController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cityController.text = bookingStore.home;
    apartmentController.text = bookingStore.apartment;
    buildingController.text = bookingStore.building;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
                controller: widget.scrollController,
                child: Padding(
                    // Set background color
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              language.selecttype,
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              children: <Widget>[
                                Radio(
                                  value: 'Home',
                                  groupValue: selectedAddressType,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAddressType = value!;
                                    });
                                  },
                                ),
                                Text(language.home),
                                Radio(
                                  value: 'Office',
                                  groupValue: selectedAddressType,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAddressType = value!;
                                    });
                                  },
                                ),
                                Text(language.lbloffice),
                                Radio(
                                  value: 'Other',
                                  groupValue: selectedAddressType,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAddressType = value!;
                                    });
                                  },
                                ),
                                Text(language.lblother),
                              ],
                            ),

                            SizedBox(height: 15.0),
                            // Text(
                            //   'Enter Address:',
                            //   style: TextStyle(fontSize: 16.0),
                            // ),
                            TextFormField(
                              controller: cityController,
                              onChanged: (value) {
                                setState(() {});
                                bookingStore.home = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty)
                                  return language.requiredText;
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: language.selectCity,
                              ),
                            ),
                            SizedBox(height: 15.0),

                            TextFormField(
                              // controller: selectedAddressType == 'Other'
                              //     ? otherAddressController
                              //     : selectedAddressType == 'Home'
                              //         ? homeAddressController
                              //         : selectedAddressType == 'Office'
                              //             ? officeAddressController
                              //             : TextEditingController(),
                              controller: buildingController,

                              onChanged: (value) {
                                setState(() {});
                                bookingStore.building = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty)
                                  return language.requiredText;
                                return null;
                              },

                              decoration: InputDecoration(
                                hintText: language.selectBuilding,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            TextFormField(
                              controller: apartmentController,
                              onChanged: (value) {
                                setState(() {});
                                bookingStore.apartment = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty)
                                  return language.requiredText;
                                return null;
                              },
                              // controller: selectedAddressType == 'Other'
                              //     ? otherAddressController
                              //     : selectedAddressType == 'Home'
                              //         ? homeAddressController
                              //         : selectedAddressType == 'Office'
                              //             ? officeAddressController
                              //             : TextEditingController(),
                              decoration: InputDecoration(
                                hintText: language.selectApartment,
                              ),
                            ),
                            SizedBox(
                              height: 25.0,
                            ),

                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Form is validated
                                    // Close the modal
                                    Navigator.pop(context);
                                  }
                                  // Close the modal
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,

                                  // Background color
                                ),
                              ),
                            ),
                          ],
                        ))))));
  }
}
