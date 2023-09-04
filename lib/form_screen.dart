import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: Text('log in'),
        centerTitle: true,
      ),*/
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 60,horizontal: 20),
          child: Form(
            key:_formfield,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/login.jpg',
                height: 200,
                  width: 400,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController ,
                  decoration: InputDecoration(
                    labelText: 'email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value){
                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/-=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);

                    if(value!.isEmpty){
                      return 'Enter Email';
                    }
                    else if(!emailValid) {
                      return 'Enter a valid Email';
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController  ,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    labelText: 'password',

                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),

                    suffixIcon: InkWell(
                      onTap: (){
                        setState((){
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(passToggle ? Icons.visibility :Icons.visibility_off),

                    )
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Enter Password';
                    }
                    else if (passwordController.text.length < 6){
                      return 'Password should not be less than 6 chars ';
                    }
                  },
                ),
                SizedBox(height: 60,),
                InkWell(
                  onTap: (){
                    if(_formfield.currentState!.validate()){
                      print('Success');
                      emailController.clear();
                      passwordController.clear();
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(5),

                    ),
                    child: Center(
                     child: Text('Log In',style:TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                       fontSize: 20
                     ))
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text('Alreay have an account ?',style: TextStyle(
                      fontSize: 17,
                    ),),
                    TextButton(onPressed: (){}, child: Text(
                      'Sign up',style:TextStyle(
                      color: Colors.blue,
                    )
                    ))
                  ],
                )
              ],
            ),
          ),

        ),
      ),
    );
  }
}
