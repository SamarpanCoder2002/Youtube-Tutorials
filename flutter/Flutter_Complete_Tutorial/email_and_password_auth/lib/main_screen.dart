import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isShowPassword = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: _isLoading,
        progressIndicator: const CircularProgressIndicator(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              _commonTextField('Email', _emailController,
                  validator: _emailValidator),
              const SizedBox(height: 20),
              _commonTextField('Password', _passwordController,
                  validator: _passwordValidator,
                  isSuffixIconShow: true,
                  showText: _isShowPassword),
              const SizedBox(height: 20),
              _commonButton('Sign In', _signIn),
              const SizedBox(height: 20),
              _commonButton('Sign Up', _signUp),
            ]),
          ),
        ),
      ),
    );
  }

  _commonTextField(String hintText, TextEditingController controller,
      {required String? Function(String?)? validator,
      bool showText = true,
      bool isSuffixIconShow = false}) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      obscureText: !showText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.black54),
        suffixIcon: !isSuffixIconShow
            ? null
            : IconButton(
                color: Colors.black,
                onPressed: () {
                  if (!mounted) return;

                  setState(() {
                    _isShowPassword = !_isShowPassword;
                  });
                },
                icon: Icon(_isShowPassword
                    ? Icons.visibility_off
                    : Icons.remove_red_eye_outlined),
              ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red)),
      ),
    );
  }

  String? _emailValidator(String? inputVal) {
    if (inputVal == null || inputVal.isEmpty) return 'Provide a valid email';

    final RegExp _emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!_emailRegex.hasMatch(_emailController.text)) {
      return 'Email format not correct';
    }

    return null;
  }

  String? _passwordValidator(String? inputVal) {
    if (inputVal == null || inputVal.isEmpty) return 'Provide a valid email';

    if (inputVal.length < 6) return 'Password must be at lest 6 characters';

    return null;
  }

  _commonButton(String text, VoidCallback onTapManually) {
    return ElevatedButton(
        onPressed: onTapManually,
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ));
  }

  void _signIn() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _isLoading = true;
    setState(() {});

    final _userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);

    _isLoading = false;
    setState(() {});

    final _isUserSignIn = _userCred.user!.email!.isNotEmpty;

    if (_isUserSignIn) {
      _userDataDialog(_userCred.user?.email ?? '');
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_isUserSignIn ? 'Login Successful' : 'Login Failed')));
  }

  void _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _isLoading = true;
    setState(() {});

    final _userCred = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

    _isLoading = false;
    setState(() {});

    final _isUserProfileCreated = _userCred.user!.email!.isNotEmpty;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_isUserProfileCreated
            ? 'User Created Successfully'
            : 'User Profile creation failed')));
  }

  void _userDataDialog(String email) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                'Email: $email',
                style: const TextStyle(fontSize: 16),
              ),
            ));
  }
}
