import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


class PhoneCountry extends StatefulWidget {
  const PhoneCountry({super.key});

  @override
  State<PhoneCountry> createState() => _PhoneCountryState();
}

class _PhoneCountryState extends State<PhoneCountry> {
  @override
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  late String tel = '';
  late String _initialCountryCode = 'TR';

  FocusNode focusNode = FocusNode();
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(borderSide: BorderSide())),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Password';
                  } else if (nameController.text.length < 3) {
                    return 'name should not be less than 3 chars ';
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(borderSide: BorderSide()),
                ),
                validator: (value) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/-=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!);

                  if (value!.isEmpty) {
                    return 'Enter Email';
                  } else if (!emailValid) {
                    return 'Enter a valid Email';
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              IntlPhoneField(
                  validator: (value) {
                    var _country = countries.firstWhere(
                        (element) => element.code == _initialCountryCode);
                    if (value != null) {
                      if (value.number.length! < _country.minLength! ||
                          value.number.length! > _country.maxLength!) {
                        return 'الرقم خاطئ';
                      }
                    }
                  },
                  focusNode: focusNode,
                  decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(borderSide: BorderSide())),
                  languageCode: "ar",
                  initialCountryCode: _initialCountryCode,
                  onChanged: (phone) {
                    print(phone.completeNumber);
                    setState(() {
                      tel = phone.completeNumber;
                    });
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ' + country.name);
                  }),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  _formKey.currentState?.validate();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                      child: Text('Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20))),
                ),
              )
            ],
          )),
    );
  }
}
