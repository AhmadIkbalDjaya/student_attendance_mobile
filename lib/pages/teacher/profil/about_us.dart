import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:student_attendance/bloc/admin/about_us/about_us_bloc.dart';
import 'package:student_attendance/components/my_bottom_nav_bar.dart';
import 'package:student_attendance/cubit/teacher_tab_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/models/about_us.dart';
import 'package:student_attendance/values/theme.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherTabBloc teacherTab = context.read<TeacherTabBloc>();
    AboutUsBloc aboutUsBloc = context.read<AboutUsBloc>();
    aboutUsBloc.add(GetAllAboutUsEvent());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          "Tentang Kami",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<AboutUsBloc, AboutUsState>(
        builder: (context, state) {
          return Skeletonizer(
            enabled: state is! AboutUsAllSuccess,
            child: ListView.builder(
              itemCount: state is AboutUsAllSuccess
                  ? state.aboutUses.length
                  : dummtAboutUses.length,
              itemBuilder: (context, index) {
                AboutUs aboutUs = state is AboutUsAllSuccess
                    ? state.aboutUses[index]
                    : dummtAboutUses[index];
                return TileBox(aboutUs: aboutUs);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: MyBottomNavBar(teacherTab: teacherTab),
    );
  }
}

class TileBox extends StatelessWidget {
  const TileBox({
    super.key,
    required this.aboutUs,
  });
  final AboutUs aboutUs;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: CustomTheme.contentDecoration(),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF696CFF),
          child: Skeleton.ignore(
            child: Text(
              aboutUs.name[0],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        title: Text(
          aboutUs.name,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(aboutUs.position),
                Text(aboutUs.email),
              ],
            ),
            Text(aboutUs.phone),
          ],
        ),
        // trailing: Icon(Icons.phone),
        style: ListTileStyle.list,
      ),
    );
  }
}
