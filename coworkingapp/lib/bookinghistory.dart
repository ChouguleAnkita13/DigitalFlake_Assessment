import 'package:coworkingapp/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookingHistory extends StatefulWidget {
  final int? selectedType;
  const BookingHistory({super.key,this.selectedType});

  @override
  State<BookingHistory> createState() => _BookingHistory();
}

class _BookingHistory extends State<BookingHistory> {
   List bookinghistoryList = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

//GET:get_bookings:fetching booking history
  Future<void> _fetchData() async {
    final url = Uri.parse(
        'https://demo0413095.mockable.io/digitalflake/api/get_bookings');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        bookinghistoryList = data["bookings"];
      });
    } else {
      return;
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            size: 24,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        title: Text("Booking history",
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
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: bookinghistoryList.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 312,
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(245, 247, 255, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((widget.selectedType==1)?"Desk ID":"Room ID",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(137, 137, 137, 1),
                                  fontSize: 12,
                                  letterSpacing: -0.24,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          const SizedBox(
                            height: 7,
                          ),
                          Text("Name",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(137, 137, 137, 1),
                                  fontSize: 12,
                                  letterSpacing: -0.24,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          const SizedBox(
                            height: 7,
                          ),
                          Text("Booked on",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(137, 137, 137, 1),
                                  fontSize: 12,
                                  letterSpacing: -0.24,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(":  ${bookinghistoryList[index]['workspace_id']}",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(30, 30, 30, 1),
                                  fontSize: 14,
                                  letterSpacing: -0.24,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(":  ${bookinghistoryList[index]['workspace_name']}",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(30, 30, 30, 1),
                                  fontSize: 14,
                                  letterSpacing: -0.24,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(":  ${bookinghistoryList[index]['booking_date']}",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(30, 30, 30, 1),
                                  fontSize: 14,
                                  letterSpacing: -0.24,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
