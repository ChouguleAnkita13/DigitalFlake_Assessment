import 'package:flutter/material.dart';
import 'package:coworkingapp/login_screen.dart';
import 'package:coworkingapp/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreen();
}

class _CreateAccountScreen extends State<CreateAccountScreen> {
  //TextEditingControllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  //Key
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//POST create_account: Store data
  void saveData() async {
    final url = Uri.parse(
        'https://demo0413095.mockable.io/digitalflake/api/create_account');
    await http.post(
      url,
      body: json.encode(
        {
          "name": _nameController.text,
          "email": _emailController.text,
          "mobile": _mobileController.text
        },
      ),
    );
  }

  //Validation Function
  String? validation(String value) {
    if (value == _nameController.text) {
      if (value.trim().isEmpty || value.length < 4) {
        return "Please Enter Full Name";
      }
      return null;
    }
    if (value == _mobileController.text) {
      if (value.trim().isEmpty) {
        return "Please Enter mobile Number";
      }
      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
        return 'Please enter a valid 10-digit mobile number';
      }
      return null;
    }
    if (value == _emailController.text) {
      if (value.isEmpty ||
          !RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
              .hasMatch(value)) {
        return 'Please enter a valid email';
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
            const EdgeInsets.only(top: 90, left: 20, bottom: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 223,
              child: Text("Create an Account",
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full name",
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
                        controller: _nameController,
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
                      "Mobile number",
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
                        controller: _mobileController,
                        validator: (value) => validation(value!),
                        keyboardType: TextInputType.phone,
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
                      "Email ID",
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
                        controller: _emailController,
                        validator: (value) => validation(value!),
                        keyboardType: TextInputType.emailAddress,
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
                      height: 12,
                    ),
                  ],
                ),
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
                  if (_formkey.currentState!.validate()) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                  }
                },
                child: Text("Create an Account",
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
                          builder: (context) => const LoginScreen()));
                    },
                    child: Text("Log In",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(42, 29, 139, 1),
                            fontSize: 14,
                            letterSpacing: -0.24,
                            fontWeight: FontWeight.w400,
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
