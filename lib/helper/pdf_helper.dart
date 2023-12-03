import 'dart:io';
import 'dart:typed_data';

import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_attendance/models/teacher/course_recap.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:student_attendance/values/auth.dart';

class PdfHelper {
  static getPDF(CourseRecap courseRecap) async {
    Course course = courseRecap.course;
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          return [
            docHeader(),
            pw.SizedBox(height: 10),
            recapDetail(courseRecap),
            pw.SizedBox(height: 10),
            recapTable(courseRecap),
          ];
        },
      ),
    );

    Uint8List bytes = await pdf.save();

    final dir = await getExternalStorageDirectory();

    final file = await File('${dir?.path}/recap-${course.courseName}.pdf');

    await file.writeAsBytes(bytes);
    DocumentFileSavePlus()
        .saveFile(bytes, "recap-${course.courseName}.pdf", "application/pdf");
    await OpenFile.open(file.path);
  }

  static pw.Table recapTable(CourseRecap courseRecap) {
    return pw.Table(
      border: const pw.TableBorder(
        bottom: pw.BorderSide(width: 1),
        top: pw.BorderSide(width: 1),
        right: pw.BorderSide(width: 1),
        left: pw.BorderSide(width: 1),
        horizontalInside: pw.BorderSide(width: 1),
        verticalInside: pw.BorderSide(width: 1),
      ),
      children: [
        pw.TableRow(
          children: [
            pw.Center(
              child: pw.Text(
                "No",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Center(
              child: pw.Text(
                "NIS",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Center(
              child: pw.Text(
                "Nama Lengkap",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Center(
              child: pw.Text(
                "L/P",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Center(
              child: pw.Text(
                "H",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Center(
              child: pw.Text(
                "S",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Center(
              child: pw.Text(
                "I",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Center(
              child: pw.Text(
                "A",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        for (var i = 0; i < courseRecap.studentsRecap.length; i++)
          pw.TableRow(
            children: [
              pw.Center(
                child: pw.Text("${i + 1}"),
              ),
              pw.Text(courseRecap.studentsRecap[i].nis),
              pw.Text(courseRecap.studentsRecap[i].name),
              pw.Center(
                child: pw.Text(
                  courseRecap.studentsRecap[i].gender == "male" ? "L" : "P",
                ),
              ),
              pw.Center(
                child: pw.Text(
                  courseRecap.studentsRecap[i].hCount.toString(),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  courseRecap.studentsRecap[i].sCount.toString(),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  courseRecap.studentsRecap[i].iCount.toString(),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  courseRecap.studentsRecap[i].aCount.toString(),
                ),
              ),
            ],
          ),
      ],
    );
  }

  static pw.Column recapDetail(CourseRecap courseRecap) {
    Course course = courseRecap.course;
    return pw.Column(
      children: [
        pw.Text(
          "REKAP ABSENSI MAPEL",
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 5),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              children: [
                detailItem("Nama Kelas", course.claass, 120),
                detailItem("Mata Pelajaran", course.courseName, 120),
                detailItem("Guru Pengajar", Auth.name.toString(), 120),
              ],
            ),
            pw.Column(
              children: [
                detailItem(
                  "Jumlah Siswa",
                  courseRecap.studentsRecap.length.toString(),
                  120,
                ),
                detailItem(
                  "Jumlah Pertemuan",
                  course.attendanceCount.toString(),
                  120,
                ),
                detailItem(
                  "Tahun Ajaran",
                  course.semester,
                  120,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  static pw.Column docHeader() {
    return pw.Column(
      children: [
        pw.Text(
          "YAYASAN AL-MA'ARIF POMPANUA\nKAB. BONE",
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            fontSize: 20,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          "Jl. Ahmad Yani No. 97 Kelurahan Pompanua, Telp : 085 398 947 261",
        ),
        pw.Divider(
          height: 2,
          color: PdfColors.grey,
        ),
      ],
    );
  }

  static pw.Row detailItem(String key, String value, double width) {
    return pw.Row(
      children: [
        pw.SizedBox(
          width: width,
          child: pw.Text(key),
        ),
        pw.SizedBox(
          width: width,
          child: pw.Text(": $value"),
        ),
      ],
    );
  }
}
