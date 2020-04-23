import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter/localizations.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/services/helpers/helpers.dart';
import 'package:flutter_starter/services/services.dart';

class SignInUI extends StatefulWidget {
  _SignInUIState createState() => _SignInUIState();
}

class _SignInUIState extends State<SignInUI> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    /*final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.status == Status.Authenticating) {
      _loading = true;
    }*/

    return Scaffold(
      key: _scaffoldKey,
      body: LoadingScreen(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      LogoGraphicHeader(),
                      SizedBox(height: 48.0),
                      FormInputFieldWithIcon(
                        controller: _email,
                        iconPrefix: CustomIcon.mail,
                        labelText: labels.auth.emailFormField,
                        validator: Validator.email,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => null,
                        onSaved: (value) => _email.text = value,
                      ),
                      FormVerticalSpace(),
                      FormInputFieldWithIcon(
                        controller: _password,
                        iconPrefix: CustomIcon.lock,
                        labelText: labels.auth.passwordFormField,
                        validator: Validator.password,
                        obscureText: true,
                        onChanged: (value) => null,
                        onSaved: (value) => _password.text = value,
                        maxLines: 1,
                      ),
                      FormVerticalSpace(),
                      PrimaryButton(
                          labelText: labels.auth.signInButton,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _loading = true;
                              });
                              AuthService _auth = AuthService();
                              bool status = await _auth
                                  .signInWithEmailAndPassword(
                                      _email.text, _password.text)
                                  .then((status) {
                                setState(() {
                                  _loading = false;
                                });
                                return status;
                              });
                              if (!status) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(labels.auth.signInError),
                                ));
                              }
                            }
                          }),
                      FormVerticalSpace(),
                      LabelButton(
                        labelText: labels.auth.resetPasswordLabelButton,
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, '/reset-password'),
                      ),
                      LabelButton(
                        labelText: labels.auth.signUpLabelButton,
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/signup'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          inAsyncCall: _loading),
    );
  }
}
