import 'package:flutter/material.dart';
import 'package:learning_auth/auth/google_auth.dart';
import 'package:learning_auth/map/show_google_map.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

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
              const SizedBox(height: 20),
              _commonButton('Sign In With Google', _signInWithGoogle),
              const SizedBox(height: 20),
              _commonButton(
                  'Sign Out From Google', () => GoogleAuth.logout(context)),
              const SizedBox(height: 20),
              _commonButton('Open Google Map', _showPositionInGoogleMap),
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

  void _signInWithGoogle() async {
    final _googleAuthData = await GoogleAuth.signIn(context);

    if (_googleAuthData.isEmpty) return;

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              title: const Text(
                'Google Login Data',
                style: TextStyle(fontSize: 20),
              ),
              content: Container(
                width: double.maxFinite,
                height: 250,
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey.withOpacity(0.4),
                        backgroundImage:
                            NetworkImage(_googleAuthData['profile_pic'] ?? ''),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Email: ${_googleAuthData['email'] ?? ""}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Name: ${_googleAuthData['name'] ?? ""}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                    ]),
              ),
            ));
  }

  void _showPositionInGoogleMap() async {
    final _location = Location();

    if (!(await _location.serviceEnabled())) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location Service not enabled')));
      return;
    }

    if (await _location.hasPermission() != PermissionStatus.granted) {
      final _locationPermissionStatus = await _location.requestPermission();
      if (_locationPermissionStatus != PermissionStatus.granted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location Permission Denied')));
        return;
      }
    }

    final _locationData = await _location.getLocation();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => GoogleMapScreeen(
            latitude: _locationData.latitude ?? 0.0,
            longitude: _locationData.longitude ?? 0.0)));
  }
}
