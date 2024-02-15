import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/components/profile_widget.dart';
import 'package:healman_mental_awareness/components/textfield_widget.dart';
import 'package:healman_mental_awareness/controller/login_controller.dart';
import 'package:healman_mental_awareness/pages/user/profile.dart';
import 'package:healman_mental_awareness/utils/next_page.dart';
import 'package:healman_mental_awareness/utils/rounded_widget.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  late double height, width;

  @override
  Widget build(BuildContext context) {
    final lc = context.watch<LoginController>();
    final RoundedLoadingButtonController buttonController =
        RoundedLoadingButtonController();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.blue.shade100,
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(),
              height: height * 0.12,
              width: width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 55,
                      left: 15,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icon/logo_polos.png',
                          width: 50,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'Healman',
                          style: TextStyle(
                            color: Colors.indigo.shade800,
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins-SemiBold',
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: roundedWidget(),
                    height: height * 0.88,
                    width: width,
                    child: Container(),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: roundedWidget(),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              left: 2,
                              bottom: 15,
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: RoundedLoadingButton(
                                    onPressed: () {
                                      nextPage(context, const ProfilePage());
                                      buttonController.success();
                                      buttonController.reset();
                                    },
                                    height: 32,
                                    width: 100,
                                    elevation: 0,
                                    controller: buttonController,
                                    successColor: Colors.green,
                                    color: Colors.transparent,
                                    valueColor: Colors.white,
                                    borderRadius: 15,
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 20),
                                        Image.asset(
                                          'assets/icon/back-edit-profile.png',
                                          width: 130,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 0.8,
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              ProfileWidget(
                                imagePath: "${lc.imageUrl}",
                                onClicked: () async {},
                                isEdit: true,
                              ),
                              const SizedBox(height: 24),
                              TextFieldWidget(
                                label: 'Nama Lengkap',
                                text: '${lc.name}',
                                onChanged: (value) {},
                              ),
                              const SizedBox(height: 24),
                              TextFieldWidget(
                                label: 'Tentang Saya',
                                text: '',
                                maxLines: 5,
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                      ],
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
