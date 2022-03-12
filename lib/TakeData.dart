import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'ShowImage.dart';
import 'main.dart';

class TakeData extends StatefulWidget {
  const TakeData({Key? key}) : super(key: key);

  @override
  _TakeDataState createState() => _TakeDataState();
}

class _TakeDataState extends State<TakeData> {
  final _formKey = GlobalKey<FormState>();
  File? val;
  File? logo;
  File? imge;
  bool logoImg=false,bgImg=false;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  Future openCamera(String? type) async {
    final XFile? img =
    await _picker.pickImage(source: ImageSource.gallery,);
    setState(() {
      if (type == 'logo'){
        logo = File(img!.path);
      } else if(type == 'bgImg'){
        imge = File(img!.path);
      }
    });
  }

  Widget textFileds(TextInputType? textType,TextEditingController? _controller,String? name){
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      elevation: 12,
      child: TextFormField(
        keyboardType: textType,
        controller: _controller,
        validator: (value) {
          if (textType == TextInputType.emailAddress) {
            if (value!.isEmpty) {
              return 'Please Enter your email';
            } else
            if (!value.contains('@')) {
              return 'Enter valid email';
            }else {
              return null;
            }
          } else if(textType == TextInputType.phone){
            if (value!.isEmpty) {
              return 'Please Enter your phone number';
            } else if (value.length != 10) {
              return 'Please enter valid mobile number';

            }else {
              return null;
            }
          } else if(textType == TextInputType.text){
            if (value!.isEmpty) {
              return 'Please Enter your name';
            } else {
              return null;
            }
          } else if(textType == TextInputType.multiline){
            if (value!.isEmpty) {
              return 'Please Enter your address';
            } else {
              return null;
            }
          }
          return null;
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(textType == TextInputType.phone?10:500),
        ],
        maxLines: textType == TextInputType.multiline ? 4:1,
        style: const TextStyle(
            fontSize: 16.0,
            fontFamily: ConstVar.fontFamily,
            color: ConstVar.fontColour,
            fontWeight: FontWeight.w900
        ),
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 10,
            fontFamily: ConstVar.fontFamily,
            color: Color(0xFFff3333),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 20.0),
          labelText: name,
          labelStyle: const TextStyle(
            fontSize: 18.0,
            fontFamily: ConstVar.fontFamily,
            color: ConstVar.fontColour,
            fontWeight: FontWeight.w900,
          ),
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TakeData'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10,right: 15,left: 15,),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pick Logo',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          fontFamily: ConstVar.fontFamily,
                          color: ConstVar.fontColour
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        openCamera('logo');
                      },
                      child: const Text(
                        '+ Add',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            fontFamily: ConstVar.fontFamily,
                            color: ConstVar.bgCode
                        ),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10.0),
                                side: const BorderSide(
                                    width: 0.0,
                                    color: Color(0xFF707070)))),
                        backgroundColor: MaterialStateProperty.all(ConstVar.primaryColour),
                      ),
                    ),
                  ],
                ),
                logo !=null ?Text(
                  '$logo',
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      fontFamily: ConstVar.fontFamily,
                      color: ConstVar.fontColour
                  ),
                ):logoImg ? const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Please Select the logo',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      fontFamily: ConstVar.fontFamily,
                      color: Color(0xFFff3333),
                    ),
                  ),
                ):const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pick Background',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          fontFamily: ConstVar.fontFamily,
                          color: ConstVar.fontColour
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        openCamera('bgImg');
                      },
                      child: const Text(
                        '+ Add',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            fontFamily: ConstVar.fontFamily,
                            color: ConstVar.bgCode
                        ),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10.0),
                                side: const BorderSide(
                                    width: 0.0,
                                    color: Color(0xFF707070)))),
                        backgroundColor: MaterialStateProperty.all(ConstVar.primaryColour),
                      ),
                    ),
                  ],
                ),
                imge !=null ?Text(
                  '$imge',
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      fontFamily: ConstVar.fontFamily,
                      color: ConstVar.fontColour
                  ),
                ):logoImg ? const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Please Select the Background',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      fontFamily: ConstVar.fontFamily,
                      color: Color(0xFFff3333),
                    ),
                  ),
                ):const SizedBox(),
                const SizedBox(
                  height: 15,
                ),
                textFileds(
                  TextInputType.text,
                  _nameController,
                  'Name',
                ),
                const SizedBox(
                  height: 15,
                ),
                textFileds(
                  TextInputType.emailAddress,
                  _emailController,
                  'E-mail',
                ),
                const SizedBox(
                  height: 15,
                ),
                textFileds(
                  TextInputType.phone,
                  _phoneController,
                  'Phone Number',
                ),
                const SizedBox(
                  height: 15,
                ),
                textFileds(
                  TextInputType.multiline,
                  _addressController,
                  'Address',
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate() && logo !=null && imge !=null){
                      setState(() {
                        logoImg = false;
                        bgImg = false;
                      });
                      String? l1 = logo!.path ;
                      String? b1 = imge!.path ;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShowImage(logoImg: logo,bgImg: imge,name: _nameController.text,email: _emailController.text,phone: _phoneController.text,address: _addressController.text,),
                      ),);
                    }else{
                      if(logo == null){
                        setState(() {
                          logoImg = true;
                        });
                      } else if(imge == null){
                        setState(() {
                          bgImg = true;
                        });

                      } else if(logo == null && imge == null){
                        setState(() {
                          logoImg = true;
                          bgImg = true;
                        });
                      }else{
                        setState(() {
                          logoImg = false;
                          bgImg = false;
                        });
                      }
                    }
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        fontFamily: ConstVar.fontFamily,
                        color: ConstVar.bgCode
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10.0),
                            side: const BorderSide(
                                width: 0.0,
                                color: Color(0xFF707070)))),
                    backgroundColor: MaterialStateProperty.all(ConstVar.primaryColour),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
