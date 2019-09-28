import 'package:digitalcontest_mobile/components/button/button.dart';
import 'package:digitalcontest_mobile/components/input/input.dart';
import 'package:digitalcontest_mobile/constants/routes/routes.dart';
import 'package:digitalcontest_mobile/store/auth_store.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  static RootStore of(context) =>
      ScopedModel.of(context, rebuildOnChange: true);

  TextEditingController phoneController;
  TextEditingController passwordController;

  Widget buildLoginForm() {
    return Column(
      children: <Widget>[
        Input(
          phoneController,
          label: 'Телефон',
          onChanged: (_) {
            setState(() {});
          },
        ),
        Input(
          passwordController,
          label: 'Пароль',
          onChanged: (_) {
            setState(() {});
          },
        ),
      ],
    );
  }

  bool isButtonDisabled() {
    var registrationBody = getLoginBody();
    var nullableEntry = registrationBody.entries
        .firstWhere((entry) => entry.value == '', orElse: () => null);

    return nullableEntry != null;
  }

  Map<String, String> getLoginBody() {
    Map<String, String> loginBody = Map();
    loginBody['phone'] = phoneController.value.text;
    loginBody['password'] = passwordController.value.text;

    return loginBody;
  }

  onLogin() async {

    RootStore rootStore = of(context);
    AuthStore authStore = rootStore.authStore;
    await authStore.login(getLoginBody());

    if (authStore.error) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(title: Text('Ошибка!'));
          });
    } else {
      await rootStore.updateFirebaseToken();
      Navigator.of(context).pushReplacementNamed(Routes.APP);
    }
  }

  isLoading() {
    AuthStore authStore = of(context).authStore;
    return authStore.isLoading;
  }

  @override
  void initState() {
    super.initState();

    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  onRegister() {
    Navigator.of(context).pushNamed(Routes.REGISTER);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: buildLoginForm(),
          ),
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: Button('Войти', onLogin,
                isDisabled: isButtonDisabled(), isLoading: isLoading()),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Button('Регистрация', onRegister),
          )
        ],
      ),
    );
  }
}
