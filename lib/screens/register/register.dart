import 'package:digitalcontest_mobile/components/button/button.dart';
import 'package:digitalcontest_mobile/components/input/input.dart';
import 'package:digitalcontest_mobile/components/select_button/select_button.dart';
import 'package:digitalcontest_mobile/constants/app_colors/app_colors.dart';
import 'package:digitalcontest_mobile/constants/genders/genders.dart';
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
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Input(
              companyController,
              label: 'Название компании',
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Input(
              phoneController,
              label: 'Телефон',
              inputType: TextInputType.phone,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Input(
              passwordController,
              label: 'Пароль',
              inputType: TextInputType.visiblePassword,
            ),
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
          Container(
            margin: EdgeInsets.only(bottom: 0, top: 20),
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      'Пол',
                      style: TextStyle(color: AppColors.TEXT_COLOR),
                    )),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Radio(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: AppColors.MAIN_COLOR,
                      value: Genders.MALE,
                      groupValue: gender,
                      onChanged: (newValue) {
                        setState(() {
                          gender = Genders.MALE;
                        });
                      }),
                  Text(
                    'Мужской',
                    style: TextStyle(color: AppColors.TEXT_COLOR),
                  ),
                ],
              ),
              Container(
                width: 10,
              ),
              Row(
                children: <Widget>[
                  Radio(
                      activeColor: AppColors.MAIN_COLOR,
                      value: Genders.FEMALE,
                      groupValue: gender,
                      onChanged: (newValue) {
                        setState(() {
                          gender = Genders.FEMALE;
                        });
                      }),
                  Text(
                    'Женский',
                    style: TextStyle(color: AppColors.TEXT_COLOR),
                  ),
                ],
              )
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
    var options = ['Я юр. лицо', 'Я физ. лицо'];

    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      child:
          SelectButton(options, isCompany ? options[0] : options[1], (option) {
        var newIsCompany = false;

        if (option == options[0]) {
          newIsCompany = true;
        }

        setState(() {
          isCompany = newIsCompany;
        });
      }),
    );
  }

  onRegister() async {
    AuthStore authStore = of(context).authStore;
    var registrationBody = getRegistrationBody();
    await authStore.register(registrationBody);

    if (!authStore.error) {
      Navigator.of(context).pop();
    } else {
      showDialog(
          context: context,
          builder: (_) {
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
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Регистрация',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
        backgroundColor: AppColors.MAIN_COLOR,
      ),
      backgroundColor: Colors.white,
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
