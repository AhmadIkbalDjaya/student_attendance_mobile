import 'package:flutter/material.dart';
import 'package:student_attendance/bloc/admin/about_us/about_us_bloc.dart';
import 'package:student_attendance/components/admin/my_app_bar.dart';
import 'package:student_attendance/components/admin/my_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/components/my_snack_bar.dart';
import 'package:student_attendance/values/theme.dart';

class AdminCreateAboutUsPage extends StatelessWidget {
  AdminCreateAboutUsPage({super.key});
  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AboutUsBloc aboutUsBloc = context.read<AboutUsBloc>();
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
                          "Tambahkan AboutUs",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Tambahkan AboutUs pada colom di bawah",
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
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 15,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 10,
                    ),
                    decoration: CustomTheme.contentDecoration(),
                    child: Column(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            label: Text("Nama"),
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 25),
                        TextField(
                          controller: positionController,
                          decoration: const InputDecoration(
                            label: Text("Posisi"),
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 25),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            label: Text("Email"),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 25),
                        TextField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            label: Text("Nomor Telepon"),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: BlocConsumer<AboutUsBloc, AboutUsState>(
                      listener: (context, state) {
                        if (state is AboutUsAddSuccess) {
                          Navigator.pushNamed(context, "/admin/aboutUs");
                          showCostumSnackBar(
                            context: context,
                            message: "AboutUs behasil ditambahkan",
                            type: "success",
                          );
                        } else if (state is AboutUsValidationError) {
                          showCostumSnackBar(
                            context: context,
                            message: state.message,
                            type: "danger",
                          );
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            state is AboutUsLoading
                                ? null
                                : aboutUsBloc.add(AddAboutUsEvent(
                                    name: nameController.text,
                                    position: positionController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                  ));
                          },
                          child: Text(
                            state is AboutUsLoading ? "Simpan..." : "Simpan",
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
