import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isVisibilityPassword = true;
  bool isVisibilityConfirmPassword = true;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Register",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "email",
                      prefixIcon: Icon(Icons.email),
                    ),
                    onChanged: (value) {
                      setState(() {
                        error = null;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "field must not ne empty";
                      } else if (error != null) {
                        return error;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: isVisibilityPassword,
                    decoration: InputDecoration(
                        labelText: "pssword",
                        prefixIcon: const Icon(Icons.lock),
                        suffix: Builder(builder: (context) {
                          return IconButton(
                            onPressed: () {
                              setState(() {
                                isVisibilityPassword = !isVisibilityPassword;
                              });
                            },
                            icon: isVisibilityPassword
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          );
                        })),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "field must not ne empty";
                      } else if (value.length < 6) {
                        return "password must not be less that 6";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: isVisibilityConfirmPassword,
                    decoration: InputDecoration(
                      labelText: "confirm password",
                      prefixIcon: const Icon(Icons.lock),
                      suffix: Builder(
                        builder: (context) {
                          return IconButton(
                            onPressed: () {
                              setState(() {
                                isVisibilityConfirmPassword =
                                    !isVisibilityConfirmPassword;
                              });
                            },
                            icon: isVisibilityConfirmPassword
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          );
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "field must not ne empty";
                      } else if (value.length < 6) {
                        return "password must not be less that 6";
                      } else if (passwordController.text != value) {
                        return "passwords don't match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        } on FirebaseAuthException catch (e) {
                          print(e);
                          setState(() {
                            error = e.message;
                          });
                        }
                      }
                    },
                    child: const Text("Register"),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("already have an account?",
                          style: Theme.of(context).textTheme.labelLarge),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/loginPage");
                        },
                        child: Text(
                          "Login",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
