import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/profile/screens/company/edit_company_profile_screen.dart';
import 'package:jobr/features/profile/screens/company_screen/base_navbar.dart';
import 'package:jobr/features/profile/screens/company_screen/settings_screen.dart';
import 'package:jobr/features/profile/screens/tabs/general_item_widget.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/foundation.dart'; // add this import
import 'package:flutter/gestures.dart'; // add this import
import 'package:url_launcher/url_launcher.dart'; // add this import

class CompanyProfileScreen extends StatefulWidget {
  static const String location = 'company-profile';

  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  int selectedIndex = 0;

  List<Widget> tabs = const [
    GeneralItemsWidget(),
  ];

  GoogleMapController? _mapController;
  LatLng _currentLocation = const LatLng(51.9225, 4.47917); // Default location
  Set<Marker> _markers = {};
  bool _hasData = true; // Flag to check if data is available

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _checkDataAvailability();
  }

  // Method to check if data is available
  void _checkDataAvailability() {
    // This is a placeholder implementation. In a real app, you would check
    // if the required data is available from your data source (API, database, etc.)
    // For demonstration purposes, you can toggle this value to see the empty state
    setState(() {
      // Set to false to see the empty state, true to see the normal content
      _hasData = true;
    });
  }

  // Method to toggle the empty state for testing
  void toggleEmptyState() {
    setState(() {
      _hasData = !_hasData;
    });
  }

  Future<void> _initializeLocation() async {
    try {
      List<Location> locations = await locationFromAddress(
          "Kortrijk"); // Replace with actual company location
      if (locations.isNotEmpty) {
        setState(() {
          _currentLocation =
              LatLng(locations.first.latitude, locations.first.longitude);
          _markers = {
            Marker(
              markerId: const MarkerId('companyLocation'),
              position: _currentLocation,
            ),
          };
        });
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                centerTitle: true,
                title: innerBoxIsScrolled
                    ? const Text(
                        "Brooklyn Kortrijk",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : null,
                scrolledUnderElevation: 0,
                elevation: 0,
                leading: innerBoxIsScrolled
                    ? Transform.translate(
                        offset: const Offset(16.0,
                            0.0), // Shift widget left without negative margin
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: ClipOval(
                            child: SizedBox(
                              width: 40, // Set the exact size
                              height: 40,
                              child: Image.asset(
                                'assets/images/logos/brooklyn_kortrijk.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ))
                    : null,
                backgroundColor: theme.colorScheme.surface,
                clipBehavior: Clip.none,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Hero(
                          tag: 'profileBackground',
                          child: GestureDetector(
                            onTap: () {
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: 'Dismiss',
                                barrierColor: Colors.black54,
                                pageBuilder: (_, __, ___) => ZoomImageDialog(
                                  height: 200,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  tag: 'profileBackground',
                                  imagePath:
                                      'assets/images/images/profile_image.png',
                                ),
                              );
                            },
                            child: Image.asset(
                              'assets/images/images/profile_image.png',
                              fit: BoxFit.cover,
                              height: 180,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: Hero(
                          tag: 'profileLogo',
                          child: GestureDetector(
                            onTap: () {
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: 'Dismiss',
                                barrierColor: Colors.black54,
                                pageBuilder: (_, __, ___) => ZoomImageDialog(
                                  height: 200,
                                  width: 200,
                                  tag: 'profileLogo',
                                  imagePath:
                                      'assets/images/logos/brooklyn_kortrijk.png',
                                ),
                              );
                            },
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/logos/brooklyn_kortrijk.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top:
                            157, // Updated from bottom: 40 to align half above and half below image end (height 180)
                        right: 60,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.push(EditCompanyProfileScreen.route);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                          ),
                          label: Text(
                            "Aanpassen",
                            style: TextStyle(
                              color: TextStyles.clearText,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          icon: SvgPicture.asset(
                            JobrIcons.edit,
                            width: 16,
                            height: 16,
                            colorFilter: ColorFilter.mode(
                              TextStyles.clearText,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top:
                            160, // Updated from bottom: 43 to align similarly with the image
                        right: 10,
                        child: InkWell(
                          onTap: () {
                                                                  context.push(SettingsScreen.route);

                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade100,
                            ),
                            child: SvgIcon(
                              JobrIcons.settings1,
                              size: 20.68,
                              color: TextStyles.disabledText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: _hasData
              ? ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const ClampingScrollPhysics(),
                  children: [
                    const Text(
                      "Brooklyn Kortrijk",
                      style: TextStyle(
                          fontSize: 23.43,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse("http://www.brooklyn.be"));
                          },
                          child: Text(
                            "www.brooklyn.be",
                            style: TextStyle(
                              fontSize: 17.01,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              color: TextStyles.brooklyn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse("http://www.brooklyn.be"));
                          },
                          child: SvgIcon(
                            JobrIcons.web,
                            size: 12.72,
                            leaveUnaltered: true,
                            color: TextStyles.brooklyn,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgIcon(
                          JobrIcons.location,
                          size: 16,
                          leaveUnaltered: true,
                          color: theme.primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Kortrijk",
                          style: TextStyle(
                            fontSize: 15.36,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: TextStyles.selectedText,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SvgIcon(
                          JobrIcons.dot,
                          size: 5.43,
                          leaveUnaltered: true,
                          color: TextStyles.selectedText,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "2-10 werknemers",
                          style: TextStyle(
                            fontSize: 15.36,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: TextStyles.selectedText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        SvgIcon(
                          JobrIcons.instagram,
                          size: 27.86,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 16),
                        SvgIcon(
                          JobrIcons.tiktok,
                          size: 27.86,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 16),
                        SvgIcon(
                          JobrIcons.facebook,
                          size: 27.86,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Multibrandstore & Webshop. Brooklyn, da's een mix van merken en heel veel broeken. Dat laatste nemen we als broekspeciaalzaak wel heel serieus. Kom zeker eens langs om het zelf te zeggen.",
                      style: TextStyle(
                        fontSize: 15.28,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: TextStyles.disabledText,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: TextStyles.darkGray,
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Gemiddelde reactietijd ",
                            style: TextStyle(
                                fontSize: 15.2,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Row(
                            children: [
                              SvgIcon(
                                JobrIcons.message1,
                                size: 16,
                                color: TextStyles.green,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "12 uur",
                                style: TextStyle(
                                  color: TextStyles.green,
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        toggleNavBarVisibility(false);
                        showLocationSelector(context).then((_) {
                          toggleNavBarVisibility(true);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: TextStyles.darkGray,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Wisselen van vestiging",
                              style: TextStyle(
                                  fontSize: 15.2,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Row(
                              children: [
                                SvgIcon(
                                  JobrIcons.venueLocation,
                                  size: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 280,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 16),
                            width: 290,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/images/bg_image.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          ...List.generate(
                            5,
                            (index) => Container(
                              margin: const EdgeInsets.only(right: 16),
                              width: 300,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/images/bg_image.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 200,
                      margin: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: GoogleMap(
                          onMapCreated: (controller) {
                            _mapController = controller;
                          },
                          initialCameraPosition: CameraPosition(
                            target: _currentLocation,
                            zoom: 14.0,
                          ),
                          markers: _markers,
                          zoomControlsEnabled: false,
                          mapToolbarEnabled: false,
                          myLocationButtonEnabled: false,
                          gestureRecognizers: <Factory<
                              OneSequenceGestureRecognizer>>{
                            Factory<EagerGestureRecognizer>(
                                () => EagerGestureRecognizer()),
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : _buildEmptyState(context),
        ));
  }

  void toggleNavBarVisibility(bool isVisible) {
    final baseNavBarState =
        context.findAncestorStateOfType<BaseNavBarScreenState>();
    baseNavBarState?.toggleNavBarVisibility(isVisible);
  }

  Future<void> showLocationSelector(BuildContext context) async {
    // Hide the navigation bar
    toggleNavBarVisibility(false);

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.70,
          minChildSize: 0.25,
          maxChildSize: 0.75,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Drag handle at the top
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Location 1
                    _buildLocationTile(
                      context,
                      title: "Brooklyn",
                      subtitle: "Brugge, Leistraat",
                      onPressed: () {
                        Navigator.pop(context);
                        // Handle selection logic for "Brooklyn Brugge"
                      },
                    ),
                    const SizedBox(height: 12),
                    // Location 2
                    _buildLocationTile(
                      context,
                      title: "Brooklyn",
                      subtitle: "Gent, Voorstraat",
                      onPressed: () {
                        Navigator.pop(context);
                        // Handle selection logic for "Brooklyn Gent"
                      },
                    ),
                    const SizedBox(height: 12),
                    // Location 3
                    _buildLocationTile(
                      context,
                      title: "Brooklyn",
                      subtitle: "Mechelen, Bruul",
                      onPressed: () {
                        Navigator.pop(context);
                        // Handle selection logic for "Brooklyn Mechelen"
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    // Show the navigation bar again
    toggleNavBarVisibility(true);
  }

  Widget _buildLocationTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Leading icon
          CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 24,
              child: ClipRect(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    image: const DecorationImage(
                      image: AssetImage(
                          'assets/images/logos/brooklyn_kortrijk.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )),
          const SizedBox(width: 16),
          // Title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SvgIcon(
                      JobrIcons.location,
                      size: 16,
                      leaveUnaltered: true,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // "Kies" button
          TextButton(
            onPressed: onPressed,
            child: Text(
              "Kies",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.info_outline,
              size: 48,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "NVT",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Geen gegevens beschikbaar",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.push(EditCompanyProfileScreen.route);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            icon: SvgPicture.asset(
              JobrIcons.edit,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                TextStyles.clearText,
                BlendMode.srcIn,
              ),
            ),
            label: Text(
              "Profiel aanvullen",
              style: TextStyle(
                color: TextStyles.clearText,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          // For testing purposes only - remove in production
          const SizedBox(height: 16),
          TextButton(
            onPressed: toggleEmptyState,
            child: Text(
              "Toggle View",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ZoomImageDialog extends StatelessWidget {
  final String tag;
  final String imagePath;
  final double? height;

  final double? width;
  const ZoomImageDialog(
      {super.key,
      required this.tag,
      required this.imagePath,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Material(
        color: Colors.black54,
        child: Center(
          child: Hero(
            tag: tag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: (height != null)
                  ? Image.asset(imagePath,
                      height: height ?? 200,
                      width: width ?? MediaQuery.of(context).size.width * 0.85,
                      fit: BoxFit.cover)
                  : Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}
