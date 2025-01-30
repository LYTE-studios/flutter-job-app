import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:jobr/secrets.dart';
import 'dart:convert';

import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';

class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({super.key});
  static const String route = '/edit-location-profile';

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  GoogleMapController? _mapController;
  LatLng _currentLatLng = const LatLng(51.9225, 4.47917);
  final TextEditingController _searchController = TextEditingController();
  final String _googleApiKey = googleApiKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kies Locatie",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: Center(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(
              JobrIcons.backArrow,
              width: 21,
              height: 21,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, _searchController.text);
            },
            child: const Text('OK'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TypeAheadField<String>(
              suggestionsCallback: (pattern) async {
                return await _fetchAutocompleteSuggestions(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  leading: SvgIcon(
                    JobrIcons.location,
                    size: 21,
                    color: HexColor.fromHex('#FF3E68'),
                  ),
                  title: Text(
                    suggestion,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: TextStyles.labelSmall.fontSize,
                      fontWeight: TextStyles.labelSmall.fontWeight,
                      color: TextStyles.labelSmall.color,
                    ),
                  ),
                );
              },
              onSelected: (String suggestion) async {
                _searchController.text = suggestion;
                await _moveToLocation(suggestion);
              },
              builder: (context, controller, focusNode) {
                _searchController.addListener(() {
                  if (_searchController.text != controller.text) {
                    controller.text = _searchController.text;
                  }
                });
                return Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: HexColor.fromHex('#D9D9D9').withAlpha(51), // Updated
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      cursorHeight: 20,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: TextStyles.labelSmall.fontSize,
                        fontWeight: TextStyles.labelSmall.fontWeight,
                        color: TextStyles.labelSmall.color,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Zoek een locatie',
                        hintStyle: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: TextStyles.labelSmall.fontSize,
                          fontWeight: TextStyles.labelSmall.fontWeight,
                          color: TextStyles.labelSmall.color,
                        ).copyWith(
                          color: HexColor.fromHex('#000000')
                              .withAlpha(84), // Updated
                        ),
                        border: InputBorder.none,
                        prefixIcon: Container(
                          width: 40,
                          height: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: SvgIcon(
                              JobrIcons.location,
                              size: 21,
                              color: HexColor.fromHex('#FF3E68'),
                            ),
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onChanged: (text) {
                        _searchController.text = text;
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GoogleMap(
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: _currentLatLng,
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("currentLocation"),
                      position: _currentLatLng,
                    ),
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<String>> _fetchAutocompleteSuggestions(String input) async {
    final Uri uri = Uri.https(
      "maps.googleapis.com",
      "/maps/api/place/autocomplete/json",
      {
        "input": input,
        "key": _googleApiKey,
      },
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        return (data['predictions'] as List)
            .map((prediction) => prediction['description'] as String)
            .toList();
      }
    }
    return [];
  }

  Future<void> _moveToLocation(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        final newLatLng =
            LatLng(locations.first.latitude, locations.first.longitude);

        if (mounted) {
          setState(() {
            _currentLatLng = newLatLng;
          });

          _mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: newLatLng, zoom: 14.0),
            ),
          );
        }
      }
    } catch (e) {
      // Handle errors, such as invalid address or no results
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kan locatie niet vinden: $address')),
        );
      }
    }
  }
}
