import 'package:fire_chat/presentation/auth/cubit/auth_cubit.dart';
import 'package:fire_chat/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordContrller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authCubit = AuthCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Register Screen",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextField(labelText: "Email", controller: _emailController),
              SizedBox(
                height: 10,
              ),
              CustomTextField.obscureText(
                  labelText: "Password", controller: _passwordContrller),
              SizedBox(
                height: 20,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (ctx, state) {
                  if (state is AuthSuccess) {
                    context.go("/home");
                  }
                },
                bloc: authCubit,
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        authCubit.register(
                            email: _emailController.text.trim(),
                            password: _passwordContrller.text);
                      },
                      child: state is AuthLoading
                          ? CircularProgressIndicator()
                          : Text("Register"));
                },
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account ?"),
                  TextButton(
                      onPressed: () {
                        context.go("/login");
                      },
                      child: Text("Login")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
