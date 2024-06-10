import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_shopping/Auth/forget_password.dart';
import 'package:grocery_shopping/Auth/login_screen.dart';
import 'package:grocery_shopping/constants/firebase_consts.dart';
import 'package:grocery_shopping/provider/dark_theme_provider.dart';
import 'package:grocery_shopping/screens/bottom_bar.dart';
import 'package:grocery_shopping/screens/orders/order_screen.dart';
import 'package:grocery_shopping/screens/viewed/viewed_screen.dart';
import 'package:grocery_shopping/screens/wishlist/wishlist_screen.dart';
import 'package:grocery_shopping/services/global_methods.dart';
import 'package:grocery_shopping/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void dispose() {
    _updateAddressController.dispose();
    super.dispose();
  }

  final TextEditingController _updateAddressController =
      TextEditingController();

  final User? user = firebaseAuthObject.currentUser;
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    text: "Hi, ",
                    style: const TextStyle(
                      fontSize: 27,
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Name',
                          style: TextStyle(
                            fontSize: 25,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("Tapped name");
                            }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(text: 'email@email.com', color: color, textSize: 18),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                _listtile(
                  titileName: "Address",
                  subtitleName: "Address 2",
                  iconName: IconlyLight.profile,
                  onpressed: () async {
                    await _updateAddressDialogue();
                  },
                  color: color,
                ),
                _listtile(
                  titileName: "Orders",
                  iconName: IconlyLight.bag,
                  onpressed: () {
                    GlobalMethods.navigateTo(
                        ctx: context, routeName: OrderScreen.routeName);
                  },
                  color: color,
                ),
                _listtile(
                  titileName: "Wishlist",
                  iconName: IconlyLight.heart,
                  onpressed: () {
                    GlobalMethods.navigateTo(
                        ctx: context, routeName: WishlistScreen.routeName);
                  },
                  color: color,
                ),
                _listtile(
                  titileName: "Viewed",
                  iconName: IconlyLight.show,
                  onpressed: () {
                    GlobalMethods.navigateTo(
                        ctx: context,
                        routeName: ViewedRecentlyScreen.routeName);
                  },
                  color: color,
                ),
                _listtile(
                  titileName: "Forgot Password",
                  iconName: IconlyLight.unlock,
                  onpressed: () {
                    GlobalMethods.navigateTo(
                        ctx: context, routeName: ForgotPassword.routeName);
                  },
                  color: color,
                ),
                SwitchListTile(
                  activeColor: Colors.lightBlueAccent.shade200,
                  title: TextWidget(
                    text: themeState.getDarkTheme ? 'Dark Mode' : 'Light Mode',
                    color: color,
                    textSize: 22,
                  ),
                  secondary: Icon(themeState.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined),
                  value: themeState.getDarkTheme,
                  onChanged: (bool value) {
                    setState(() {
                      themeState.setDarkThemeProvider = value;
                    });
                  },
                ),
                _listtile(
                  titileName: user == null ? 'Login' : "Logout",
                  iconName:
                      user == null ? IconlyLight.login : IconlyLight.logout,
                  onpressed: () {
                    if (user == null) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                      return;
                    }
                    GlobalMethods.warningDialogue(
                        title: 'Logout',
                        subtitle: 'Do you want to Logout?',
                        fcn: () async {
                          await firebaseAuthObject.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        context: context);
                  },
                  color: color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateAddressDialogue() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Address"),
            content: TextField(
              maxLines: 5,
              controller: _updateAddressController,
              onChanged: (value) {
                print(_updateAddressController.text);
                //_updateAddressController.text;
              },
              decoration: const InputDecoration(
                hintText: "your address",
              ),
            ),
            actions: [
              TextButton(onPressed: () {}, child: const Text("Update"))
            ],
          );
        });
  }
}

Widget _listtile(
    {required String titileName,
    String? subtitleName,
    required IconData iconName,
    required Function onpressed,
    required Color color}) {
  return ListTile(
      leading: Icon(iconName),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onpressed();
      },
      title: TextWidget(
        text: titileName,
        color: color,
        textSize: 22,
        //isTitle: true,
      ),
      subtitle: TextWidget(
        text: subtitleName ?? "",
        color: color,
        textSize: 18,
      ));
}
