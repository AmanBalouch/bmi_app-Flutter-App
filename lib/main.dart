import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var feetController=TextEditingController();
  var inchesController=TextEditingController();
  var weightController=TextEditingController();
  double bmi_value=0;
  String conclusion="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: TextWidget(text: "BMI Calculator", size: 30, boldText: true, textColor: Colors.black)
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFieldWidget(labeltext: 'Enter weight',ctrl: weightController),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: TextFieldWidget(labeltext: 'Enter Height in feet', ctrl: feetController)
                  ),
                  SizedBox(width: 10), // Add some spacing between fields
                  Expanded(
                      flex: 1,
                      child: TextFieldWidget(labeltext: 'Enter Height in inches', ctrl: inchesController)
                  ),
                ],
              ),

              Container(
                height: 85,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  children: [
                    TextWidget(text: "Result", size: 20, boldText: true, textColor: Colors.black),
                    TextWidget(text: "Your BMI value is ${bmi_value.toStringAsFixed(3)}.", size: 16, boldText: false, textColor: Colors.black),
                    TextWidget(text: "You are $conclusion.", size: 14, boldText: false, textColor: Colors.black)
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 120,
                child: ElevatedButton(
                    onPressed:(){
                      double w=double.parse(weightController.text.toString());
                      double heightInInchecs=double.parse(feetController.text.toString())*12;
                      double totalHeightInInches=heightInInchecs+double.parse(inchesController.text.toString());
                      double totalHeightInMeters=totalHeightInInches/39.3701;
                      bmi_value=w/(totalHeightInMeters*totalHeightInMeters);
                      if(bmi_value<18.5)
                        conclusion="UnderWeight";
                      else if (bmi_value<=24.9)
                        conclusion="Normal Weight";
                      else if(bmi_value<=29.9)
                        conclusion="Over weight";
                      else if(bmi_value<=34.9)
                        conclusion="Obesity(class 1)";
                      else if(bmi_value<=39.9)
                        conclusion="Obesity(class 2)";
                      else
                        conclusion="Obesity(class 3)";
                      setState(() {

                      });
                    },
                    child: TextWidget(text: "Calculate", size: 18, boldText: true, textColor: Colors.black),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shadowColor: Colors.black,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final String? labeltext;
  final TextEditingController? ctrl;

  const TextFieldWidget({Key? key, this.labeltext, this.ctrl}) : super(key: key); // ✅ Fixed constructor

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl, // ✅ Added controller
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labeltext,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1,
          ),
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget{
  final String text;
  final double size;
  final bool? boldText;
  final Color textColor;

  TextWidget({required this.text,required this.size,required this.boldText,required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.acme(
        color: textColor,
        fontSize: size,
        fontWeight: (boldText ?? false) ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}