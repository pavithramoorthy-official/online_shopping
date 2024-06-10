import 'package:flutter/material.dart';
import 'package:grocery_shopping/widgets/authentication_button.dart';
//import 'package:grocery_shopping/widgets/back_widget.dart';
import 'package:grocery_shopping/widgets/text_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  static const routeName = '/ForgotPasswordScreen';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  void _forgotPassworfFunction() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                TextWidget(
                  text: 'Forget password',
                  color: Colors.white,
                  textSize: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  controller: _emailTextController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white54),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                AuthenticationButton(
                    fcn: () {
                      _forgotPassworfFunction();
                    },
                    buttonText: 'Reset Now'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
