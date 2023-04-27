import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_app/layout/transition.dart';
import 'package:graduation_project_app/modules/Profile/profile_screen.dart';
import 'package:graduation_project_app/modules/home_screen/home_screen.dart';
import 'package:graduation_project_app/modules/login_screen/login_screen.dart';
import 'package:graduation_project_app/modules/register_screen/cubit/cubit.dart';
import 'package:graduation_project_app/modules/register_screen/cubit/states.dart';
import 'package:graduation_project_app/network/local/shared_pref.dart';
import 'package:graduation_project_app/shared/components/phoneField.dart';
import '../../shared/components/components.dart';
import 'package:graduation_project_app/shared/style/colors.dart';
class registerScreen extends StatelessWidget {
  var firstName = TextEditingController();
  var phoneControllor = TextEditingController();
  var lastName = TextEditingController();
  var emailSignUp = TextEditingController();
  var passSignUp = TextEditingController();
  var confirmPass = TextEditingController();
  late var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>registerCubit(),
      child: BlocConsumer<registerCubit,registerStates>(
          listener: (context,state){
            if(state is createUserErrorState){
              showToast(text:state.error.toString(),status:toastStates.ERROR);
            }
            if(state is createUserSucessState){
              showToast(text:'you have sucessfully signed up',status:toastStates.SUCESS);
              casheHelper.saveData(key: 'uId', value: state.uId).then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const Trans())
                    )
                );
              });

            }
          },
          builder: (context,state){
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child:
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                           Text('Register',
                              style:Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: colortheme.lightPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 29
                              ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          defualtForm(
                            controller: firstName,
                            inputType: TextInputType.text,
                            validator: 'required',
                            lable: 'First Name',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defualtForm(
                              controller: lastName,
                              inputType: TextInputType.text,
                              validator: 'required',
                              lable: 'Last Name'),
                          const SizedBox(
                            height: 20,
                          ),
                          phoneField(controller: phoneControllor),
                          const SizedBox(
                            height: 20,
                          ),
                          defualtForm(
                              controller: emailSignUp,
                              inputType: TextInputType.emailAddress,
                              validator: 'required',
                              lable: 'Email Address',
                              prefix: Icons.email,),
                          const SizedBox(
                            height: 20,
                          ),
                          defualtForm(
                            controller: passSignUp,
                            inputType: TextInputType.visiblePassword,
                            validator:'required',
                            lable: 'Password',
                            prefix: Icons.lock,
                            hidden: registerCubit.get(context).isPass,
                            postfix: registerCubit.get(context).isPass? Icons.visibility_off:Icons.visibility,
                            sufffun: (){
                              registerCubit.get(context).passtrue();
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: confirmPass,
                            validator: (String?value){
                              if(value == null || value.trim().isEmpty){
                                return 'required';
                              }
                              if(confirmPass.text != passSignUp.text){
                                return 'not match';
                              }
                              if(value.length < 6){
                                return 'password must be strong and greater than 6';
                              }
                              return null;
                            },
                            cursorColor: colortheme.lightPurple,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: registerCubit.get(context).conPass,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                             // labelStyle: TextStyle(color: colortheme.lightPurple),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: colortheme.lightPurple,
                                ),
                              ),
                              focusColor: colortheme.lightPurple,
                              prefixIcon: const Icon(Icons.lock,color: colortheme.lightPurple,),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  registerCubit.get(context).passContrue();
                                },
                                icon: Icon(
                                    registerCubit.get(context).conPass?Icons.visibility_off:Icons.visibility,
                                    color: colortheme.lightPurple,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ConditionalBuilder(condition: state is! registerLoadinglState,
                              builder: (context)=>defultButton(
                                context: context,
                                  background: colortheme.lightPurple,
                                  function: (){
                                    if(formKey.currentState!.validate()){
                                      registerCubit.get(context).userRegister(
                                          firstName: firstName.text,
                                          secondName: lastName.text,
                                          email: emailSignUp.text,
                                          pass: passSignUp.text);
                                    }
                                  },
                                  text: "SUMBIT",),
                              fallback: (context)=>const CircularProgressIndicator()),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account?',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: colortheme.black,
                              ),
                              ),
                              textButon(
                                context:context,
                                  text: 'SIGNIN',
                                  function: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  loginSreen()),
                                    );
                                  })
                            ],
                          )
                        ],
                      ),
                    ),

                  ),
                ),
              ),
            );
          },

      ),
    );
  }
}