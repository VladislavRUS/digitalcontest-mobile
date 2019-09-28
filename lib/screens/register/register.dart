import 'package:digitalcontest_mobile/components/button/button.dart';
import 'package:digitalcontest_mobile/components/input/input.dart';
import 'package:digitalcontest_mobile/constants/genders/genders.dart';
import 'package:digitalcontest_mobile/constants/routes/routes.dart';
import 'package:digitalcontest_mobile/store/auth_store.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  static RootStore of(context) =>
      ScopedModel.of(context, rebuildOnChange: true);

  TextEditingController phoneController;
  TextEditingController passwordController;
  TextEditingController nicknameController;
  TextEditingController companyController;
  TextEditingController fioController;
  TextEditingController ageController;
  TextEditingController locationController;
  String gender = Genders.MALE;
  bool isCompany = true;

  @override
  void initState() {
    super.initState();

    phoneController = TextEditingController();
    passwordController = TextEditingController();
    nicknameController = TextEditingController();
    companyController = TextEditingController();
    fioController = TextEditingController();
    ageController = TextEditingController();
    locationController = TextEditingController();
  }

  Widget buildCompanyForm() {
    return Container(
      child: Column(
        children: <Widget>[
          Input(
            companyController,
            label: 'Название компании',
          ),
          Input(
            phoneController,
            label: 'Телефон',
            inputType: TextInputType.phone,
          ),
          Input(
            passwordController,
            label: 'Пароль',
            inputType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  Widget buildUserForm() {
    return Container(
      child: Column(
        children: <Widget>[
          Input(
            fioController,
            label: 'ФИО',
          ),
          Input(
            nicknameController,
            label: 'Псевдоним',
          ),
          Input(
            phoneController,
            label: 'Телефон',
            inputType: TextInputType.phone,
          ),
          Input(
            passwordController,
            label: 'Пароль',
            inputType: TextInputType.visiblePassword,
          ),
          Input(
            ageController,
            label: 'Возраст',
            inputType: TextInputType.numberWithOptions(),
          ),
          Row(
            children: <Widget>[
              Text('Я мужчина'),
              Radio(
                  value: Genders.MALE,
                  groupValue: gender,
                  onChanged: (newValue) {
                    setState(() {
                      gender = Genders.MALE;
                    });
                  }),
            ],
          ),
          Row(
            children: <Widget>[
              Text('Я женщина'),
              Radio(
                  value: Genders.FEMALE,
                  groupValue: gender,
                  onChanged: (newValue) {
                    setState(() {
                      gender = Genders.FEMALE;
                    });
                  }),
            ],
          )
        ],
      ),
    );
  }

  Widget buildForm() {
    return isCompany ? buildCompanyForm() : buildUserForm();
  }

  Widget buildIsCompany() {
    return Container(
      child: Row(
        children: <Widget>[
          Text('Я юридическое лицо'),
          Checkbox(
              value: isCompany,
              onChanged: (newValue) {
                setState(() {
                  isCompany = newValue;
                });
              }),
        ],
      ),
    );
  }

  onRegister() async {
    AuthStore authStore = of(context).authStore;
    var registrationBody = getRegistrationBody();
    await authStore.register(registrationBody);

    if (!authStore.error) {
      Navigator.of(context).pop();
    } else {
      showDialog(context: context, builder: (_) {
        return AlertDialog(title: Text('Ошибка!'));
      });
    }
  }

  Map<String, String> getRegistrationBody() {
    Map<String, String> registrationBody = Map();

    registrationBody['phone'] = phoneController.value.text;
    registrationBody['password'] = passwordController.value.text;

    if (isCompany) {
      registrationBody['is_company'] = 1.toString();
      registrationBody['company'] = companyController.value.text;
      registrationBody['nickname'] = registrationBody['company'];
    } else {
      registrationBody['is_company'] = 0.toString();
      registrationBody['fio'] = fioController.value.text;
      registrationBody['nickname'] = nicknameController.value.text;
      registrationBody['age'] = ageController.value.text;
      registrationBody['gender'] = gender;
    }

    return registrationBody;
  }

  bool isButtonDisabled() {
    var registrationBody = getRegistrationBody();
    var nullableEntry = registrationBody.entries
        .firstWhere((entry) => entry.value == '', orElse: () => null);

    return nullableEntry != null;
  }

  isLoading() {
    AuthStore authStore = of(context).authStore;
    return authStore.isLoading;
  }

  @override
  Widget build(BuildContext context) {
    var isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[buildIsCompany(), buildForm()],
              ),
            ),
          ),
          !isKeyboardVisible
              ? Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Button('Зарегистрироваться', onRegister,
                      isDisabled: isButtonDisabled(), isLoading: isLoading()),
                )
              : null
        ].where((widget) => widget != null).toList(),
      ),
    );
  }
}
