import 'package:flutter/material.dart';
import 'package:healman_mental_awareness/components/profile_widget.dart';
import 'package:healman_mental_awareness/components/textfield_widget.dart';
import 'package:healman_mental_awareness/controller/login_controller.dart';
import 'package:healman_mental_awareness/utils/rounded_widget.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  late double height, width;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool isEditLoading = false;

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final lc = context.watch<LoginController>();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    // Initialize text field controllers with existing user data
    nameController.text = lc.name ?? '';
    bioController.text = lc.bio ?? '';

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Colors.blue.shade100,
        height: height,
        width: width,
        child: Column(
          children: [
            // Header Section
            Container(
              height: height * 0.12,
              width: width,
              color: Colors.blue.shade100,
              child: Column(
                children: [
                  Container(
                    height: height * 0.038,
                    color: Colors.blue.shade100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(
                              'assets/icon/back-edit-profile.png',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Main Content
            Expanded(
              child: Container(
                decoration: roundedWidget(),
                width: width,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        ProfileWidget(
                          imagePath: "${lc.imageUrl}",
                          onClicked: () async {},
                          isEdit: true,
                        ),
                        const SizedBox(height: 30),
                        TextFieldWidget(
                          label: 'Nama Lengkap',
                          text: lc.name ?? '',
                          onChanged: (value) {
                            context.read<LoginController>().updateName(value);
                          },
                        ),
                        const SizedBox(height: 24),
                        TextFieldWidget(
                          label: 'Tentang Saya',
                          text: lc.bio ?? '',
                          maxLines: 5,
                          onChanged: (value) {
                            context.read<LoginController>().updateBio(value);
                          },
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: isEditLoading
                                ? null
                                : () async {
                                    setState(() {
                                      isEditLoading = true;
                                    });

                                    try {
                                      // Update user data in Firestore
                                      await context
                                          .read<LoginController>()
                                          .updateDataUsers();

                                      if (mounted) {
                                        // Show success message
                                        _showSuccessSnackBar(
                                            'Data berhasil diubah');
                                      }
                                    } catch (e) {
                                      if (mounted) {
                                        _showErrorSnackBar(
                                            'Gagal mengubah data: $e');
                                      }
                                    } finally {
                                      if (mounted) {
                                        setState(() {
                                          isEditLoading = false;
                                        });
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade600,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isEditLoading
                                ? LoadingAnimationWidget.staggeredDotsWave(
                                    color: Colors.white,
                                    size: 20,
                                  )
                                : const Text(
                                    'Simpan Perubahan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
