import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:projek_uts/main.dart';

// By Mohammad Usman Asegaf

final userNameController = TextEditingController();
final passwordController = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Tambahkan animasi Lottie
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 250, // Ukuran untuk menggantikan Expanded
                  child: Column(
                    children: [
                      Lottie.asset(
                        'assets/BrainLogin.json', // Path ke file JSON
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      const Text(
                        'Brain Games',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 285,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration:
                                const InputDecoration(labelText: 'Username'),
                            controller: userNameController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            obscureText: true,
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            controller: passwordController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Periksa username dan password
                              if (userNameController.text ==
                                      "Mohammad Usman Asegaf" &&
                                  passwordController.text == "2155") {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const MainNavigation();
                                }));
                              } else if (userNameController.text ==
                                      "Syamsu Nuryaman" &&
                                  passwordController.text == "2255") {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const MainNavigation();
                                }));
                              } else if (userNameController.text == "Saepul" &&
                                  passwordController.text == "333") {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const MainNavigation();
                                }));
                              } else if (userNameController.text == "Irwan" &&
                                  passwordController.text == "444") {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const MainNavigation();
                                }));
                              } else if (userNameController.text == "Ismi" &&
                                  passwordController.text == "555") {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const MainNavigation();
                                }));
                              } else if (userNameController.text == "" ||
                                  passwordController.text == "") {
                                Fluttertoast.showToast(
                                  msg: "Username / Password Tidak Boleh Kosong",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Username/Password salah",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 50)),
                            child: const Text(
                              "Masuk",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
