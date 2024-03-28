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
  String selectedAddressType = 'Home';
  TextEditingController cityController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cityController.text = bookingStore.city;
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Select Address Type",
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
                            Text('Home'),
                            Radio(
                              value: 'Office',
                              groupValue: selectedAddressType,
                              onChanged: (value) {
                                setState(() {
                                  selectedAddressType = value!;
                                });
                              },
                            ),
                            Text('Office'),
                            Radio(
                              value: 'Other',
                              groupValue: selectedAddressType,
                              onChanged: (value) {
                                setState(() {
                                  selectedAddressType = value!;
                                });
                              },
                            ),
                            Text('Other'),
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
                            bookingStore.city = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'City',
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
                          decoration: InputDecoration(
                            hintText: 'Building/Street Name',
                          ),
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          controller: apartmentController,
                          onChanged: (value) {
                            setState(() {});
                            bookingStore.apartment = value;
                          },
                          // controller: selectedAddressType == 'Other'
                          //     ? otherAddressController
                          //     : selectedAddressType == 'Home'
                          //         ? homeAddressController
                          //         : selectedAddressType == 'Office'
                          //             ? officeAddressController
                          //             : TextEditingController(),
                          decoration: InputDecoration(
                            hintText: 'Apartment/Villa Number',
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),

                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Close the modal
                              Navigator.pop(context);
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
                    )))));
  }
}
