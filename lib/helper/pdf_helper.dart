import 'dart:io';
import 'dart:typed_data';

import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_attendance/models/teacher/course_recap.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfHelper {
  static getPDF(CourseRecap courseRecap) async {
    // void getPDF(CourseRecap courseRecap) async {
    try {
      Course course = courseRecap.course;
      final pdf = pw.Document();

      final font = await rootBundle.load("assets/fonts/OpenSans.ttf");
      final ttf = pw.Font.ttf(font);
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(
                "Hello World",
                style: pw.TextStyle(font: ttf),
              ),
            );
          },
        ),
      );

      Uint8List bytes = await pdf.save();

      // final dir = await getApplicationDocumentsDirectory();
      final dir = await getExternalStorageDirectory();

      final file = await File('${dir?.path}/recap-${course.courseName}.pdf');
      // final file = File('${dir?.path}/recap.pdf');

      await file.writeAsBytes(bytes);
      DocumentFileSavePlus().saveFile(bytes, "recap.pdf", "application/pdf");
      await OpenFile.open(file.path);
      print(file.path);
    } catch (e) {
      print(e);
    }
  }
}
