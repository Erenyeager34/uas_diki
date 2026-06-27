import 'package:flutter/material.dart';

import '../../widget/custom_button.dart';
import '../../widget/custom_textfield.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final konfirmasiController = TextEditingController();

  bool isLoading = false;

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register Kasir")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 20),

                CustomTextField(
                  label: "Nama",
                  controller: namaController,
                  icon: Icons.person,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  label: "Email",
                  controller: emailController,
                  icon: Icons.email,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  label: "Password",
                  controller: passwordController,
                  icon: Icons.lock,
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  label: "Konfirmasi Password",
                  controller: konfirmasiController,
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),

                const SizedBox(height: 30),

                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: "DAFTAR",
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          if (passwordController.text !=
                              konfirmasiController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Konfirmasi password tidak sesuai",
                                ),
                              ),
                            );

                            return;
                          }

                          setState(() {
                            isLoading = true;
                          });

                          String? result = await authService.register(
                            nama: namaController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                          setState(() {
                            isLoading = false;
                          });

                          if (result == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Register berhasil"),
                              ),
                            );

                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(result)));
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
