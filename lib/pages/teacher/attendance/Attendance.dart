import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 0),
            color: const Color(0xFFD9D9D9),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    children: [
                      const Text(
                        "Pertemuan 1",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Bahasa Indonesia XII IPA 1",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.people),
                              SizedBox(width: 10),
                              Text(
                                "30 Peserta",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "15 Oktober 2023",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.date_range),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Keterangan",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "H",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: " : "),
                                      TextSpan(text: "Hadir"),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "S",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: " : "),
                                      TextSpan(text: "Sakit"),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "I",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: " : "),
                                      TextSpan(text: "Izin"),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "A",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: " : "),
                                      TextSpan(text: "Alfa"),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 3),
              child: ListView(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(
                        width: 2,
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      columns: const [
                        DataColumn(
                          label: Text(
                            "No",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Nama",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "NIS",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "L/P",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 18),
                              Text(
                                "H",
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(width: 40),
                              Text(
                                "S",
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(width: 40),
                              Text(
                                "I",
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(width: 40),
                              Text(
                                "A",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            const DataCell(
                              Text("1"),
                            ),
                            const DataCell(
                              Text("Ahmad Ikbal Djaya"),
                            ),
                            const DataCell(
                              Text("60200120073"),
                            ),
                            const DataCell(
                              Text("P"),
                            ),
                            DataCell(
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Radio(
                                    value: "H",
                                    groupValue: "s",
                                    onChanged: (value) {},
                                  ),
                                  Radio(
                                    value: "H",
                                    groupValue: "s",
                                    onChanged: (value) {},
                                  ),
                                  Radio(
                                    value: "H",
                                    groupValue: "s",
                                    onChanged: (value) {},
                                  ),
                                  Radio(
                                    value: "H",
                                    groupValue: "s",
                                    onChanged: (value) {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF696CFF),
                    ),
                    child: const Text("Simpan"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
