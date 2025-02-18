import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/function_type.dart';
import 'package:jobr/features/job_listing/widgets/function_type_bottom_sheet.dart';
import 'package:jobr/features/profile/screens/profile_screen.dart';
import 'package:jobr/features/profile/screens/widgets/custom_list_tile.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:intl/intl.dart'; // added for date formatting
import 'package:jobr/features/job_listing/widgets/date_time_picker.dart'; // added for date-time picker
import 'package:jobr/features/job_listing/widgets/company_type_bottomsheet.dart'; // added for company selection

// Import the bottom sheet and function type (assumed to be available)
import '../../models/list_model.dart';

class NewExpereinceScreen extends StatefulWidget {
  static const String location = 'new-experience';
  static String route = JobrRouter.getRoute(
    '${ProfileScreen.location}/$location',
    JobrRouter.employeeInitialroute,
  );
  const NewExpereinceScreen({super.key});

  @override
  State<NewExpereinceScreen> createState() => _NewExpereinceScreenState();
}

class _NewExpereinceScreenState extends State<NewExpereinceScreen> {
  final ListData initialExperience = ListData(
    image: 'assets/images/images/image-8.png',
    title: 'Functie',
    subTitle: "Bedrijf",
    duration: 'Van - Tot',
    time: 'totaal mnd',
  );
  TextEditingController companyController = TextEditingController();
  TextEditingController functionController = TextEditingController();

  // New state variables to hold mutable values
  String companyText = "";
  String functionText = "";

  FunctionType? _selectedFunction; // for function selection

  DateTime? startDate; // new state var for start date
  TimeOfDay? startTime; // new state var for start time
  DateTime? endDate; // new state var for end date
  TimeOfDay? endTime; // new state var for end time

  // helper to format date & time together
  String formatDateTime(DateTime date, TimeOfDay time) {
    final formattedDate = DateFormat('d MMM yyyy').format(date);
    final formattedTime = '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
    return '$formattedDate om $formattedTime';
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  void initState() {
    companyController.text = 'Kies een bedrijf';
    functionController.text = 'Kies een functie';
    companyText = companyController.text;
    functionText = functionController.text;
    // Listener to update companyText when text changes
    companyController.addListener(() {
      setState(() {
        companyText = companyController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    companyController.dispose();
    functionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: Center(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(
              JobrIcons.backArrow,
              width: 20,
              height: 20,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Nieuwe ervaring",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: CustomListTile2(
              image: initialExperience.image,
              title: functionText,
              subTitle: companyText,
              duration: initialExperience.duration,
              time: initialExperience.time,
              centerImage: true,
            ),
          ),
          const SizedBox(height: 10),
          // Replaced withOpacity with withAlpha (0.04 * 255 ≃ 10)
          Divider(color: const Color(0xFF000000).withAlpha(10)),
          const SizedBox(height: 20),
          // Updated "Bedrijf" field to show CompanyTypeBottomSheet on tap
          _buildTextField(
            'Bedrijf',
            companyText,
            controller: companyController,
            onTap: () {
              CompanyTypeBottomSheet(
                title: "Kies een bedrijf",
                onSelected: (companyType) {
                  setState(() {
                    companyText = companyType.name;
                    companyController.text = companyType.name;
                  });
                },
              ).showPopup(context: context);
            },
            suffixIcon: Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                JobrIcons.add,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  theme.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // "Functie" field now uses onTap to show FunctionTypeBottomSheet
          _buildTextField(
            'Functie',
            '',
            controller: functionController,
            onTap: () {
              FunctionTypeBottomSheet(
                title: "Maak een keuze",
                onSelected: (FunctionType value) {
                  setState(() {
                    _selectedFunction = value;
                    functionText = value.name;
                    functionController.text = value.name;
                  });
                },
              ).showPopup(context: context);
            },
            // Remove the existing add icon for this field
            suffixIcon: Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                JobrIcons.add,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  theme.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildPerioudField(
            'Periode',
            '',
            suffixIcon: SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                JobrIcons.calendar,
                width: 20,
                height: 20,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        child: Center(
          child: SizedBox(
            width: width,
            height: 56,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: theme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onPressed: () {
                context.pop();
              },
              child: const Text(
                "Ervaring toevoegen",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Modified _buildTextField to accept onTap and set readOnly accordingly.
  Widget _buildTextField(
    String label,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
    Widget? prefixIcon,
    Widget? suffixIcon,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            children: const [
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          readOnly: onTap != null,
          onTap: onTap,
          keyboardType: keyboardType,
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(
            fontSize: 16.5,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: HexColor.fromHex('#B7B7B7'),
              fontSize: 16.5,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor: HexColor.fromHex('#F7F7F7'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            suffix: suffixIcon,
            prefix: prefixIcon,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
          ),
        ),
      ],
    );
  }

  // _buildPerioudField remains unchanged except replacing withOpacity usage.
  Widget _buildPerioudField(
    String label,
    String hint, {
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            children: const [
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // 'Van' date & time field
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          decoration: BoxDecoration(
            color: HexColor.fromHex('#F7F7F7'),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  // Adjusted styling remains unchanged
                  color: HexColor.fromHex('#BEBEBE').withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.only(right: 5),
                width: 52,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: const Text(
                  'Van',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: TextField(
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      filled: false,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: startDate == null || startTime == null
                          ? 'Kies een datum & tijdstip'
                          : formatDateTime(startDate!, startTime!),
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: HexColor.fromHex('#B7B7B7'),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 0,
                      ),
                    ),
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      await showDialog(
                        context: context,
                        barrierColor: Colors.black54,
                        builder: (context) => Dialog(
                          insetPadding: const EdgeInsets.all(18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 800,
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.8,
                            ),
                            width: double.infinity,
                            child: CustomDateTimePicker(
                              initialDate: startDate ?? DateTime.now(),
                              initialTime: startTime ?? TimeOfDay.now(),
                              onDateTimeSelected: (date, time) {
                                setState(() {
                                  startDate = date;
                                  startTime = time;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              suffixIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // 'Tot' date & time field
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          decoration: BoxDecoration(
            color: HexColor.fromHex('#F7F7F7'),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: HexColor.fromHex('#BEBEBE').withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.only(right: 5),
                width: 52,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: const Text(
                  'Tot',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: TextField(
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      filled: false,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: endDate == null || endTime == null
                          ? 'Kies een datum & tijdstip'
                          : formatDateTime(endDate!, endTime!),
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: HexColor.fromHex('#B7B7B7'),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 0,
                      ),
                    ),
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      await showDialog(
                        context: context,
                        barrierColor: Colors.black54,
                        builder: (context) => Dialog(
                          insetPadding: const EdgeInsets.all(18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 800,
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.8,
                            ),
                            width: double.infinity,
                            child: CustomDateTimePicker(
                              initialDate: endDate ?? DateTime.now(),
                              initialTime: endTime ?? TimeOfDay.now(),
                              onDateTimeSelected: (date, time) {
                                setState(() {
                                  endDate = date;
                                  endTime = time;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              suffixIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
