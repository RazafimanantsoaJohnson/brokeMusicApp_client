import 'package:brokemusicapp/constants.dart';
import 'package:brokemusicapp/logics/AuthBrain.dart';
import 'package:flutter/material.dart';
import 'package:brokemusicapp/components/constants.dart';
import 'package:provider/provider.dart';
import 'package:loader_overlay/loader_overlay.dart';


class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SigninScreen> {
  String email = "";
  String password = "";
  bool isErrorPassword = false;
  bool isErrorEmail= false;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                        decoration: isErrorPassword?kAuthInputErrorDecoration:(kAuthInputDecoration.copyWith(
                          labelText: "Password",
                        )),
                        style: TextStyle(color: Colors.grey.shade900),
                        onSubmitted: (value) async{
                          setState(() {});
                        },
                      ),
                    ]
                ),
                ElevatedButton(
                    onPressed: () async{
                      try{
                        context.loaderOverlay.show();
                        if (isErrorPassword){
                          return;
                        }
                        bool isSuccess = await Provider.of<AuthBrain>(context, listen:false).signin(email, password);
                        context.loaderOverlay.hide();
                        String accessToken = Provider.of<AuthBrain>(context ,listen:false).accessToken;
                        print("Auth Success:$isSuccess\nToken: $accessToken");
                        if (isSuccess){
                          Navigator.pushNamed(context, '/main');
                        }

                      }catch(e){
                        print(e);
                      }
                    },
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
                        "SIGN IN",
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
      ),
    );
  }
}

