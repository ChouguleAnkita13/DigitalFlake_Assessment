import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coworkingapp/availabledesk.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'dart:convert';

class DeskScreen extends StatefulWidget {
  final int? selectedType;
  const DeskScreen({super.key, this.selectedType});

  @override
  State<DeskScreen> createState() => _DeskScreen();
}

class _DeskScreen extends State<DeskScreen> {
  List slotList = [];
  int selectedSlot = -1;
  String selectedDate = "";

  List availableSlotDate = [];
  String slotName = "";

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

//Fetching data from server
  Future<void> _fetchData() async {
    try {
      final url = Uri.parse(
          'https://demo0413095.mockable.io/digitalflake/api/get_slots');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          slotList = data["slots"];
        });
      } else {
        return;
      }
    } catch (error) {
      setState(() {
        error;
      });
    }
  }

//For Active Slots
  Color activeSlot(bool isactive, int slotId) {
    if (isactive) {
      if (selectedSlot == slotId) {
        return const Color.fromRGBO(77, 96, 209, 1);
      }
      return const Color.fromRGBO(199, 207, 252, 1);
    }
    return const Color.fromRGBO(227, 227, 227, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(const DeskScreen());
            },
            icon: const Icon(Icons.arrow_back_outlined,
                size: 24, color: Color.fromRGBO(0, 0, 0, 1))),
        title: Text("Select Date & Slot",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 20,
                letterSpacing: -0.24,
                fontWeight: FontWeight.w400,
              ),
            )),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            activeColor: const Color.fromRGBO(77, 96, 209, 1),
            onDateChange: (date) {
              String formatDate = DateFormat('E d MMM').format(date);
              setState(() {
                selectedDate = formatDate;
              });
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
              width: 312,
              height: 250,
              margin: const EdgeInsets.all(20),
              child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                      slotList.length,
                      (index) => GestureDetector(
                            onTap: () {
                              if (selectedSlot == -1) {
                                setState(() {
                                  selectedSlot = slotList[index]["slot_id"];
                                  slotName = slotList[index]["slot_name"];
                                });
                              }
                            },
                            child: Container(
                              width: 152,
                              height: 42,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: activeSlot(
                                      slotList[index]["slot_active"],
                                      slotList[index]["slot_id"]),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(slotList[index]["slot_name"],
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: Color.fromRGBO(246, 246, 246, 1),
                                      fontSize: 14,
                                      letterSpacing: -0.24,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                            ),
                          )))),
          const Spacer(),
          Container(
            width: double.infinity,
            height: 56,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(81, 103, 235, 1),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  availableSlotDate.add({
                    'selectedDate': selectedDate,
                    'selectedSlotName': slotName
                  });
                });
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AvailableDesk(
                        availableSlotDate: availableSlotDate,
                        selectedType: widget.selectedType)));
              },
              child: Text("Next",
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
        ],
      ),
    );
  }
}
