import 'package:flutter/material.dart';
import 'package:pebbles/constants.dart';
import 'package:pebbles/model/user_model.dart';
import 'package:pebbles/provider/auth.dart';
import 'package:pebbles/utils/shared/bottom_sheets.dart';
import 'package:pebbles/utils/shared/custom_default_button.dart';
import 'package:pebbles/utils/shared/custom_textformfield.dart';
import 'package:pebbles/utils/shared/error_snackbar.dart';
import 'package:pebbles/utils/shared/rounded_raised_button.dart';
import 'package:pebbles/utils/shared/top_back_navigation_widget.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  UserModel userModel = UserModel();
  bool _isLoading = false;

  editProfileSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).updateUser(userModel);

      BottomSheets.modalBottomSheet(
          context: context,
          title: 'Success',
          subtitle: 'Profile Updated',
          isDismissible: true,
          showButton: false);
    } catch (error) {
      ErrorSnackBar.displaySnackBar('Error', '${error.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    userModel = auth.user;

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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBackNavigationWidget(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Edit Profile",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Gilroy'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  labelText: 'Email',
                  initialValue: userModel.email ?? '',
                  onSaved: (value) {
                    userModel.email = value;

                    return;
                  },
                  validator: (value) {
                    // validate email
                    if (value!.isEmpty) {
                      return "Email required";
                    }

                    // using regular expression
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "Please enter a valid email address";
                    }

                    // valid email
                    return null;
                  },
                ),
                CustomTextFormField(
                  labelText: 'Full name',
                  initialValue: userModel.fullName ?? '',
                  onSaved: (value) {
                    userModel.fullName = value;

                    return;
                  },
                  validator: (value) {
                    // validate input
                    if (value!.isEmpty) {
                      return "Fullname required";
                    }

                    return null;
                  },
                ),
                CustomTextFormField(
                  labelText: 'Phone number',
                  initialValue: userModel.phoneNumber ?? '',
                  onSaved: (value) {
                    userModel.phoneNumber = value;

                    return;
                  },
                  validator: (value) {
                    // validate input
                    if (value!.isEmpty) {
                      return "Phone number required";
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 120,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: CustomDefaultButton(
                      text: "Update",
                      isLoading: _isLoading,
                      onPressed: editProfileSubmit),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
