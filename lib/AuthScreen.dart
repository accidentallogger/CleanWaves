import 'package:flutter/material.dart';
import 'authservice.dart';
import 'home_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = AuthService();
  bool _isSignup = false;
  bool _loading = false;

  final Map<String, dynamic> _formData = {
    "firstName": "",
    "lastName": "",
    "phone": "",
    "email": "",
    "password": "",
    "bio": "",
    "isOrganisation": false,
  };

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _loading = true);
    String? error;

    if (_isSignup) {
      error = await _auth.signupUser(_formData);
    } else {
      error = await _auth.loginUser(_formData["phone"], _formData["password"]);
    }

    setState(() => _loading = false);

    if (error == null) {
      if (_isSignup) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signup success! Please login.")),
        );
        setState(() => _isSignup = false);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  Widget _buildField(String label, String key, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isSignup ? "Sign Up" : "Sign In")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_isSignup) ...[
                _buildField("First Name", "firstName"),
                _buildField("Last Name", "lastName"),
                _buildField("Email", "email"),
                _buildField("Bio", "bio"),
                SwitchListTile(
                  title: const Text(
                    "Are you an organisation?",
                    style: TextStyle(color: Colors.white),
                  ),
                  value: _formData["isOrganisation"],
                  onChanged: (val) =>
                      setState(() => _formData["isOrganisation"] = val),
                ),
              ],
              _buildField("Phone", "phone"),
              _buildField("Password", "password", obscure: true),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(_isSignup ? "Sign Up" : "Sign In"),
              ),
              TextButton(
                onPressed: () => setState(() => _isSignup = !_isSignup),
                child: Text(
                  _isSignup
                      ? "Already have an account? Sign In"
                      : "No account? Sign Up",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
