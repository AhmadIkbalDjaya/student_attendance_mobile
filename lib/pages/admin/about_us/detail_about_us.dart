import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:student_attendance/bloc/admin/about_us/about_us_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/models/admin/about_us.dart';
import 'package:student_attendance/values/theme.dart';

class AdminDetailAboutUsPage extends StatelessWidget {
  const AdminDetailAboutUsPage({super.key, required this.aboutUsId});
  final int aboutUsId;

  @override
  Widget build(BuildContext context) {
    AboutUsBloc aboutUsBloc = context.read<AboutUsBloc>();
    aboutUsBloc.add(GetDetailAboutUsEvent(aboutUsId: aboutUsId));
    return WillPopScope(
      onWillPop: () async {
        aboutUsBloc.add(GetAllAboutUsEvent());
        return true;
      },
      child: Scaffold(
        appBar: const MyAppBar(),
        drawer: const MyDrawer(),
        body: Column(
          children: [
            Container(
              decoration: CustomTheme.headerDecoration(),
              padding: const EdgeInsets.only(
                  top: 0, bottom: 10, right: 10, left: 10),
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          "Informasi AboutUs",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Datail Informasi AboutUs",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: BackButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                        aboutUsBloc.add(GetAllAboutUsEvent());
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<AboutUsBloc, AboutUsState>(
                builder: (context, state) {
                  AboutUs aboutUs = state is AboutUsDetailSuccess
                      ? state.aboutUs
                      : dummtAboutUses[0];
                  return ListView(
                    children: [
                      Skeletonizer(
                        enabled: state is! AboutUsDetailSuccess,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 15,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 25,
                            horizontal: 30,
                          ),
                          decoration: CustomTheme.contentDecoration(),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                aboutUs.name,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                aboutUs.position,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.email_outlined,
                                    size: 25,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    aboutUs.email,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    size: 25,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    aboutUs.phone,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
