import 'package:flutter/material.dart';

class TopBackNavigationWidget extends StatelessWidget {
  const TopBackNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    size: 22.0,
                  ),
                  Text(
                    "Back",
                    style: TextStyle(
                        fontSize: 21.0,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
