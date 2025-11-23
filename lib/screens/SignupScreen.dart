import 'package:brokemusicapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:brokemusicapp/components/constants.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email = "";
  String password = "";
  String passwordConfirmation = "";
  bool isErrorPassword = false;
  bool isErrorEmail= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14, top: 20.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: kAuthFormVerticalSpacing,
            children: [
              Column(
                spacing: kAuthFormVerticalSpacing,
                children: [
                  Container(
                    height: 240.0,
                    width: 240.0,
                    child: Image.asset(
                        'resources/images/Icon_bma.png',
                        fit: BoxFit.scaleDown
                    ),
                  ),
                  SizedBox(height: kAuthFormVerticalSpacing),
                  TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kAuthInputDecoration.copyWith(
                      labelText: "Email",
                    ),
                    style: TextStyle(color: Colors.grey.shade900),
                    onSubmitted: (value) async{
                      setState(() {});
                    },
                  ),
                  TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: true,
                    decoration: kAuthInputDecoration.copyWith(
                      labelText: "Password",
                    ),
                    style: TextStyle(color: Colors.grey.shade900),
                    onSubmitted: (value) async{
                      setState(() {});
                    },
                  ),
                  TextField(
                    onChanged: (value) {
                      passwordConfirmation = value;
                    },
                    obscureText: true,
                    decoration: kAuthInputDecoration.copyWith(
                      labelText: "Confirm Password",
                    ),
                    style: TextStyle(color: Colors.grey.shade900),
                    onSubmitted: (value) async{
                      setState(() {});
                    },
                  ),
                ]
              ),
              ElevatedButton(
                onPressed: (){},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states){
                        if(states.contains(WidgetState.pressed)){
                          return Color(kPlayerBackground).withAlpha(160);
                        }
                        return Color(kPlayerBackground);
                      }
                  ),
                  padding: WidgetStateProperty.resolveWith<EdgeInsets?>(
                      (Set<WidgetState> states){
                        return EdgeInsets.symmetric(vertical: 16.0);
                      }
                  ),
                ),
                child: Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    )
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

