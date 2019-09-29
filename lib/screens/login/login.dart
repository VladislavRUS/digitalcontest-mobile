import 'package:digitalcontest_mobile/components/button/button.dart';
import 'package:digitalcontest_mobile/components/input/input.dart';
import 'package:digitalcontest_mobile/constants/app_colors/app_colors.dart';
import 'package:digitalcontest_mobile/constants/routes/routes.dart';
import 'package:digitalcontest_mobile/store/auth_store.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    var height = MediaQuery.of(context).size.height / 3;

    return Column(
      children: <Widget>[
        Container(
          height: height,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Input(
            phoneController,
            label: 'Логин',
            onChanged: (_) {
              setState(() {});
            },
          ),
        ),
        Input(
          passwordController,
          label: 'Пароль',
          onChanged: (_) {
            setState(() {});
          },
        ),
        buildForget(),
      ],
    );
  }

  Widget buildForget() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Container(
                child: Text(
                  'Забыли пароль?',
                  style: TextStyle(
                      color: AppColors.MAIN_COLOR,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildIcons() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildGosIcon(
              'assets/icons/gos.svg', Color.fromARGB(255, 231, 235, 238)),
          buildIcon('assets/icons/vk.svg', Color.fromARGB(255, 74, 118, 168)),
          buildIcon('assets/icons/ok.svg', Color.fromARGB(255, 238, 130, 8)),
          buildIcon('assets/icons/yandex.svg', Color.fromARGB(255, 255, 0, 0)),
        ],
      ),
    );
  }

  Widget buildIcon(String asset, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      color: color,
      width: 35,
      height: 35,
      child: Center(
          child: SvgPicture.asset(
        asset,
        width: 18,
        height: 18,
        color: Colors.white,
      )),
    );
  }

  Widget buildGosIcon(String asset, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      color: color,
      width: 35,
      height: 35,
      child: Center(child: SvgPicture.asset(asset, width: 30, height: 30)),
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

  Widget buildGradient() {
    var height = MediaQuery.of(context).size.height / 3;

    return Container(
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            AppColors.GRADIENT_START_COLOR,
            AppColors.GRADIENT_STOP_COLOR,
          ])),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 20,
            top: 0,
            child: Container(
              width: 150,
              height: 120,
              child: SvgPicture.asset('assets/images/logo.svg'),
            ),
          ),
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Инициативы',
                  style: TextStyle(
                      fontSize: 42,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget registrationRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(right: 5),
            child: Text(
              'Нет аккаунта?',
              style: TextStyle(
                color: AppColors.TEXT_COLOR,
              ),
            )),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.REGISTER);
            },
            child: Text(
              'Зарегистрироваться',
              style: TextStyle(
                  color: AppColors.MAIN_COLOR,
                  decoration:
                      TextDecoration.combine([TextDecoration.underline])),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBottom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Button('Войти', onLogin,
              isDisabled: isButtonDisabled(), isLoading: isLoading()),
        ),
        buildOr(),
        buildIcons(),
        registrationRow()
      ],
    );
  }

  Widget buildOr() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: <Widget>[
          Expanded(child: buildLine()),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10), child: Text('или')),
          Expanded(child: buildLine()),
        ],
      ),
    );
  }

  Widget buildLine() {
    return Container(
      height: 1,
      width: 50,
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: buildGradient(),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                buildLoginForm(),
              ],
            ),
          ),
          Positioned(bottom: 20, left: 20, right: 20, child: buildBottom())
        ],
      ),
    );
  }
}
