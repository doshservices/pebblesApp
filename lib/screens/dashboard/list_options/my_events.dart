import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/utils/shared/custom_textformfield.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';

class MyEvents extends StatelessWidget {
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
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Your Events",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              MyEventListTile(),
              MyEventListTile(),
              MyEventListTile(),
              MyEventListTile(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyEventListTile extends StatelessWidget {
  const MyEventListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(
            "assets/images/event.png",
            width: 40,
          ),
          contentPadding: EdgeInsets.all(0),
          title: Text("Cubana Victoria Island"),
          subtitle: Text("Victoria Island, Lagos."),
          trailing: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(""),
                Text("Delete",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(kMyEventDetails);
          },
        ),
        Divider()
      ],
    );
  }
}
