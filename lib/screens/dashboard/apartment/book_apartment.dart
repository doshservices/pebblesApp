import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/apartment_model.dart';
import 'package:pebbles/model/booking_model.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/custom_textformfield.dart';
import 'package:pebbles/utils/shared/error_snackbar.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookApartment extends StatefulWidget {
  BookApartment({Key? key}) : super(key: key);

  @override
  State<BookApartment> createState() => _BookApartmentState();
}

class _BookApartmentState extends State<BookApartment> {
  final GlobalKey<FormState> bookingFormKey = new GlobalKey<FormState>();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  bool startDateSelected = true;
  Apartment apartment = Apartment();
  int inputNoOfGuest = 0;
  bool dateError = false;

  Future<void> _submitBooking() async {
    // validate start and end date is selected
    if (selectedStartDate == null || selectedEndDate == null) {
      ErrorSnackBar.displaySnackBar(
          'Error!', 'Please provide check-in date and check-out date');

      setState(() {
        dateError = true;
      });
    } else if (selectedStartDate!.compareTo(selectedEndDate!) >= 1) {
      // start date is > endDate
      ErrorSnackBar.displaySnackBar(
          'Error!', 'Check-in date cannot be greater than Check-out date');

      setState(() {
        dateError = true;
      });
    } else {
      if (!bookingFormKey.currentState!.validate()) {
        return;
      }
      bookingFormKey.currentState!.save();

      // navigate to details preview
      Booking apartmentBooking = Booking();

      apartmentBooking.apartmentId = ApartmentId();
      apartmentBooking.apartmentId!.sId = apartment.sId;
      apartmentBooking.apartmentOwnerId = ApartmentOwnerId();
      apartmentBooking.apartmentOwnerId!.sId = apartment.userId;
      apartmentBooking.checkInDate =
          DateFormat.yMd().format(selectedStartDate!);
      apartmentBooking.checkOutDate = DateFormat.yMd().format(selectedEndDate!);

      int difference = selectedEndDate!.difference(selectedStartDate!).inDays;
      if (difference == 0) {
        difference = 1;
      }
      apartmentBooking.bookingAmount = difference * (apartment.price ?? 0);
      apartmentBooking.numberOfGuests = inputNoOfGuest;

      Navigator.of(context).pushNamed(KBookApartmentPreview,
          arguments: {'apartmentBooking': apartmentBooking});
    }
  }

  _dateDialog() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isDismissible: true,
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.only(bottom: 10.0, top: 30.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.single,
                minDate: DateTime.now(),
                initialSelectedDate:
                    startDateSelected ? selectedStartDate : selectedEndDate,
              ),
            ),
          );
        });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (startDateSelected) {
        selectedStartDate = DateTime.parse(args.value.toString());
      } else {
        selectedEndDate = DateTime.parse(args.value.toString());
      }

      dateError = false;
    });

    // validate start and end date
  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)?.settings.arguments as Map;
    apartment = data["apartment"];

    String displayStartDate = selectedStartDate == null
        ? ""
        : DateFormat.yMMMMd('en_US').format(selectedStartDate!);
    String displayEndDate = selectedEndDate == null
        ? ""
        : DateFormat.yMMMMd('en_US').format(selectedEndDate!);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill),
            color: Colors.grey.withOpacity(0.2)),
        child: SingleChildScrollView(
          child: Form(
            key: bookingFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBackNavigationWidget(),
                Text(
                  "Book apartment: ${apartment.apartmentName}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Gilroy'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 70,
                ),
                InkWell(
                  onTap: () {
                    startDateSelected = true;
                    _dateDialog();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Check-in date',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down_circle_outlined),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        displayStartDate,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Gilroy',
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        color: dateError ? Colors.red : Colors.black54,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    startDateSelected = false;
                    _dateDialog();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Check-out date',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down_circle_outlined),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        displayEndDate,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Gilroy',
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        color: dateError ? Colors.red : Colors.black54,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  labelText: "No. of guest",
                  darkInputBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, width: 2)),
                  textColor: Colors.black,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                    try {
                      inputNoOfGuest = int.parse(value);
                      if (inputNoOfGuest <= 0) {
                        // validate if num of guest with apartment
                        return "Number of guest must be greater than 0";
                      }
                    } catch (e) {
                      return "Invalid input";
                    }
                  },
                  onSaved: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                    try {
                      inputNoOfGuest = int.parse(value);
                      if (inputNoOfGuest <= 0) {
                        // validate if num of guest with apartment
                        return "Number of guest must be greater than 0";
                      }
                    } catch (e) {
                      return "Invalid input";
                    }
                  },
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: CustomDefaultButton(
                    text: "Proceed",
                    onPressed: () async {
                      await _submitBooking();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
