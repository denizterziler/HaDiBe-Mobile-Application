import 'package:se_380_project/Firebase/auth.dart';
import 'package:se_380_project/List_of_contents.dart';
import 'package:se_380_project/Screens/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/log-in';

  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormState>();
  final Auth _authService = Auth();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            height: size.height * .5,
            width: size.width * .85,
            decoration: BoxDecoration(
                color: Colors.black54.withOpacity(.75),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.75),
                      blurRadius: 10,
                      spreadRadius: 2)
                ]),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "You have to enter your email";
                            }
                            return null;
                          },
                          controller: _emailController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            hintText: 'E-Mail',
                            prefixText: ' ',
                            hintStyle: TextStyle(color: Colors.white),
                            focusColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                          )),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Form(
                      key: _passKey,
                      child: TextFormField(
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'You cannot leave this area blank';
                          }
                          return null;
                        },
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          controller: _passwordController,
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.vpn_key,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                }),
                            hintText: 'Password',
                            prefixText: ' ',
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            focusColor: Colors.white,
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                          )),
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate() && _passKey.currentState!.validate()) {
                          _authService
                              .signIn(_emailController.text,
                                  _passwordController.text)
                              .then((value) {
                            return Navigator.of(context)
                                .pushNamed(ListOfContents.routeName);
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            //color: colorPrimaryShade,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Center(
                              child: Text(
                            "Log In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 1,
                            width: 75,
                            color: Colors.white,
                          ),
                          const Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            height: 1,
                            width: 75,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
