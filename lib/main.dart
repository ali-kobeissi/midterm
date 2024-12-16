import 'package:flutter/material.dart';

void main() => runApp(ContactFormApp());

class ContactFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactFormPage(),
    );
  }
}

class ContactFormPage extends StatefulWidget {
  @override
  _ContactFormPageState createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _gender = '';
  String _preferredContactMethod = 'Email';
  bool _subscribeToNewsletter = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String subscription = _subscribeToNewsletter ? 'Yes' : 'No';

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Form Submitted'),
          content: Text(
              'Name: $name\nEmail: $email\nGender: $_gender\nPreferred Contact Method: $_preferredContactMethod\nSubscribe to Newsletter: $subscription'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _clearForm() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    setState(() {
      _gender = '';
      _preferredContactMethod = 'Email';
      _subscribeToNewsletter = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'A Simple Contact Form',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('Gender:'),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 'Male',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value.toString();
                            });
                          },
                        ),
                        Text('Male'),
                      ],
                    ),
                    SizedBox(width: 16.0),
                    Row(
                      children: [
                        Radio(
                          value: 'Female',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value.toString();
                            });
                          },
                        ),
                        Text('Female'),
                      ],
                    ),
                    SizedBox(width: 16.0),
                    Row(
                      children: [
                        Radio(
                          value: 'Other',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value.toString();
                            });
                          },
                        ),
                        Text('Other'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField(
                  value: _preferredContactMethod,
                  decoration: InputDecoration(
                    labelText: 'Preferred Contact Method',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  items: ['Email', 'Phone', 'SMS']
                      .map((method) => DropdownMenuItem(
                    value: method,
                    child: Text(method),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _preferredContactMethod = value.toString();
                    });
                  },
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Checkbox(
                      value: _subscribeToNewsletter,
                      onChanged: (value) {
                        setState(() {
                          _subscribeToNewsletter = value!;
                        });
                      },
                    ),
                    Text('Subscribe to newsletter'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Row(
                        children: [
                          Icon(Icons.check),
                          SizedBox(width: 5),
                          Text('Submit'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _clearForm,
                      child: Row(
                        children: [
                          Icon(Icons.close),
                          SizedBox(width: 5),
                          Text('Clear'),
                        ],
                      ),
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
