import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/bloc/user_bloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            return buildForm();
          } else if (state is UserLoading) {
            return buildLoadingState();
          } else if (state is UserLogged) {
            return buildLoggedState(state);
          } else if (state is UserError) {
            return buildForm(errorState: state);
          } else {
            return buildForm();
          }
        },
      ),
    );
  }

  Widget buildForm({
    UserError? errorState,
  }) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FormBuilder(
            key: formKey,
            skipDisabled: true,
            initialValue: errorState != null ? errorState.previousForm : {},
            child: Column(
              children: <Widget>[
                errorState != null
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          errorState.message,
                        ),
                        color: Colors.red,
                      )
                    : Container(),
                FormBuilderTextField(
                  name: 'username',
                  validator: FormBuilderValidators.required(context),
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  textInputAction: TextInputAction.next,
                ),
                FormBuilderTextField(
                  name: 'password',
                  validator: FormBuilderValidators.required(context),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  textInputAction: TextInputAction.next,
                ),
                TextButton(
                  onPressed: () => submitForm(context),
                  child: Text('Login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitForm(BuildContext context) {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      Map<String, dynamic> form = formKey.currentState!.value;
      final UserBloc todoBloc = BlocProvider.of<UserBloc>(context);

      todoBloc.add(UserLogin(form));
    }
  }

  Widget buildLoggedState(state) {
    return Center(
      child: Text(state.user.username),
    );
  }

  Widget buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
