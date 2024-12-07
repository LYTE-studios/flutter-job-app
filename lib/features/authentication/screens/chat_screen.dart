import 'package:flutter/material.dart';
import 'package:flutter_exam/core/routing/mixins/screen_state_mixin.dart';
import 'package:flutter_exam/features/authentication/screens/email_register_screen.dart';
import 'package:flutter_exam/features/authentication/widgets/privacy_policy_block.dart';
import 'package:flutter_exam/ui/buttons/jobr_icon_button.dart';
import 'package:flutter_exam/ui/theme/jobr_icons.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Eloquia',
          ),
        ),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        child: Padding(padding:const EdgeInsets.symmetric(horizontal: 16.0), // Add left and right padding
          child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 35, // Set the height
                      width: 52, // Set the width
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            const Color(0x00ff3e68).withOpacity(0.40),
                          ),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.0), // Oval shape
                            ),
                          ),
                        ),
                        child: const Text(
                          'Alle',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Eloquia',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    SizedBox(
                      height: 35, // Set the height
                      width: 104, // Set the width
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            const Color(0x00aeaeae).withOpacity(0.20),
                          ),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.0), // Oval shape
                            ),
                          ),
                        ),
                        child: const Text(
                          'Ongelezen',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Eloquia',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('3 verzoeken',style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Eloquia',
                  ),),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView(
                children: [
                  const Divider(
                    color: Color(0xFFD3D3D3),
                    height: 20,
                  ),
                  ListTile(
                    leading: Container(
                      width: 57,
                      height: 57,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/logos/spicy_lemon.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: const Text('Spicy Lemon',style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Eloquia',
                    )),
                    subtitle: const Text('Top, tot dan!',style: TextStyle(
                      color: Color(0xFF8F8F8F),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),),
                    trailing: const Text('09:46',style: TextStyle(
                        color: Color(0xFF8F8F8F),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
                  ),
                  const Divider(
                    color: Color(0xFFD3D3D3),
                    height: 20,
                  ),
                  ListTile(
                    leading: Container(
                      width: 57,  // Set the width of the image
                      height: 57, // Set the height of the image
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/logos/brooklyn_kortrijk.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: const Text('Brooklyn Kortrijk',style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Eloquia',
                    )),
                    subtitle: const Text('Ik: Plannen we anders..',style: TextStyle(
                      color: Color(0xFF8F8F8F),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),),
                    trailing: const Column(
                      children: [
                        Text('07:23',style: TextStyle(
                          color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Center(
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFD3D3D3),
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ))
      ),
    );
  }
}
