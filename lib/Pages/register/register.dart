import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/Pages/common_widgets.dart';
import 'package:ulearning_app/Pages/register/bloc/register_blocs.dart';
import 'package:ulearning_app/Pages/register/bloc/register_events.dart';
import 'package:ulearning_app/Pages/register/bloc/register_states.dart';
import 'package:ulearning_app/Pages/register/register_controller.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBlocs, RegisterStates>(builder: (context, state){
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar("Sign Up"),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),

                  Center(
                      child:
                      reuseableText("Enter your details below and free sign up!")),
                  Container(
                    margin: EdgeInsets.only(top: 60.h),
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reuseableText("User Name"),
                        buildTextField(
                            "Enter your username", "name", "user",
                                (value) {
                              context.read<RegisterBlocs>().add(UserNameEvent(value));
                            }),

                        reuseableText("Email"),
                        buildTextField(
                            "Enter your Email", "email", "user",
                                (value) {
                              context.read<RegisterBlocs>().add(EmailEvent(value));
                            }),
                       reuseableText("Password"),

                        buildTextField(
                            "Enter your Password", "password", "lock", (value) {
                          context.read<RegisterBlocs>().add(PasswordEvent(value));
                        }),
                        reuseableText("Re-enter your Password"),

                        buildTextField(
                            "Confirm your password", "password", "lock", (value) {
                          context.read<RegisterBlocs>().add(RePasswordEvent(value));
                        }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25.w),
                    child: reuseableText("By creating an account you have to agree with our therm & condition"),
                  ),

                  buildLogInAdnRegButton("Sign Up", "login", () {
                    //Navigator.of(context).pushNamed("register");
                    RegisterController(context:context).handleEmailRegister();

                  }),
                ],
              ),
            ),
          ),
        ),
      );
    });
    }
  }

