import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myccaa/bottom_tab/admin_tab_screen.dart';
import 'package:myccaa/bottom_tab/bottom_tab_screen.dart';
import 'dart:io';
import 'components/customTextField.dart';
import 'news_feed/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _fNameController = TextEditingController();
  final _sNameController = TextEditingController();
  final otpCode = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _ageController = TextEditingController();
  String _selectedGender = '';
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _doctorIdController = TextEditingController();

  bool _isDoctor = false;

  String? verificationId;

  @override
  void dispose() {
    _fNameController.dispose();
    _phoneNumberController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _doctorIdController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
  if (_fNameController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty &&
      _ageController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _repeatPasswordController.text == _passwordController.text &&
      _sNameController.text.isNotEmpty &&

      _selectedGender.isNotEmpty) {

    String fName = _fNameController.text;
    String sName = _sNameController.text;
    String phoneNumber = _phoneNumberController.text;
    String age = _ageController.text;
    String gender = _selectedGender;
    String password = _passwordController.text;
    String repeatPassword = _repeatPasswordController.text;
    String doctorId = _doctorIdController.text;

    _onVerificationCompleted(PhoneAuthCredential authCredential) async {

      databaseRef.child("doctors").child(doctorId.trim()).set({
        'first name': fName.trim(),
        'second name': sName.trim(),
        'phoneNumber': phoneNumber.trim(),
        'age': age.trim(),
        'password': password.trim(),
        'Id': doctorId.trim(),
        'gender': gender,
      });

      var snackBar = const SnackBar(
        content: Text( "Doctor created successfully",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminTabScreen(Id: doctorId.trim(),)),
      );

    }

    _onVerificationFailed(FirebaseAuthException exception) {
      if (exception.code == 'invalid-phone-number') {
        var snackBar = const SnackBar(
          content: Text( "The number entered is invalid",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    _onCodeSent(String verificationId, int? forceResendingToken) {
      this.verificationId = verificationId;
      print(forceResendingToken);
      var snackBar = const SnackBar(
        content: Text( "Code Sent",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    _onCodeTimeout(String timeout) {
      return null;
    }

    if (_isDoctor) {

      // await FirebaseAuth.instance.verifyPhoneNumber(
      //     phoneNumber: phoneNumber,
      //     verificationCompleted: _onVerificationCompleted,
      //     verificationFailed: _onVerificationFailed,
      //     codeSent: _onCodeSent,
      //     codeAutoRetrievalTimeout: _onCodeTimeout);

      databaseRef.child("doctors").child(doctorId.trim()).set({
        'first name': fName.trim(),
        'second name': sName.trim(),
        'phoneNumber': phoneNumber.trim(),
        'age': age.trim(),
        'password': password.trim(),
        'Id': doctorId.trim(),
        'gender': gender,
      });

      var snackBar = const SnackBar(
        content: Text( "Doctor created successfully",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminTabScreen(Id: doctorId.trim(),)),
      );
    } else {

      databaseRef.child("patients").child(phoneNumber.trim()).set({
        'first name': fName.trim(),
        'second name': sName.trim(),
        'phoneNumber': phoneNumber.trim(),
        'age': age.trim(),
        'password': password.trim(),
        'gender': gender,
      });

      var snackBar = const SnackBar(
        content: Text( "Patient created successfully",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Navigate to PatientHomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomTabScreen(Id: _phoneNumberController.text.trim(),)),
      );
    }
  }else{
    var snackBar = const SnackBar(
      content: Text( "Check details and try again",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20.0),

                  CustomTextField(
                      controller: _fNameController,
                      data: Icons.supervised_user_circle,
                      hintText: 'First Name',
                      isObsecure: false,
                      textInputType: TextInputType.text,
                      labelText: 'First Name',
                      maxlines: null,
                      minlines: null),

                  const SizedBox(height: 20,),

                  CustomTextField(
                      controller: _sNameController,
                      data: Icons.supervised_user_circle,
                      hintText: 'Second Name',
                      isObsecure: false,
                      textInputType: TextInputType.text,
                      labelText: 'Second Name',
                      maxlines: null,
                      minlines: null),

                  const SizedBox(height: 20,),

                  CustomTextField(
                      controller: _phoneNumberController,
                      data: Icons.phone,
                      hintText: 'Phone Number',
                      isObsecure: false,
                      textInputType: TextInputType.number,
                      labelText: 'Phone Number',
                      maxlines: null,
                      minlines: null),

                  const SizedBox(height: 20,),

                  CustomTextField(
                      controller: _ageController,
                      data: Icons.timelapse,
                      hintText: 'Age',
                      isObsecure: false,
                      textInputType: TextInputType.number,
                      labelText: 'Age',
                      maxlines: null,
                      minlines: null),

                  const SizedBox(height: 20,),

                  Text(
                    'Gender',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  RadioListTile(
                    title: const Text('Male'),
                    value: 'Male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Female'),
                    value: 'Female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value.toString();
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  CustomTextField(
                      controller: _passwordController,
                      data: Icons.lock,
                      hintText: 'Password',
                      isObsecure: false,
                      textInputType: TextInputType.visiblePassword,
                      labelText: 'Password',
                      maxlines: null,
                      minlines: null),

                  const SizedBox(height: 20,),

                  CustomTextField(
                      controller: _repeatPasswordController,
                      data: Icons.lock,
                      hintText: 'Repeat password',
                      isObsecure: false,
                      textInputType: TextInputType.text,
                      labelText: 'Repeat password',
                      maxlines: null,
                      minlines: null),

                  const SizedBox(height: 20,),

                  if (_isDoctor)
                    CustomTextField(
                        controller: _doctorIdController,
                        data: Icons.badge,
                        hintText: 'ID',
                        isObsecure: false,
                        textInputType: TextInputType.text,
                        labelText: 'ID',
                        maxlines: null,
                        minlines: null),

                  // const SizedBox(height: 20,),
                  //
                  // CustomTextField(
                  //     controller: otpCode,
                  //     data: Icons.lock,
                  //     hintText: 'Enter OTP',
                  //     isObsecure: false,
                  //     textInputType: TextInputType.number,
                  //     labelText: 'Enter OTP',
                  //     maxlines: null,
                  //     minlines: null),

                  const SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _isDoctor,
                            onChanged: (value) {
                              setState(() {
                                _isDoctor = value!;
                              });
                            },
                          ),
                          Text('Sign up as a doctor'),
                        ],
                      ),
                      Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: _signUp,
                      child: const Text('Sign up'),
                    ),
                  ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement navigation to the login page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text('Log in'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _idController = TextEditingController();

  bool _isDoctor = false;

  bool isLoading = false;

  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 255, 255, 255), // set the background color here

      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),

                Image.asset('assets/logo.jpg'),

                const SizedBox(height: 20,),

                CustomTextField(
                  controller: _phoneController,
                  data: Icons.phone,
                  hintText: 'Phone Number',
                  isObsecure: false,
                  textInputType: TextInputType.number,
                  labelText: 'Phone Number',
                  maxlines: null, minlines: null,

                ),

                const SizedBox(height: 20.0),

                CustomTextField(
                  controller: _passwordController,
                  data: Icons.lock,
                  hintText: 'Password',
                  isObsecure: false,
                  textInputType: TextInputType.text,
                  labelText: 'Password',
                  maxlines: null, minlines: null,
                ),

                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isDoctor,
                      onChanged: (value) {
                        setState(() {
                          _isDoctor = value!;
                        });
                      },
                    ),
                    const Text('Login as a CHO'),
                  ],
                ),
                if (_isDoctor)
                  CustomTextField(
                    controller: _idController,
                    data: Icons.badge_outlined,
                    hintText: 'ID',
                    isObsecure: false,
                    textInputType: TextInputType.text,
                    labelText: 'ID',
                    maxlines: null, minlines: null,

                  ),

                Center(child: Visibility(visible: isLoading,
                  child: Stack(
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          width: 300.0,
                          height: 200.0,
                          alignment: AlignmentDirectional.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 50.0,
                                  width: 50.0,
                                  child: CircularProgressIndicator(
                                    value: null,
                                    strokeWidth: 7.0,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 25),
                                child: Center(
                                  child: Text(
                                    "Please wait ...",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),)),

                const SizedBox(height: 15),

                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String phone = _phoneController.text;
                      String password = _passwordController.text;
                      String id = _idController.text;

                      final databaseRefDoc = FirebaseDatabase.instance.ref().child('doctors').child(id).child('password');
                      final databaseRef = FirebaseDatabase.instance.ref().child('patients').child(phone).child('password');

                      setState(() {
                        isLoading = true;
                      });

                      if (_isDoctor) {

                        final snapshot = await databaseRefDoc.get();
                        if(snapshot.exists && snapshot.value.toString() == password){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminTabScreen(Id: id,)),
                          );


                          setState(() {
                            isLoading = false;
                          });

                        }else{

                          setState(() {
                            isLoading = false;
                          });

                          var snackBar = const SnackBar(
                            content: Text( "Doctor details provided incorrect",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }

                        setState(() {
                          isLoading = false;
                        });

                      } else {

                        final snapshot = await databaseRef.get();
                        if(snapshot.exists && snapshot.value.toString() == password){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomTabScreen(Id: _phoneController.text.trim(),)),
                          );


                        } else {
                          setState(() {
                            isLoading = false;
                          });

                          var snackBar = const SnackBar(
                            content: Text( "Patient details provided incorrect",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);


                          setState(() {
                            isLoading = false;
                          });

                        }

                      }
                    } else{

                      setState(() {
                        isLoading = false;
                      });

                      var snackBar = const SnackBar(
                        content: Text( "Check details and try again",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);


                      setState(() {
                        isLoading = false;
                      });
                    }

                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Text('Log In'),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dont have an account?'),
                    TextButton(
                      onPressed: () {

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()),
                        );
                      },
                      child: const Text('Sign up here'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  late TimeOfDay _selectedTime;
  late DateTime _selectedDate;
  List<Reminder> _reminders = [];

  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();
    _selectedDate = DateTime.now();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (newTime != null) {
      setState(() {
        _selectedTime = newTime;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (newDate != null) {
      setState(() {
        _selectedDate = newDate;
      });
    }
  }

  void _addReminder() {
    final newreminder = Reminder(
      title: _selectedTime.format(context),
      date: _selectedDate,
      time: _selectedTime,
    );
    setState(() {
      _reminders.add(newreminder);
    });
  }

  void _deleteReminder(int index) {
    setState(() {
      _reminders.removeAt(index);
    });
  }

  void _editReminder(int index) async {
    final editedReminder = await showDialog<Reminder>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Reminder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller:
                    TextEditingController(text: _reminders[index].title),
                onChanged: (value) {
                  _reminders[index] = _reminders[index].copyWith(title: value);
                },
              ),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: const Text('Select Time'),
              ),
              Text(
                'Selected Time: ${_selectedTime.format(context)}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Select Date'),
              ),
              Text(
                'Selected Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, _reminders[index]);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    if (editedReminder != null) {
      setState(() {
        _reminders[index] = editedReminder;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder'),
      ),
      body: Center(
        child: _reminders.isEmpty
            ? const Text('You have no reminders')
            : ListView.builder(
                itemCount: _reminders.length,
                itemBuilder: (context, index) {
                  final reminder = _reminders[index];
                  return ListTile(
                    title: Text(
                      reminder.title.isNotEmpty ? reminder.title : 'No Title',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      'Date: ${reminder.date.day}/${reminder.date.month}/${reminder.date.year}, '
                      'Time: ${reminder.time.format(context)}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => _editReminder(index),
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () => _deleteReminder(index),
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Create Reminder'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      onChanged: (value) {
                        // TODO: Store the title in a variable

                      },
                    ),
                    ElevatedButton(
                      onPressed: () => _selectTime(context),
                      child: const Text('Select Time'),
                    ),
                    Text(
                      'Selected Time: ${_selectedTime.format(context)}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Select Date'),
                    ),
                    Text(
                      'Selected Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      _addReminder();
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Reminder {
  final String title;
  final DateTime date;
  final TimeOfDay time;

  Reminder({
    required this.title,
    required this.date,
    required this.time,
  });

  Reminder copyWith({
    String? title,
    DateTime? date,
    TimeOfDay? time,
  }) {
    return Reminder(
      title: title ?? this.title,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }
}


class DatabasePage extends StatefulWidget {
  final String Id;
  const DatabasePage({Key? key, required this.Id}) : super(key: key);

  @override
  _DatabasePageState createState() => _DatabasePageState(Id: Id);
}

class _DatabasePageState extends State<DatabasePage> {

  final String Id;
  _DatabasePageState({ required this.Id});

  final TextEditingController _idTextEditingController = TextEditingController();
  final TextEditingController _tempTextEditingController = TextEditingController();
  final TextEditingController _bpTextEditingController = TextEditingController();
  final TextEditingController _weightTextEditingController = TextEditingController();
  final TextEditingController _complainTextEditingController = TextEditingController();
  final TextEditingController _remarksTextEditingController = TextEditingController();
  final TextEditingController _prescribeTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final databaseRef = FirebaseDatabase.instance.ref();

  Future<void> insert() async {
    if (_formKey.currentState!.validate()) {
      String pId = _idTextEditingController.text.trim();
      String temp = _tempTextEditingController.text.trim();
      String bp = _bpTextEditingController.text.trim();
      String weight = _weightTextEditingController.text.trim();
      String complain = _complainTextEditingController.text.trim();
      String remarks = _remarksTextEditingController.text.trim();
      String prescribe = _prescribeTextEditingController.text.trim();

      DateTime now = DateTime.now();
      DateTime date = DateTime(now.year, now.month, now.day);

      final snapshot = await FirebaseDatabase.instance.ref().child('patients').child(pId).get();
      final snapshot2 = await FirebaseDatabase.instance.ref().child('doctors').child(Id).get();

      if(snapshot.exists){

        Map patient = snapshot.value as Map;
        Map doctor = snapshot2.value as Map;

        databaseRef.child("records").child(pId+date.toString()
            .replaceAll("00:00:00.000", "")).set({
          'patient Id': pId,
          'doctor id': Id,
          'bp': bp,
          'patient name': patient['first name']+' '+patient['second name'],
          'doctor name': doctor['first name']+' '+doctor['second name'],
          'temperature': temp,
          'date': date.toString().replaceAll("00:00:00.000", ""),
          'weight': weight,
          'complain': complain,
          'remarks': remarks,
          'prescribe': prescribe,
        });

        var snackBar = const SnackBar(
          content: Text( "Recorded successfully",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          _idTextEditingController.clear();
          _tempTextEditingController.clear();
          _weightTextEditingController.clear();
          _complainTextEditingController.clear();
          _remarksTextEditingController.clear();
          _prescribeTextEditingController.clear();
        });

      }else{

        var snackBar = const SnackBar(
          content: Text( "Invalid patient id",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }



    }else{
      var snackBar = const SnackBar(
        content: Text( "Check fields and try again",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                const SizedBox(height: 10),

                CustomTextField(
                  controller: _idTextEditingController,
                  data: Icons.abc,
                  hintText: 'Enter patient Id',
                  isObsecure: false,
                  textInputType: TextInputType.text,
                  labelText: 'Enter patient Id',
                  maxlines: null,
                  minlines: null,
                ),
                const SizedBox(height: 10),

                CustomTextField(
                  controller: _tempTextEditingController,
                  data: Icons.abc,
                  hintText: 'Enter patient temperature',
                  isObsecure: false,
                  textInputType: TextInputType.text,
                  labelText: 'Enter patient temperature',
                  maxlines: null,
                  minlines: null,
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  controller: _weightTextEditingController,
                  data: Icons.abc,
                  hintText: 'Enter Weight',
                  isObsecure: false,
                  textInputType: TextInputType.text,
                  labelText: 'Enter weight',
                  maxlines: null,
                  minlines: null,
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  controller: _bpTextEditingController,
                  data: Icons.abc,
                  hintText: 'Enter blood pressure',
                  isObsecure: false,
                  textInputType: TextInputType.text,
                  labelText: 'Enter blood pressure',
                  maxlines: null,
                  minlines: null,
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  controller: _complainTextEditingController,
                  data: Icons.abc,
                  hintText: 'patient complain',
                  isObsecure: false,
                  textInputType: TextInputType.text,
                  labelText: 'patient complain',
                  maxlines: null,
                  minlines: 5,
                ),
                const SizedBox(height: 10),

                CustomTextField(
                  controller: _remarksTextEditingController,
                  data: Icons.abc,
                  hintText: 'Enter Remarks',
                  isObsecure: false,
                  textInputType: TextInputType.text,
                  labelText: 'Enter Remarks',
                  maxlines: null,
                  minlines: 5,
                ),
                const SizedBox(height: 10),

                CustomTextField(
                  controller: _prescribeTextEditingController,
                  data: Icons.abc,
                  hintText: 'Prescription',
                  isObsecure: false,
                  textInputType: TextInputType.text,
                  labelText: 'Prescription',
                  maxlines: null,
                  minlines: 5,
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    ElevatedButton(
                      onPressed: (){
                        insert();
                      },
                      child: const Text('Done'),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class BroadcastPage extends StatefulWidget {
  final String Id;
  const BroadcastPage({Key? key, required this.Id}) : super(key: key);

  @override
  _BroadcastPageState createState() => _BroadcastPageState(Id: Id);
}

class _BroadcastPageState extends State<BroadcastPage> {

  final String Id;
  _BroadcastPageState({required this.Id});

  final TextEditingController _contentTextEditingController = TextEditingController();
  final TextEditingController _titleTextEditingController = TextEditingController();
  final TextEditingController _descriptionTextEditingController = TextEditingController();

  bool isLoading = false;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final databaseRef = FirebaseDatabase.instance.ref();

  String _message = '';

  bool _loading = true;
  ImagePicker picker = ImagePicker();
  late File _image;

  Future<void> _sendMessage() async {
    if (_contentTextEditingController.text.isNotEmpty && _titleTextEditingController.text.isNotEmpty
     && _descriptionTextEditingController.text.isNotEmpty && _loading != true) {

      setState(() {
        isLoading = true;
      });

      final storageRef = storage.ref().child('images').child(_image.path);
      await storageRef.putFile(_image);

      final downloadUrl = await storageRef.getDownloadURL();

      String datetime = DateTime.now().toString();
      //print(downloadUrl);

      final snapshot = await FirebaseDatabase.instance.ref().child('doctors').child(Id).get();
      Map user = snapshot.value as Map;

      String name = 'Dr. Name Here';
      databaseRef.child('broadcast').child(Id.replaceAll(RegExp('[^A-Za-z0-9]'), '')+
      datetime.replaceAll(RegExp('[^A-Za-z0-9]'), '')).set({
        'author': user['first name']+' '+user['second name'],
        'author id': Id,
        'title': _titleTextEditingController.text.trim(),
        'description': _descriptionTextEditingController.text.trim(),
        'image': downloadUrl,
        'date': datetime,
        'content': _contentTextEditingController.text.toString(),
      });
      // StorageUploadTask uploadTask = storageRef.putFile(_image);
      // StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

      setState(() {
        isLoading = false;
      });

      var snackBar = const SnackBar(
        content: Text( "Broadcast Successful",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      setState(() {
        _titleTextEditingController.clear();
        _descriptionTextEditingController.clear();
        _contentTextEditingController.clear();
        _loading = true;
      });
      // TODO: Send message logic here
    }else{
      var snackBar = const SnackBar(
        content: Text( "All fields must not be empty",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  pickGalleryImage() async {
    //this function to grab the image from gallery
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text('Send News Feed'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const SizedBox(height: 10),

              GestureDetector(
                onTap: pickGalleryImage,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 2,
                              blurRadius: 10
                          )
                        ]
                    ),

                    child: Stack(
                      children: [
                        SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Container(

                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(30),
                              image:  DecorationImage(
                                image:_loading == true
                                    ?const AssetImage('assets/logo.jpg')
                                    :FileImage(_image) as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        const Positioned(bottom: 15,
                          right: 15,
                          child: Icon(Icons.edit,size: 55.0,color: Colors.black,),)
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              CustomTextField(
                controller: _titleTextEditingController,
                data: Icons.abc,
                hintText: 'Enter news title',
                isObsecure: false,
                textInputType: TextInputType.text,
                labelText: 'Enter news title',
                maxlines: null,
                minlines: null,
              ),
              const SizedBox(height: 10),

              CustomTextField(
                controller: _contentTextEditingController,                data: Icons.abc,
                hintText: 'Enter news content',
                isObsecure: false,
                textInputType: TextInputType.text,
                labelText: 'Enter news content',
                maxlines: null,
                minlines: 5,
              ),
              const SizedBox(height: 10),

             CustomTextField(
                controller: _descriptionTextEditingController,
                data: Icons.abc,
                hintText: 'Enter news description',
                isObsecure: false,
                textInputType: TextInputType.text,
                labelText: 'Enter news description',
                maxlines: null,
                minlines: null,
              ),

              Center(child: Visibility(visible: isLoading,
                child: Stack(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        width: 300.0,
                        height: 200.0,
                        alignment: AlignmentDirectional.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                height: 50.0,
                                width: 50.0,
                                child: CircularProgressIndicator(
                                  value: null,
                                  strokeWidth: 7.0,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              child: Center(
                                child: Text(
                                  "Please wait ...",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),)),

              Row(
                children: [

                  ElevatedButton(
                    onPressed: _sendMessage,
                    child: const Text('Send'),
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              Text(
                'Note: This is a broadcast message and you will not receive any replies.',
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


