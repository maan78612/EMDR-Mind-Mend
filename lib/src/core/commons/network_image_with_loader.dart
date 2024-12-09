import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetworkImageWithLoader extends StatelessWidget {
  final String imageUrl;
  final double size;

  const NetworkImageWithLoader(
      {super.key, required this.imageUrl, required this.size});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1000.sp),
      child: Container(
        width: size,
        height: size,
        color: AppColors.lightGreyColor,
        child: _buildProfileImage(imageUrl),
      ),
    );
  }

  Widget _buildProfileImage(String networkImage) {
    return Image.network(
      networkImage,
      fit: BoxFit.contain,
      width: size,
      height: size,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child; // Image loaded

        final progress = (loadingProgress.cumulativeBytesLoaded /
                (loadingProgress.expectedTotalBytes ?? 1))
            .clamp(0.1, 1.0); // Clamp to prevent overflow

        debugPrint("progress = $progress");
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size,
              height: size,
              color: AppColors.lightGreyColor, // Placeholder background
            ),
            SizedBox(
              width: size + 30,
              height: size + 30,
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                value: progress,
                strokeWidth: 4.0,
              ),
            ),
            Center(
              child: Text(
                "Loading...",
                style: PoppinsStyles.semiBold(color: AppColors.primaryColor)
                    .copyWith(fontSize: size / 10),
              ),
            ),
          ],
        );
      },
      errorBuilder: (context, error, stackTrace) {
        // Handle error gracefully, return placeholder
        return _placeholderImage();
      },
    );
  }

  Widget _placeholderImage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "No image found!",
          textAlign: TextAlign.center,
          style: PoppinsStyles.semiBold(color: AppColors.primaryColor)
              .copyWith(fontSize: size / 10),
        ),
      ),
    );
  }
}
