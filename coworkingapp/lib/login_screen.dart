import 'package:coworkingapp/create_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coworkingapp/home_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  //TextEditingControllers
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _mobileEmailController = TextEditingController();
  //Key
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//POST login: Store data
  void saveData() async {
    final url =
        Uri.parse('https://demo0413095.mockable.io/digitalflake/api/login');
    await http.post(
      url,
      body: json.encode(
        {
          "email": _mobileEmailController.text,
          "password": _passController.text
        },
      ),
    );
  }

  //Validation Function
  String? validation(String value) {
    if (value == _passController.text) {
      if (value.trim().isEmpty || value.length < 9) {
        return "Please Enter 9 digit password";
      }
      return null;
    }
    if (value == _mobileEmailController.text) {
      if (value.isEmpty) {
        return 'Please enter mobile number or email';
      }
      if (!RegExp(r'^[0-9]{10}$').hasMatch(value) &&
          !RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
              .hasMatch(value)) {
        return 'Please enter a valid mobile number or email';
      }
      return null;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 89, left: 20, bottom: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/DF_Icon.png",
              width: 44,
              height: 44,
            ),
            SizedBox(
              width: 139,
              child: Text("Co-working",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 24,
                      letterSpacing: -0.24,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
            Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mobile number or Email",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(73, 73, 73, 1),
                        fontSize: 16,
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    height: 56,
                    color: const Color.fromRGBO(249, 249, 249, 1),
                    child: TextFormField(
                      controller: _mobileEmailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => validation(value!),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color.fromRGBO(218, 218, 218, 1),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Password",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(73, 73, 73, 1),
                        fontSize: 16,
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    height: 56,
                    color: const Color.fromRGBO(249, 249, 249, 1),
                    child: TextFormField(
                      controller: _passController,
                      validator: (value) => validation(value!),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.visibility_off_outlined,
                          size: 24,
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color.fromRGBO(218, 218, 218, 1),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 56,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(81, 103, 235, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: GestureDetector(
                onTap: () {
                  // if (_formkey.currentState!.validate()) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  // }
                },
                child: Text("Log In",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 16,
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Existing user?",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(98, 98, 98, 1),
                        fontSize: 14,
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CreateAccountScreen()));
                    },
                    child: Text("Create an account",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(42, 29, 139, 1),
                            fontSize: 16,
                            letterSpacing: -0.24,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
