import 'package:addhills_app/MODELS/Requests/docu_request.dart';
import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/document_request.dart';
import 'package:addhills_app/SERVICES/db_service.dart';
import 'package:addhills_app/utils/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:addhills_app/PAGE/TOP_BUTTONS/top_navigationpop.dart';

final _formKey = GlobalKey<FormState>();

class DrRegister extends StatelessWidget {
  var height,width;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contacNumController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController bdayController = TextEditingController();
  final TextEditingController residenceController = TextEditingController();
  
  String title;
  String price;

  DrRegister({
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Builder(
        builder: (context) {
          return Container(
            color: Colors.black,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    height: height * 0.15,
                    width: width,
                    alignment: Alignment.topCenter,
                    child: TopNavigationpop(color: Colors.white,),
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          )
                        ),
                        height: height - (height * 0.15),
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 30,
                                bottom: 15,
                              ),
                              child: Text(
                                'Document Request',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Divider(
                              indent: 50,
                              endIndent: 50,
                              color: Colors.black54
                            ),
                            Container(
                              height: (height * .64), width: width,
                              padding: EdgeInsets.only(left: 50, right: 50),
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  DrForm(
                                    nameController: nameController, 
                                    emailController: emailController, 
                                    contacNumController: contacNumController, 
                                    addressController: addressController, 
                                    bdayController: bdayController, 
                                    residenceController: residenceController, 
                                    title: title,)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: DrSubmit(
                                title: title, 
                                nameController: nameController, 
                                emailController: emailController, 
                                contacNumController: contacNumController, 
                                addressController: addressController, 
                                bdayController: bdayController,
                                residenceController: residenceController, 
                                price: price,),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

class DrForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController contacNumController;
  final TextEditingController addressController;
  final TextEditingController bdayController;
  final TextEditingController residenceController;
  final String title;

  DrForm({
    required this.title,
    required this.nameController,
    required this.emailController,
    required this.contacNumController,
    required this.addressController,
    required this.bdayController,
    required this.residenceController,
  });

  @override
  State<DrForm> createState() => _DrFormState();
}

class _DrFormState extends State<DrForm> {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: Text('${widget.title}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))),
        Container(
          padding: EdgeInsets.only(top: 8),
          alignment: Alignment.topLeft,
          child: Text( 'Please ensure that the provided information is valid and correct.', style: TextStyle(fontSize: 15, color: Colors.black), textAlign: TextAlign.justify,),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              headerForTfield(text: 'Full Name',),
              buildName(),
              headerForTfield(text: 'Email',),
              buildEmail(),
              headerForTfield(text: 'Contact Number',),
              buildContact(),
              headerForTfield(text: 'Birthday',),
              buildBirthday(),   
              headerForTfield(text: 'Address',),
              buildAddress(),    
              headerForTfield(text: 'Years of Residence',),
              buildResidence(),  
            ],
          ),
        ),   
          
         
        // headerForTfield(text: 'Purpose',),
        // buildPurpose(),           
      ],
    );
  }

  Widget buildName() => TextField(
    controller: widget.nameController,
    style: TextStyle(fontSize: 15),
    decoration: InputDecoration(
      hintText: 'Buong Pangalan',
      border: OutlineInputBorder(),
      isDense: true,
      contentPadding: EdgeInsets.all(8),
    ),
    textInputAction: TextInputAction.done,
    keyboardType: TextInputType.name,
  );

  Widget buildEmail() => TextFormField(
    controller: widget.emailController,
    style: TextStyle(fontSize: 15),
    decoration: InputDecoration(
      hintText: 'Email',
      border: OutlineInputBorder(),
      isDense: true,
      contentPadding: EdgeInsets.all(8),
    ),
    textInputAction: TextInputAction.done,
    keyboardType: TextInputType.emailAddress, // Use email address keyboard type for better UX
    validator: (value) {
      // Define the regular expression for email validation
      final emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
      // Check if the value is null or does not match the regular expression
      if (value == null || !emailRegExp.hasMatch(value)) {
        // Return an error message if invalid
        return 'Invalid email format';
      }
      // Return null if valid
      return null;
    },
  );


  Widget buildContact() => TextFormField(
    controller: widget.contacNumController,
    style: TextStyle(fontSize: 15),
    decoration: InputDecoration(
      hintText: 'Numero ng Telepono', // Placeholder text
      border: OutlineInputBorder(),
      isDense: true,
      contentPadding: EdgeInsets.all(8),
    ),
    textInputAction: TextInputAction.done,
    keyboardType: TextInputType.phone, // Use phone keyboard type for better UX
    validator: (value) {
      // Define the regular expression for phone number validation
      final phoneRegExp = RegExp(r"^((\+63)|0)[9][0-9]{9}$");
      // Check if the value is null or does not match the regular expression
      if (value == null || !phoneRegExp.hasMatch(value)) {
        return 'Enter a valid phone number'; // Error message
      }
      // Return null if valid
      return null;
    },
  );


  Widget buildAddress() => TextField(
    controller: widget.addressController,
    style: TextStyle(fontSize: 15),
    decoration: InputDecoration(
      hintText: 'Tirahan',
      border: OutlineInputBorder(),
      isDense: true,
      contentPadding: EdgeInsets.all(8),
    ),
    textInputAction: TextInputAction.done,
    keyboardType: TextInputType.streetAddress,
  );

  Widget buildBirthday() => TextField(
    controller: widget.bdayController,
    style: TextStyle(fontSize: 15),
    decoration: InputDecoration(
      hintText: 'Kaarawan',
      border: OutlineInputBorder(),
      //isDense: true,
      contentPadding: EdgeInsets.all(8),
      suffixIcon: Icon(Icons.calendar_month),
    ),
    textInputAction: TextInputAction.done,
    //keyboardType: TextInputType.datetime,
    readOnly: true,
    onTap: () {
      _selectDate(context,widget.bdayController);
    },
  );

  Widget buildResidence() => TextField(
    controller: widget.residenceController,
    style: TextStyle(fontSize: 15),
    decoration: InputDecoration(
      hintText: 'Taon ng Paninirahan',
      helperText: 'Must have been a resident for at least 6 months.\n(The specific day does not need to be exact.)',
      border: OutlineInputBorder(),
      //isDense: true,
      contentPadding: EdgeInsets.all(8),
      suffixIcon: Icon(Icons.calendar_month),
    ),
    textInputAction: TextInputAction.done,
    //keyboardType: TextInputType.datetime,
    readOnly: true,
    onTap: () {
      _selectDate(context,widget.residenceController);
    },
  );

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async{
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime(1900), 
      lastDate: DateTime(2100),
    );

    if (_picked != null){
      setState(() {
        controller.text = _picked.toString().split(' ')[0];
      });
    }

  }
}

class headerForTfield extends StatelessWidget {
  final String text;
  headerForTfield({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      alignment: Alignment.topLeft,
      child: Text('$text', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)));
  }
}

class DrSubmit extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController contacNumController;
  final TextEditingController addressController;
  final TextEditingController bdayController;
  final TextEditingController residenceController;
  final String title;
  final String price;

  DrSubmit({
    required this.title,
    required this.price,
    required this.nameController,
    required this.emailController,
    required this.contacNumController,
    required this.addressController,
    required this.bdayController,
    required this.residenceController,
  });

  final DbService _dbService = DbService();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 243, 109, 99),
          padding: EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10,),
        ),
        onPressed: () async{
          if (nameController.text.isEmpty || emailController.text.isEmpty || residenceController.text.isEmpty ||
          contacNumController.text.isEmpty || addressController.text.isEmpty || bdayController.text.isEmpty || 
          !_formKey.currentState!.validate()){
            _showDialog(context, 'Error', 'Please ensure all fields are completed and valid.');
          }
          else if(_formKey.currentState!.validate()){
            submitRequest(context);
          }
        },
        child: Text('Submit', style: TextStyle(fontSize: 15, color: Colors.white),),
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context, String title, String content) {
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text(title),
          contentPadding: EdgeInsets.all(15),
          content: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(content, textAlign: TextAlign.justify),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 243, 109, 99)),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white)
              ),
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('Close')
            )
          ],
        );
      },
    );
  }

  void submitRequest(BuildContext context) async {
    bool confirmed = await showConfirmationDialog(context);

    if (confirmed) {
      DocuRequest docsreq = DocuRequest(
        document_title: title,
        requester_name: nameController.text, 
        address: addressController.text, 
        birthday: bdayController.text, 
        request_status: "Pending", 
        user_email: emailController.text,
        date_requested: Timestamp.now(),
        pickup_date: addtimestamp(), 
        years_of_residence: calculateYearsAndMonthsOfResidence(residenceController.text), 
        user_age: calculateAge(bdayController.text), 
        contact_number: contacNumController.text, 
        price: price,
      );
      _dbService.addDocsReq(generateTimestampBasedId(),docsreq);
      
      nameController.clear();
      emailController.clear();
      contacNumController.clear();
      addressController.clear();
      bdayController.clear();
      residenceController.clear();

      await _showDialog(
        context, 
        'Success', 
        'Your request has been submitted. An email will be sent to you once your request is approved.'
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => DocuPage()));
    }
  }
  
}