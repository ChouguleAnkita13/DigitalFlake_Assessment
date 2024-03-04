import 'package:coworkingapp/bookinghistory.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coworkingapp/desk_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int selectedType = 0;

  Color selectType(int buttonIndex) {
    if (selectedType != 0) {
      if (selectedType == buttonIndex) {
        return const Color.fromRGBO(81, 103, 235, 1);
      }

      return const Color.fromRGBO(199, 207, 252, 1);
    }
    return const Color.fromRGBO(81, 103, 235, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 60, left: 20, bottom: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/DF_Icon.png",
                  width: 22,
                  height: 22,
                ),
                Text("Co-working",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 14,
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                const Spacer(),
                Container(
                  height: 30,
                  width: 131,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(81, 103, 235, 1),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            offset: Offset(1, 1),
                            blurRadius: 10)
                      ]),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              BookingHistory(selectedType: selectedType)));
                    },
                    child: Text(
                      "Booking history",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 14,
                          letterSpacing: -0.24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      height: 147,
                      width: 147,
                      decoration: BoxDecoration(
                        color: selectType(1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (selectedType == 0) {
                            setState(() {
                              selectedType = 1;
                            });
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DeskScreen(selectedType: selectedType)));
                        },
                        child: Image.asset(
                          "assets/images/Group.png",
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 113,
                      child: Text(
                        "Book Work Station",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(67, 62, 62, 1),
                            fontSize: 20,
                            letterSpacing: -0.24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 147,
                      width: 147,
                      decoration: BoxDecoration(
                        color: selectType(2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (selectedType == 0) {
                            setState(() {
                              selectedType = 2;
                            });
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DeskScreen(selectedType: selectedType)));
                        },
                        child: Image.asset(
                          "assets/images/meeting-room.png",
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 113,
                      child: Text(
                        "Meeting room",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(67, 62, 62, 1),
                            fontSize: 20,
                            letterSpacing: -0.24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
