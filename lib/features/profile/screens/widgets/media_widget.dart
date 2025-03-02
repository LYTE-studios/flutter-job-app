import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:video_thumbnail/video_thumbnail.dart' show VideoThumbnail, ImageFormat;
import 'package:path_provider/path_provider.dart';

class MediaWidget extends StatefulWidget {
  final String? image;
  const MediaWidget({
    super.key,
    this.image,
  });

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  String? _imagePath;
  bool _isVideo = false;
  XFile? _videoFile;
  String? _videoThumbnailPath;

  @override
  void initState() {
    super.initState();
    _imagePath = widget.image;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        _isVideo = false;
        _videoFile = null;
        _videoThumbnailPath = null;
      });
    }
  }

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = pickedFile;
        _isVideo = true;
        _imagePath = null;
      });
      // Generate thumbnail
      await _generateVideoThumbnail(pickedFile.path);
    }
  }

  Future<void> _generateVideoThumbnail(String videoPath) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: tempDir.path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 200,
        quality: 75,
      );

      if (thumbnailPath != null) {
        setState(() {
          _videoThumbnailPath = thumbnailPath;
        });
      }
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
    }
  }

  Future<void> _showMediaPicker() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(26),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Select Media',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Choose the type of media you want to add',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _mediaOptionButton(
                      icon: Icons.image_rounded,
                      label: 'Image',
                      description: 'JPG, PNG, etc.',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage();
                      },
                    ),
                    _mediaOptionButton(
                      icon: Icons.videocam_rounded,
                      label: 'Video',
                      description: 'MP4, MOV, etc.',
                      onTap: () {
                        Navigator.pop(context);
                        _pickVideo();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  Widget _mediaOptionButton({
    required IconData icon,
    required String label,
    required String description,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withAlpha(26),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).primaryColor.withAlpha(51),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withAlpha(51),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double width = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: _showMediaPicker,
      child: Container(
        height: 200,
        width: width * .43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: _imagePath == null && _videoFile == null
              ? theme.colorScheme.primaryContainer
              : null,
          image: _imagePath != null
              ? DecorationImage(
                  image: _imagePath!.startsWith('assets/')
                      ? AssetImage(_imagePath!)
                      : FileImage(File(_imagePath!)) as ImageProvider,
                  fit: BoxFit.cover,
                )
              : _videoThumbnailPath != null
                  ? DecorationImage(
                      image: FileImage(File(_videoThumbnailPath!)),
                      fit: BoxFit.cover,
                    )
                  : null,
        ),
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(10),
        alignment: _imagePath == null &&
                _videoFile == null &&
                _videoThumbnailPath == null
            ? Alignment.center
            : Alignment.topRight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Video placeholder (only shown if no thumbnail is available)
            if (_isVideo && _videoFile != null && _videoThumbnailPath == null)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: Colors.black.withAlpha(26),
                  child: Center(
                    child: Icon(
                      Icons.video_file,
                      size: 50,
                      color: theme.primaryColor.withAlpha(179),
                    ),
                  ),
                ),
              ),

            // Play button for video
            if (_isVideo && _videoFile != null)
              Positioned.fill(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withAlpha(128),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(51),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(15),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),

            // Add icon when no media
            if (_imagePath == null && _videoFile == null)
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFC4C4C4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(26),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    JobrIcons.addIcon,
                    width: 30,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),

            // Close button
            if (_imagePath != null || _videoFile != null)
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _imagePath = null;
                      _videoFile = null;
                      _isVideo = false;
                      _videoThumbnailPath = null;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(51),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(9),
                    child: SvgPicture.asset(
                      JobrIcons.close,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      width: 11,
                      height: 11,
                    ),
                  ),
                ),
              ),

            // Video duration indicator
            if (_isVideo && _videoFile != null)
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(153),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withAlpha(77),
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.videocam_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          _videoFile!.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
