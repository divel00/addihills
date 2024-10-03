import 'package:addhills_app/MODELS/Requests/venue_request_model.dart';
import 'package:addhills_app/PAGE/OTHER_SERVICES/VENUE_PAGE/venue_reservation_page.dart';
import 'package:addhills_app/SERVICES/db_service.dart';
import 'package:addhills_app/utils/calendar_datepicker.dart';
import 'package:addhills_app/utils/equipmentbox.dart';
import 'package:addhills_app/utils/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:addhills_app/PAGE/TOP_BUTTONS/top_navigationpop.dart';
import 'package:intl/intl.dart';

final _formKey = GlobalKey<FormState>();

class VenueRequest extends StatelessWidget {
  var height,width;
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController setDate = TextEditingController();
  final TextEditingController additionalRequirementsController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();  
  
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
                                'Venue Request',
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
                                    setDateController: setDate, 
                                    title: title,
                                    purposeController: purposeController, 
                                    additionalRequirementsController: additionalRequirementsController,
                                    startTimeController: startTimeController, 
                                    endTimeController: endTimeController,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: VenueSubmit(
                                title: title,
                                setDateController: setDate,
                                purposeController: purposeController,
                                additionalRequirementsController: additionalRequirementsController,
                                startTimeController: startTimeController, 
                                endTimeController: endTimeController,
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
  
  final TextEditingController setDateController;
  final TextEditingController purposeController;
  final TextEditingController additionalRequirementsController;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final String title;

  VenueForm({
    required this.title,
    required this.setDateController,
    required this.purposeController,
    required this.additionalRequirementsController,
    required this.startTimeController,
    required this.endTimeController,
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
              // headerForTfield(text: 'Full Name',),
              // buildName(),
              // headerForTfield(text: 'Email',),
              // buildEmail(),
              // headerForTfield(text: 'Contact Number',),
              // buildContact(),
              // headerForTfield(text: 'Birthday',),
              // buildBirthday(),   
              // headerForTfield(text: 'Address',),
              // buildAddress(), 
              headerForTfield(text: 'Purpose',),
              buildPurpose(),    
              headerForTfield(text: 'Reservation Date',),
              buildSetDate(),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    //width: 150,
                    child: Column(
                      children: [
                        headerForTfield(text: 'Start Time'),
                        buildStartTime(),
                      ],
                    ),
                  ),
                  Expanded(
                    //width: 150,
                    child: Column(
                      children: [
                        headerForTfield(text: 'End Time'),
                        buildEndTime(),
                      ],
                    ),
                  )
                ],
              ),  
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
        headerForTfield(text: 'Equipments'),
        //EquipmentBox(equipmentController: widget.additionalRequirementsController)
      ],
    );
  }

  // Widget buildName() => TextField(
  //   controller: widget.nameController,
  //   style: TextStyle(fontSize: 15),
  //   decoration: InputDecoration(
  //     hintText: 'Buong Pangalan',
  //     border: OutlineInputBorder(),
  //     isDense: true,
  //     contentPadding: EdgeInsets.all(8),
  //   ),
  //   textInputAction: TextInputAction.done,
  //   keyboardType: TextInputType.name,
  // );

  // Widget buildEmail() => TextFormField(
  //   controller: widget.emailController,
  //   style: TextStyle(fontSize: 15),
  //   decoration: InputDecoration(
  //     hintText: 'Email',
  //     border: OutlineInputBorder(),
  //     isDense: true,
  //     contentPadding: EdgeInsets.all(8),
  //   ),
  //   textInputAction: TextInputAction.done,
  //   keyboardType: TextInputType.emailAddress, // Use email address keyboard type for better UX
  //   validator: (value) {
  //     // Define the regular expression for email validation
  //     final emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  //     // Check if the value is null or does not match the regular expression
  //     if (value == null || !emailRegExp.hasMatch(value)) {
  //       // Return an error message if invalid
  //       return 'Invalid email format';
  //     }
  //     // Return null if valid
  //     return null;
  //   },
  // );


  // Widget buildContact() => TextFormField(
  //   controller: widget.contacNumController,
  //   style: TextStyle(fontSize: 15),
  //   decoration: InputDecoration(
  //     hintText: 'Numero ng Telepono', // Placeholder text
  //     border: OutlineInputBorder(),
  //     isDense: true,
  //     contentPadding: EdgeInsets.all(8),
  //   ),
  //   textInputAction: TextInputAction.done,
  //   keyboardType: TextInputType.phone, // Use phone keyboard type for better UX
  //   validator: (value) {
  //     // Define the regular expression for phone number validation
  //     final phoneRegExp = RegExp(r"^((\+63)|0)[9][0-9]{9}$");
  //     // Check if the value is null or does not match the regular expression
  //     if (value == null || !phoneRegExp.hasMatch(value)) {
  //       return 'Enter a valid phone number'; // Error message
  //     }
  //     // Return null if valid
  //     return null;
  //   },
  // );


  // Widget buildAddress() => TextField(
  //   controller: widget.addressController,
  //   style: TextStyle(fontSize: 15),
  //   decoration: InputDecoration(
  //     hintText: 'Tirahan',
  //     border: OutlineInputBorder(),
  //     isDense: true,
  //     contentPadding: EdgeInsets.all(8),
  //   ),
  //   textInputAction: TextInputAction.done,
  //   keyboardType: TextInputType.streetAddress,
  // );

  // Widget buildBirthday() => TextField(
  //   controller: widget.bdayController,
  //   style: TextStyle(fontSize: 15),
  //   decoration: InputDecoration(
  //     hintText: 'Kaarawan',
  //     border: OutlineInputBorder(),
  //     //isDense: true,
  //     contentPadding: EdgeInsets.all(8),
  //     suffixIcon: Icon(Icons.calendar_month),
  //   ),
  //   textInputAction: TextInputAction.done,
  //   //keyboardType: TextInputType.datetime,
  //   readOnly: true,
  //   onTap: () {
  //     _selectDate(context,widget.bdayController);
  //   },
  // );

  Widget buildSetDate() => TextField(
    controller: widget.setDateController,
    style: TextStyle(fontSize: 15),
    decoration: InputDecoration(
      hintText: 'Araw ng pagreserba',
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.all(8),
      suffixIcon: Icon(Icons.calendar_month),
    ),
    textInputAction: TextInputAction.done,
    readOnly: true,
    onTap: () async {
      // Navigate to VenueCalendarPage and wait for the selected date
      final selectedDate = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => VenueCalendarPage(venueName: widget.title),
        ),
      );

      // Check if a date was selected and update the TextField
      if (selectedDate != null) {
        // Format the date if necessary (e.g., 'yyyy-MM-dd')
        final formattedDate = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
        widget.setDateController.text = formattedDate;  // Update the TextField
      }
    },
  );


  Widget buildStartTime() => TextField(
    controller: widget.startTimeController,
    style: TextStyle(fontSize: 15),
    decoration: InputDecoration(
      //hintText: 'Araw ng pagreserba',
      border: OutlineInputBorder(),
      //isDense: true,
      contentPadding: EdgeInsets.all(8),
      suffixIcon: Icon(Icons.access_time),
    ),
    textInputAction: TextInputAction.done,
    //keyboardType: TextInputType.datetime,
    readOnly: true,
    onTap: () {
      _selectTime(context, widget.startTimeController);
    },
  );

  Widget buildEndTime() => TextField(
    controller: widget.endTimeController,
    style: TextStyle(fontSize: 15),
    decoration: InputDecoration(
      //hintText: 'Araw ng pagreserba',
      border: OutlineInputBorder(),
      //isDense: true,
      contentPadding: EdgeInsets.all(8),
      suffixIcon: Icon(Icons.access_time),
    ),
    textInputAction: TextInputAction.done,
    //keyboardType: TextInputType.datetime,
    readOnly: true,
    onTap: () {
      _selectTime(context, widget.endTimeController);
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

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    TimeOfDay? _picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (_picked != null) {
      // Convert TimeOfDay to DateTime
      final now = DateTime.now();
      final selectedTime = DateTime(
        now.year,
        now.month,
        now.day,
        _picked.hour,
        _picked.minute,
      );

      // Format the DateTime to 'HH:mm a'
      final formattedTime = DateFormat('h:mm a').format(selectedTime);

      setState(() {
        controller.text = formattedTime;
      });
    }
  }

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

class VenueSubmit extends StatelessWidget {
  final TextEditingController setDateController;
  final TextEditingController purposeController;
  final TextEditingController additionalRequirementsController;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final String title;

  VenueSubmit({
    required this.title,
    required this.setDateController,
    required this.purposeController,
    required this.additionalRequirementsController,
    required this.startTimeController,
    required this.endTimeController,
  });

  final DbService _dbService = DbService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dbService.getUsersInfo(getCurrentUserEmail() ?? 'No user is logged in.'), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("User not found."));
          }

          final user = snapshot.data!.data()!; // Get the UsersInfo object
          
        return Container(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 243, 109, 99),
              padding: EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10,),
            ),
            onPressed: () async{
              if (setDateController.text.isEmpty ||purposeController.text.isEmpty ||
               startTimeController.text.isEmpty ||endTimeController.text.isEmpty ||
              !_formKey.currentState!.validate()){
                _showDialog(context, 'Error', 'Please ensure all fields are completed and valid.');
              }
              else if(_formKey.currentState!.validate()){
                submitRequest(
                  context, 
                  '${user.firstName} ${user.lastName}', 
                  '${user.address}', 
                  '${user.birthday}', 
                  '${user.userEmail}', 
                  '${user.phoneNumber}');
              }
            },
            child: Text('Submit', style: TextStyle(fontSize: 15, color: Colors.white),),
          ),
        );
      },
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

  void submitRequest(
    BuildContext context, String userName, String address, String bday, String userEmail, String contactNumber,) async {
    bool confirmed = await showConfirmationDialog(context);

    if (confirmed) {
      VenueRequestModel venuereq = VenueRequestModel(
        venue_name: title,
        requester_name: userName, 
        address: address, 
        birthday: bday, 
        request_status: "Pending", 
        user_email: userEmail,
        date_requested: Timestamp.now(),
        selected_date: setDateController.text,
        user_age: calculateAge(bday),
        purpose: purposeController.text, 
        contact_number: contactNumber, 
        additional_equipments: parseEquipments(additionalRequirementsController.text), 
        start_time: startTimeController.text,
        end_time: endTimeController.text,
      );
      _dbService.addVenueReq(generateTimestampBasedId(), venuereq);
      
      setDateController.clear();
      purposeController.clear();
      additionalRequirementsController.clear();
      startTimeController.clear();
      endTimeController.clear();

      await _showDialog(
        context, 
        'Success', 
        'Your request has been submitted. An email will be sent to you once your request is approved.'
      );
      Navigator.pop(context);
    }
  }

}

