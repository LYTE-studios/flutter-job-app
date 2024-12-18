import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewCompanyPage extends StatefulWidget {
  @override
  _NewCompanyPageState createState() => _NewCompanyPageState();
}

class _NewCompanyPageState extends State<NewCompanyPage> {
  TextEditingController btwController = TextEditingController();
  FocusNode btwFocusNode = FocusNode(); // Add FocusNode to track focus state.
  bool isBtwValid = false;
  bool isBtwFilled = false;

  @override
  void initState() {
    super.initState();
    btwController.addListener(_validateBtwField);
    btwFocusNode.addListener(() {
      setState(() {}); // Update the UI when the focus state changes.
    });
  }

  final RegExp btwRegex = RegExp(r'^BE \d{4}\.\d{3}\.\d{3}$');

  void _validateBtwField() {
    setState(() {
      String text = btwController.text;
      isBtwFilled = text.isNotEmpty;
      isBtwValid = btwRegex.hasMatch(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/icons/vector.svg',
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        title: Text(
          'Nieuw bedrijf',
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'BTW nummer',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    TextFormField(
                      focusNode: btwFocusNode, // Attach FocusNode
                      cursorColor: Colors.pinkAccent.withOpacity(0.5),
                      cursorHeight: 25,
                      controller: btwController,
                      style: TextStyle(fontSize: 19, fontFamily: 'Poppins'),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: btwFocusNode.hasFocus &&
                                  btwController.text.isEmpty
                              ? Colors.pink.withOpacity(0.7)
                              : Colors.grey,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                        hintText: 'BE 0000.000.000',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        suffixIcon: isBtwFilled
                            ? Icon(
                                isBtwValid ? Icons.check_circle : Icons.cancel,
                                color: isBtwValid ? Colors.green : Colors.red,
                              )
                            : null,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: isBtwFilled
                                ? (isBtwValid
                                    ? Colors.green
                                    : Colors.red.withOpacity(0.5))
                                : Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        ),
                        filled: true,
                        fillColor:
                            btwFocusNode.hasFocus && btwController.text.isEmpty
                                ? Colors.red.shade50.withOpacity(0.7)
                                : Colors.grey.shade100,
                      ),
                    ),
                    if (isBtwValid) ...[
                      SizedBox(height: 15),
                      TextField(
                        cursorHeight: 22,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          hintText: 'Nude BV',
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                        ),
                      ),
                    ],
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 5),
                      child: Text(
                        'We vragen je BTW nummer om te verifiëren dat het gaat om een bestaand bedrijf. Onderstaande gegevens worden dan ook automatisch ingevuld.',
                        style: TextStyle(
                            color: isBtwFilled && !isBtwValid
                                ? Colors.red
                                : Colors.black54,
                            fontSize: 11,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Algemene gegevens',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins'),
                    ),
                    SizedBox(height: 7),
                    Divider(
                      color: Colors.grey.shade100,
                      thickness: 1,
                    ),
                    buildInputField('Naam*', 'bv. Carrefour'),
                    SizedBox(height: 15),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Adres',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: buildInputField(null, 'Straatnaam'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: buildInputField(null, 'Nummer'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: buildInputField(null, 'Stad'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: buildInputField(null, 'Postcode'),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  elevation: 2,
                  minimumSize:
                      Size(double.infinity, 50), // Make button take full width
                ),
                onPressed: () {
                  // Next step action
                },
                child: Text(
                  'Volgende stap',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
              ),
            ),
            SizedBox(height: 10), // Add some space at the bottom
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String? label, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Naam',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                ),
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 5),
        TextField(
          cursorHeight: 25,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            hintText: placeholder,
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    btwController.dispose();
    btwFocusNode.dispose(); // Dispose FocusNode to prevent memory leaks.
    super.dispose();
  }
}
