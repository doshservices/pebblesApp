import 'package:flutter/material.dart';
import 'package:pebbles/utils/shared/custom_textformfield.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';

class Holiday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
            ),
            color: Colors.grey.withOpacity(0.2)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                        ),
                        Text("Back"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Holiday",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labelText: "Location",
                      ),
                      CustomTextFormField(
                        labelText: "Location info",
                      ),
                      CustomTextFormField(
                        labelText: "Number of persons",
                      ),
                      CustomTextFormField(
                        labelText: "Number of days",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RoundedRaisedButton(
                  label: "Save",
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
