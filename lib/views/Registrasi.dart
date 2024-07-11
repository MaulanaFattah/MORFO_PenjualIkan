import 'package:flutter/material.dart';
import 'package:morfo/provider/theme_provider.dart';
import 'package:morfo/views/LoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;
  bool _passwordsMatch = true;
  bool _isLoading = false;
  double _progressValue = 0.0;

  int _selectedDay = 1;
  String _selectedMonth = 'January';
  int _selectedYear = DateTime.now().year;
  List<int> _daysInMonth = List.generate(31, (index) => index + 1);

  @override
  void initState() {
    super.initState();
    _updateDaysInMonth();
  }

  void _updateDaysInMonth() {
    int daysCount =
        DateTime(_selectedYear, _getMonthNumber(_selectedMonth) + 1, 0).day;
    setState(() {
      _daysInMonth = List.generate(daysCount, (index) => index + 1);
      if (_selectedDay > daysCount) {
        _selectedDay = daysCount;
      }
    });
  }

  int _getMonthNumber(String month) {
    return DateFormat('MMMM').parse(month).month;
  }

  @override
  Widget build(BuildContext context) {
    final darkModeProv = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      backgroundColor: darkModeProv.isDarkMode ? Colors.black : Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Image.asset('assets/images/logo-apps.png', width: 150),
                  SizedBox(height: 20),
                  Text(
                    'Lets Sign you in',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color:
                          darkModeProv.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: darkModeProv.isDarkMode
                                ? Colors.white
                                : Colors.pink,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.pink,
                            ),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Registrasi',
                            style: TextStyle(
                              color: darkModeProv.isDarkMode
                                  ? Colors.white
                                  : Colors.pink,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Create your account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color:
                          darkModeProv.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person,
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black),
                      labelStyle: TextStyle(
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black),
                    ),
                    style: TextStyle(
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.black),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.calendar_today,
                          size: 20,
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Date of Birth',
                        style: TextStyle(
                          fontSize: 16,
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedMonth,
                          items: <String>[
                            'January',
                            'February',
                            'March',
                            'April',
                            'May',
                            'June',
                            'July',
                            'August',
                            'September',
                            'October',
                            'November',
                            'December'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    color: darkModeProv.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedMonth = value!;
                              _updateDaysInMonth();
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Month',
                            labelStyle: TextStyle(
                                color: darkModeProv.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          dropdownColor: darkModeProv.isDarkMode
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: _selectedDay,
                          items: _daysInMonth
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(
                                ' $value',
                                style: TextStyle(
                                    color: darkModeProv.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedDay = value!;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Day',
                            labelStyle: TextStyle(
                                color: darkModeProv.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          dropdownColor: darkModeProv.isDarkMode
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: _selectedYear,
                          items: List.generate(100, (index) {
                            return DropdownMenuItem(
                              value: DateTime.now().year - index,
                              child: Text(
                                ' ${DateTime.now().year - index}',
                                style: TextStyle(
                                    color: darkModeProv.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            );
                          }),
                          onChanged: (value) {
                            setState(() {
                              _selectedYear = value!;
                              _updateDaysInMonth();
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Year',
                            labelStyle: TextStyle(
                                color: darkModeProv.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          dropdownColor: darkModeProv.isDarkMode
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email,
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black),
                      labelStyle: TextStyle(
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black),
                    ),
                    style: TextStyle(
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.black),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock,
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordObscure = !_isPasswordObscure;
                          });
                        },
                      ),
                      labelStyle: TextStyle(
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black),
                    ),
                    obscureText: _isPasswordObscure,
                    style: TextStyle(
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.black),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock,
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordObscure =
                                !_isConfirmPasswordObscure;
                          });
                        },
                      ),
                      errorText:
                          _passwordsMatch ? null : 'Passwords do not match',
                      labelStyle: TextStyle(
                          color: darkModeProv.isDarkMode
                              ? Colors.white
                              : Colors.black),
                    ),
                    obscureText: _isConfirmPasswordObscure,
                    onChanged: (_) {
                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        setState(() {
                          _passwordsMatch = false;
                        });
                      } else {
                        setState(() {
                          _passwordsMatch = true;
                        });
                      }
                    },
                    style: TextStyle(
                        color: darkModeProv.isDarkMode
                            ? Colors.white
                            : Colors.black),
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Registrasi',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Login with',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          darkModeProv.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle Facebook login
                        },
                        icon: Icon(Icons.facebook, color: Colors.blue),
                        label: Text('Facebook'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle Google login
                        },
                        icon: Icon(Icons.g_mobiledata_outlined,
                            color: Colors.red),
                        label: Text('Google'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _register() async {
    setState(() {
      _isLoading = true;
      _progressValue = 0.0;
    });

    for (var progress = 0.1; progress < 1.0; progress += 0.1) {
      await Future.delayed(Duration(milliseconds: 300));
      setState(() {
        _progressValue = progress;
      });
    }

    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String dob = "$_selectedDay/$_selectedMonth/$_selectedYear";

    if (password != confirmPassword || password.length < 2) {
      setState(() {
        _passwordsMatch = false;
        _isLoading = false;
      });
      return;
    }

    print('Name: $name');
    print('Email: $email');
    print('Password: $password');
    print('Date of Birth: $dob');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registration successful'),
      ),
    );

    setState(() {
      _isLoading = false;
    });
  }
}
