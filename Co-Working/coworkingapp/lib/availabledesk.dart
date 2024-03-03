import 'package:coworkingapp/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class AvailableDesk extends StatefulWidget {
  final List? availableSlotDate;
  final int? selectedType;
  const AvailableDesk({super.key, this.availableSlotDate,this.selectedType});

  @override
  State<AvailableDesk> createState() => _AvailableDesk();
}

class _AvailableDesk extends State<AvailableDesk> {
  List availabledeskList = [];
  int selectedDesk = -1;
  String workSpaceName = "";
  String date = "";
  String slotName = "";

//GET get_availability:Fetching data
  Future<void> _fetchData() async {
    final url = Uri.parse(
        'https://demo0413095.mockable.io/digitalflake/api/get_availability');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        availabledeskList = data["availability"];
      });
    } else {
      return;
    }
  }

//POST confirm_booking: Store data
  void _saveData() async {
    final url = Uri.parse(
        'https://demo0413095.mockable.io/digitalflake/api/confirm_booking');
    // final response = 
    await http.post(
      url,
      body: json.encode(
        {
          "workspace_name": workSpaceName,
          "workspace_id": selectedDesk,
          "booking_date": "$date at $slotName"
        },
      ),
    );
    // print(response.body);
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Color activeDesk(bool isactive, int workspaceId) {
    if (isactive) {
      if (selectedDesk == workspaceId) {
        return const Color.fromRGBO(77, 96, 209, 1);
      }
      return const Color.fromRGBO(199, 207, 252, 1);
    }
    return const Color.fromRGBO(227, 227, 227, 1);
  }

//For confirmation slot,date and Desk
  void confirmation(
      String workSpaceName, String availableSlot, String availableDate) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Return AlertDialog
        return SizedBox(
          height: 162,
          width: 263,
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Row(
              children: [
                Text(
                  'Confirm Booking',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color.fromRGBO(73, 73, 73, 1),
                      fontSize: 12,
                      letterSpacing: -0.24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.cancel,
                      size: 14,
                    )),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text((widget.selectedType==1)?"Desk ID : 786549":"Room ID : 786549",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 11,
                            letterSpacing: -0.24,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                    const Spacer(),
                    Text((widget.selectedType==1)?"Desk $workSpaceName":"Room No.$workSpaceName",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(73, 73, 73, 1),
                            fontSize: 14,
                            letterSpacing: -0.24,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text("Slot : $availableDate , $availableSlot",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(73, 73, 73, 1),
                        fontSize: 11,
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                Container(
                  width: 159,
                  height: 34,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(81, 103, 235, 1),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _saveData();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: const Color.fromRGBO(25, 173, 30, 1),
                          padding: const EdgeInsets.all(15),
                          behavior: SnackBarBehavior.floating,
                          width: 312,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Success",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: 14,
                                      letterSpacing: -0.24,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "You have successfully booked your Desk",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: 12,
                                      letterSpacing: -0.24,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                            ],
                          ),
                        ));
                      });
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    },
                    child: Text("Confirm",
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    date = widget.availableSlotDate![0]["selectedDate"];
    slotName = widget.availableSlotDate![0]["selectedSlotName"];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(const AvailableDesk());
            },
            icon: const Icon(Icons.arrow_back_outlined,
                size: 24, color: Color(0xFF000000))),
        title: Text((widget.selectedType==1)?"Available desks":"Available room",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 20,
                letterSpacing: -0.24,
                fontWeight: FontWeight.w400,
              ),
            ),),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:40,bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 195,
              height: 20,
              child: Text(
                "$date, ${widget.availableSlotDate![0]["selectedSlotName"]}",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 13,
                    letterSpacing: -0.24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                width: 312,
                height: 366,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(
                    availabledeskList.length,
                    (index) => GestureDetector(
                      onTap: () {
                        if (selectedDesk == -1) {
                          setState(() {
                            selectedDesk = availabledeskList[index]["workspace_id"];
                            workSpaceName =
                                availabledeskList[index]["workspace_name"];
                          });
                        }
                      },
                      child: Container(
                        width: 42,
                        height: 42,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: activeDesk(
                                availabledeskList[index]["workspace_active"],
                                availabledeskList[index]["workspace_id"]),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(availabledeskList[index]["workspace_name"],
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(246, 246, 246, 1),
                                fontSize: 14,
                                letterSpacing: -0.24,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                      ),
                    ),
                  ),
                )),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 56,
              margin: const EdgeInsets.only(right: 30),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(81, 103, 235, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: GestureDetector(
                onTap: () {
                  confirmation(workSpaceName, slotName, date);
                },
                child: Text("Book Desk",
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
      ),
    );
  }
}
