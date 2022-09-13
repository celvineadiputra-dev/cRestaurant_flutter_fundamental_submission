import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crestaurant2/app/signin/signin_screen.dart';
import 'package:crestaurant2/app/widgets/custom_snack_bar_widget.dart';
import 'package:crestaurant2/utils/connection_check.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:crestaurant2/values/Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../utils/input_validation_util.dart';
import '../onboarding/onboarding_screen.dart';
import '../widgets/button_widget.dart';
import '../widgets/password_form_field_widget.dart';
import '../widgets/text_form_field_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hey,",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 35)),
              Text("Sign Up Now",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 35)),
              const SizedBox(
                height: 10,
              ),
              invitationWidget(context),
              const SizedBox(
                height: 30,
              ),
              const FormSignUp()
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBarWidget(BuildContext context) {
    return AppBar(
      title: const Text(
        "Sign Up",
        style: TextStyle(color: dark),
      ),
      leading: IconButton(
        icon: SvgPicture.asset(
          back,
          width: 30,
          color: dark,
        ),
        onPressed: () {
          Navigator.pop(
            context,
            PageTransition(
                child: const OnBoardingScreen(),
                type: PageTransitionType.topToBottomPop,
                duration: const Duration(milliseconds: 1200),
                childCurrent: this),
          );
        },
      ),
    );
  }

  Row invitationWidget(BuildContext context) {
    return Row(
      children: [
        Text(
          "If you are old user /",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: grey1),
        ),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                  child: const SignInScreen(),
                  type: PageTransitionType.bottomToTopJoined,
                  duration: const Duration(milliseconds: 1200),
                  childCurrent: this),
            );
          },
          child: Text(
            "Sign In",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: dark, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}

class FormSignUp extends StatefulWidget {
  const FormSignUp({Key? key}) : super(key: key);

  @override
  State<FormSignUp> createState() => _FormSignUpState();
}

class _FormSignUpState extends State<FormSignUp> with InputValidationUtil {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: "");
  final emailController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");
  late bool notConnected = false;

  late bool isLoading = false;

  final Map _s = {ConnectivityResult.none: false};
  final ConnectionCheck _connection = ConnectionCheck.instance;

  @override
  void initState() {
    super.initState();
    _connection.initialise();
    _connection.connectionStream.listen((_s) {
      _s = _s;

      if (_s.keys.toList()[0] == ConnectivityResult.none) {}

      if (_s.keys.toList()[0] == ConnectivityResult.mobile ||
          _s.keys.toList()[0] == ConnectivityResult.wifi) {
        if (_s.values.toList()[0] && notConnected) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.transparent,
              content: CustomSnackBarContentWidget(
                type: "success",
                label: "Connected to Internet",
              ),
            ),
          );
        }
      } else {
        notConnected = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.transparent,
            content: CustomSnackBarContentWidget(
              type: "error",
              label: "Not Connected to Internet",
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    _connection.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            valueController: nameController,
            label: "User Name",
            textInputType: TextInputType.name,
            validator: (val) {
              if (isNameValid(val!)) {
                return null;
              }
              return "User Name is not valid";
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormFieldWidget(
            valueController: emailController,
            label: "Email",
            textInputType: TextInputType.emailAddress,
            validator: (val) {
              if (isEmailValid(val!)) {
                return null;
              }
              return "Email is valid";
            },
          ),
          const SizedBox(
            height: 20,
          ),
          PasswordFormFieldWidget(
            valueController: passwordController,
            label: "Password",
            textInputType: TextInputType.visiblePassword,
            validator: (val) {
              if (isPasswordValid(val!)) {
                return null;
              }
              return "password is not valid";
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ButtonWidget(
            onPress: () async {
              if (_formKey.currentState!.validate()) {
                var connect = await Connectivity().checkConnectivity();
                if (connect == ConnectivityResult.mobile ||
                    connect == ConnectivityResult.wifi) {
                  Navigator.pushReplacementNamed(context, '/main');
                } else {
                  notConnected = true;
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.transparent,
                      content: CustomSnackBarContentWidget(
                        type: "error",
                        label: "Not Connected to Internet",
                      ),
                    ),
                  );
                }
              }
            },
            label: "Sign Up",
            isLoading: isLoading,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Term of use & Privacy Policy",
            style: TextStyle(color: grey1),
          )
        ],
      ),
    );
  }
}
