import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/utils/common.dart';
import 'package:flutter_demo/ui/widgets/back_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackButton(),
              const SizedBox(height: 10),
              const Text(
                'Forget Password',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/images/reset_password.png',
                ),
              ),
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  'Please enter your email address, you will receive a link to create a new password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF535353),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onFieldSubmitted: (value) {
                  print(value);
                },
                onChanged: (value) {
                  print(value);
                },
                decoration: textFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                  prefixIcon: const Icon(
                    Icons.email,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(30),
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.amberAccent,
                      ),
                      child: MaterialButton(
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80),
                          child: Text(
                            'Send',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
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
