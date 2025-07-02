import "package:flutter/material.dart";

import "authservice.dart";
import "signup.dart";
import "ConfigColors.dart";

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});
  @override
  State<StatefulWidget> createState() => _SigninScreen();
}

class _SigninScreen extends State<SigninScreen> {
  final _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {"phone": "", "password": ""};

  bool _loading = false;
  void _doSignIn() async {
    if (!_formkey.currentState!.validate()) return;
    _formkey.currentState!.save();
    setState(() => _loading = true);
    final error = await _auth.signupUser(_formData);
    setState(() => _loading = false);
    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup success! Please login.")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolors.backgroColor,
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              _buildfield("First Name", "firstName"),
              _buildfield("Last Name", "lastName"),
              _buildfield("Phone No", "phone"),
              _buildfield("Email", "email"),
              _buildfield("Password", "password", obscure: true),
              _buildfield("Enter a short description", "bio", obscure: true),
              SwitchListTile(
                title: const Text(
                  "Are you an organisation?",
                  style: TextStyle(color: Colors.white),
                ),
                value: _formData["isOrganisation"],
                onChanged: (val) {
                  setState(() {
                    _formData["isOrganisation"] = val;
                  });
                },
              ),

              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _loading ? null : _doSignIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildfield(String label, String key, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: TextFormField(
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.white38),
          filled: true,
          fillColor: Colors.grey[850],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
        onSaved: (v) => _formData[key] = v ?? "",
      ),
    );
  }
}
