import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/components/profile_widget.dart';
import 'package:healman_mental_awareness/controller/login_controller.dart';
import 'package:healman_mental_awareness/pages/home.dart';
import 'package:healman_mental_awareness/pages/user/edit_profile.dart';
import 'package:healman_mental_awareness/utils/next_page.dart';
import 'package:healman_mental_awareness/utils/rounded_widget.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late double height, width;

  @override
  void initState() {
    super.initState();
    final lc = context.read<LoginController>();
    lc.getUserDataFirestore(lc.uid); // Panggil fungsi getUserDataFirestore saat halaman diinisialisasi
  }

  @override
  Widget build(BuildContext context) {
    final lc = context.watch<LoginController>();
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
                                // isi
                                Positioned(
                                  child: Wrap(
                                    children: [
                                      const SizedBox(width: 20),
                                      GestureDetector(
                                        onTap: () {
                                          nextPage(context, const HomePage());
                                        },
                                        child: Image.asset(
                                          'assets/icon/back-profile.png',
                                          width: 100,
                                        ),
                                      ),
                                    ],
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

                        // Profil
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              ProfileWidget(
                                imagePath: "${lc.imageUrl}",
                                onClicked: () async {
                                  nextPage(context, const EditProfile());
                                },
                              ),
                              const SizedBox(height: 24),
                              Column(
                                children: [
                                  Text(
                                    '${lc.name}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${lc.email}',
                                    style: const TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                              const SizedBox(height: 48),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 48),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Tentang saya",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      '${lc.bio}',
                                      style:
                                          TextStyle(fontSize: 16, height: 1.4),
                                    ),
                                  ],
                                ),
                              )
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
