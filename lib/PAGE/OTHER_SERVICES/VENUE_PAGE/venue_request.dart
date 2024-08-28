import 'package:addhills_app/MODELS/Requests/docu_request.dart';
import 'package:addhills_app/MODELS/Requests/venue_request_model.dart';
import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/document_request.dart';
import 'package:addhills_app/PAGE/OTHER_SERVICES/VENUE_PAGE/item_Map.dart';
import 'package:addhills_app/PAGE/OTHER_SERVICES/VENUE_PAGE/venue_reservation_page.dart';
import 'package:addhills_app/SERVICES/db_service.dart';
import 'package:addhills_app/utils/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:addhills_app/PAGE/TOP_BUTTONS/top_navigationpop.dart';

final _formKey = GlobalKey<FormState>();

class VenueRequest extends StatelessWidget {
  var height,width;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contacNumController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController bdayController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController setDate = TextEditingController();
  final TextEditingController additionalRequirementsController = TextEditingController();
  
  
  String title;

  VenueRequest({
    required this.title,
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
                                  VenueForm(
                                    nameController: nameController, 
                                    emailController: emailController, 
                                    contacNumController: contacNumController, 
                                    addressController: addressController, 
                                    bdayController: bdayController, 
                                    setDateController: setDate, 
                                    title: title,
                                    purposeController: purposeController, 
                                    additionalRequirementsController: additionalRequirementsController,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: VenueSubmit(
                                title: title, 
                                nameController: nameController, 
                                emailController: emailController, 
                                contacNumController: contacNumController, 
                                addressController: addressController, 
                                bdayController: bdayController,
                                setDateController: setDate,
                                purposeController: purposeController,
                                additionalRequirementsController: additionalRequirementsController,
                              ),
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

class VenueForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController contacNumController;
  final TextEditingController addressController;
  final TextEditingController bdayController;
  final TextEditingController setDateController;
  final TextEditingController purposeController;
  final TextEditingController additionalRequirementsController;
  final String title;

  VenueForm({
    required this.title,
    required this.nameController,
    required this.emailController,
    required this.contacNumController,
    required this.addressController,
    required this.bdayController,
    required this.setDateController,
    required this.purposeController,
    required this.additionalRequirementsController,
  });

  @override
  State<VenueForm> createState() => _VenueFormState();
}

class _VenueFormState extends State<VenueForm> {
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
              headerForTfield(text: 'Purpose',),
              buildPurpose(),    
              headerForTfield(text: 'Reservation Date',),
              buildSetDate(), 
            ],
          ),
        ),
        SizedBox(height: 30),   
        Text(
          'Additional Requests',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        Divider(
          color: Colors.black54
        ),
        ElevatedButton(
          onPressed: _handleEquipmentSelection,
          child: Text('Add Equipments'),
        ),
        headerForTfield(text: 'Equipments'),
        TextField(
        controller: widget.additionalRequirementsController,
        decoration: InputDecoration(
          labelText: 'Additional Equipment',
          border: OutlineInputBorder(),
        ),
        readOnly: true, // Make it read-only if you don’t want user to edit directly
      ),
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

  Widget buildSetDate() => TextField(
    controller: widget.setDateController,
    style: TextStyle(fontSize: 15),
    decoration: InputDecoration(
      hintText: 'Araw ng pagreserba',
      border: OutlineInputBorder(),
      //isDense: true,
      contentPadding: EdgeInsets.all(8),
      suffixIcon: Icon(Icons.calendar_month),
    ),
    textInputAction: TextInputAction.done,
    //keyboardType: TextInputType.datetime,
    readOnly: true,
    onTap: () {
      _selectDate(context,widget.setDateController);
    },
  );

  Widget buildPurpose() => TextField(
    controller: widget.purposeController,
    style: TextStyle(fontSize: 15),
    decoration: InputDecoration(
      hintText: 'Layunin',
      border: OutlineInputBorder(),
      isDense: true,
      contentPadding: EdgeInsets.all(8),
    ),
    textInputAction: TextInputAction.done,
    //keyboardType: TextInputType.streetAddress,
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

  Future<List<Map<String, dynamic>>?> _showEquipmentBorrowerDialog() {
    return showDialog<List<Map<String, dynamic>>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: double.maxFinite,
            height: 400, // Full width of the dialog
            child: EquipmentBorrowerSystem(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Just close if no data
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _handleEquipmentSelection() async {
    final List<Map<String, dynamic>>? result = await _showEquipmentBorrowerDialog();
    
    if (result != null) {
      final List<String> additionalEquipments = result.map((item) {
        return '${item['equipment']} (${item['quantity']})';
      }).toList();
      
      // Update the TextEditingController with the formatted list of strings
      setState(() {
        widget.additionalRequirementsController.text = additionalEquipments.join(', ');
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

class VenueSubmit extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController contacNumController;
  final TextEditingController addressController;
  final TextEditingController bdayController;
  final TextEditingController setDateController;
  final TextEditingController purposeController;
  final TextEditingController additionalRequirementsController;
  final String title;

  VenueSubmit({
    required this.title,
    required this.nameController,
    required this.emailController,
    required this.contacNumController,
    required this.addressController,
    required this.bdayController,
    required this.setDateController,
    required this.purposeController,
    required this.additionalRequirementsController,
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
          if (nameController.text.isEmpty || emailController.text.isEmpty || setDateController.text.isEmpty ||
          contacNumController.text.isEmpty || addressController.text.isEmpty || bdayController.text.isEmpty || 
          purposeController.text.isEmpty || !_formKey.currentState!.validate()){
            _showDialog(context, 'Error', 'Please ensure all fields are completed and valid.');
          }
          else if(_formKey.currentState!.validate()){
            VenueRequestModel venuereq = VenueRequestModel(
              venue_name: title,
              requester_name: nameController.text, 
              address: addressController.text, 
              birthday: bdayController.text, 
              request_status: "pending", 
              user_email: emailController.text,
              date_requested: Timestamp.now(),
              set_date: setDateController.text,
              user_age: calculateAge(bdayController.text),
              purpose: purposeController.text, 
              contact_number: contacNumController.text, 
              additional_equipments: parseEquipments(additionalRequirementsController.text),
            );
            _dbService.addVenueReq(generateTimestampBasedId(), venuereq);
            
            nameController.clear();
            emailController.clear();
            contacNumController.clear();
            addressController.clear();
            bdayController.clear();
            setDateController.clear();
            purposeController.clear();
            additionalRequirementsController.clear();

            await _showDialog(
              context, 
              'Success', 
              'Your request has been submitted. An email will be sent to you once your request is approved.'
            );
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => VenueReservationPage()));
          }
        },
        child: Text('Submit', style: TextStyle(fontSize: 15, color: Colors.white),),
      ),
    );
  }

  List<String> parseEquipments(String equipmentsString) {
    // Split the formatted string back into a list of strings
    return equipmentsString.split(', ').map((item) => item.trim()).toList();
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
}