import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';

/// Top navigation widget for 'Back' text
class TopBackNavigationWidget extends StatelessWidget {
  const TopBackNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pushReplacementNamed(kRegisterPageOne);
                }
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
