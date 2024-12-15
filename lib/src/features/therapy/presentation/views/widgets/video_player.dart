import 'package:chewie/chewie.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/viewmodels/therapy_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomVideoPlayer extends ConsumerWidget {
  final ChangeNotifierProvider<TherapyViewModel> therapyViewModelProvider;

  const CustomVideoPlayer({super.key, required this.therapyViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final therapyViewModel = ref.watch(therapyViewModelProvider);

    return Center(
      child: therapyViewModel.chewieController?.videoPlayerController.value
                  .isInitialized ??
              false
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Chewie(controller: therapyViewModel.chewieController!),
            )
          : const CircularProgressIndicator(color: Colors.white),
    );
  }
}
