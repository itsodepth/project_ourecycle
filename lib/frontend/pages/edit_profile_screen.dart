import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController(
    text: 'Shin Soo Hyun',
  ); // <-- 1. Tambahkan controller untuk nama
  final TextEditingController emailController = TextEditingController(
    text: 'xinsoo2290@gmail.com',
  ); // <-- 1. Tambahkan controller untuk email
  final TextEditingController phoneController = TextEditingController(
    text: '089674577831',
  ); // <-- 1. Tambahkan controller untuk no. telp
  final TextEditingController addressController = TextEditingController(
    text: 'Perum Griya Tiara Allam, Dusun I, Gumpang',
  ); // <-- 1. Tambahkan controller untuk alamat

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.green),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.green),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      'assets/images/profile.jpg',
                    ), // Ganti dengan path lokal kamu
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.green,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            _buildTextField(
              "Nama Lengkap",
              nameController,
            ), // <-- 2. Tambahkan controller untuk nama
            _buildTextField(
              "Email",
              emailController,
              isEmail: true,
            ), // <-- 2. Tambahkan controller untuk email
            _buildTextField(
              "No. Telp",
              phoneController,
            ), // <-- 2. Tambahkan controller untuk no. telp
            _buildTextField(
              "Alamat",
              addressController,
            ), // <-- 2. Tambahkan controller untuk alamat

            const SizedBox(height: 35),

            ElevatedButton(
              onPressed: () {
                // buat nyimpen data nanti disini
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Simpan',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            const SizedBox(height: 15),

            OutlinedButton(
              onPressed: () {
                // ini buat diarahin ke page ganti password
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Ubah Password',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isEmail = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Text("*", style: TextStyle(color: Colors.green)),
          ],
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          style: const TextStyle(fontWeight: FontWeight.bold),
          decoration: const InputDecoration(border: UnderlineInputBorder()),
        ),
      ],
    );
  }
}
