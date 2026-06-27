import 'package:flutter/material.dart';

import '../../widget/custom_button.dart';
import '../../widget/custom_textfield.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const SizedBox(height: 20),

              const Icon(Icons.shopping_cart, size: 90, color: Colors.blue),

              const SizedBox(height: 20),

              const Text(
                "MyCashier",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text("Silakan login", textAlign: TextAlign.center),

              const SizedBox(height: 40),

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

              const SizedBox(height: 30),

              CustomButton(text: "LOGIN", onPressed: () {}),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum punya akun?"),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterScreen()),
                      );
                    },
                    child: const Text("Daftar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
