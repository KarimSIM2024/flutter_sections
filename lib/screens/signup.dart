import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';
import '../utiles/shared_pref.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmController = TextEditingController();

  bool hidePass = true;
  bool hideConfirm = true;
  bool acceptedTerms = false; // State variable for terms

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Future<void> onSignup() async {
    if (!formKey.currentState!.validate()) return;

    // Check for terms acceptance
    if (!acceptedTerms) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please accept the terms and conditions")),
        );
      }
      return;
    }

    final email = emailController.text.trim();
    final username = usernameController.text.trim();
    final pass = passController.text;

    // Check if user already exists
    bool exists = await AuthPrefs.checkIfUserExists(email);
    if (exists) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User already exists")),
        );
      }
      return;
    }

    await AuthPrefs.saveUser(username: username, email: email, password: pass);
    if (mounted) {
      // Navigation: After a successful signup, navigate to the Login page
      Navigator.pushNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Signup",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                const Text("Full Name", style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: "Karim Wael",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  validator: (v) {
                    final value = v?.trim() ?? "";
                    if (value.isEmpty) return "Username is required";
                    if (value.length < 3) return "Username must be 3+ chars";
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text("Email Address", style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "example@email.com",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  validator: (v) {
                    final value = v?.trim() ?? "";
                    if (value.isEmpty) return "Email is required";
                    if (!value.contains("@")) return "Enter a valid email";
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text("Password", style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: passController,
                  obscureText: hidePass,
                  decoration: InputDecoration(
                    hintText: "********",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    suffixIcon: IconButton(
                      icon: Icon(hidePass ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      onPressed: () => setState(() => hidePass = !hidePass),
                    ),
                  ),
                  validator: (v) {
                    final value = v ?? "";
                    if (value.isEmpty) return "Password is required";
                    if (value.length < 8) return "Password must be 8+ chars";
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text("Confirm Password", style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: confirmController,
                  obscureText: hideConfirm,
                  decoration: InputDecoration(
                    hintText: "********",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    suffixIcon: IconButton(
                      icon: Icon(hideConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      onPressed: () => setState(() => hideConfirm = !hideConfirm),
                    ),
                  ),
                  validator: (v) {
                    final value = v ?? "";
                    if (value.isEmpty) return "Confirm password is required";
                    if (value != passController.text) return "Passwords do not match";
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CheckboxListTile(
                  value: acceptedTerms,
                  onChanged: (v) => setState(() => acceptedTerms = v ?? false),
                  title: const Text(
                    "By Creating an Account, i accept Hiring Hub terms of Use and Privacy Policy",
                    style: TextStyle(fontSize: 12),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onSignup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[400],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    child: const Text("Signup"),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have an Account? "),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.login),
                      child: const Text(
                        "Sign in here",
                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
