import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:emdr_mindmend/src/features/on_boarding/domain/models/on_boarding.dart';
import 'package:emdr_mindmend/src/features/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:emdr_mindmend/src/features/therapy/domain/repositories/therapy_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TherapyRepositoryImpl implements TherapyRepository {
  @override
  List<OnBoardingModel> populateData() {
    List<OnBoardingModel> onBoarding = [
      OnBoardingModel(
          title: 'Welcome to',
          description:
              'Your companion for managing anxiety, depression, and PTSD through EMDR therapy. Let\'s take a quick tour to help you get started.',
          img: AppImages.onBoarding1,
          imgHeight: 263.h),
      OnBoardingModel(
          title: 'What is EMDR?',
          description:
              'Old, upsetting memories can sometimes get stuck in our brains, locked away with the original images, sounds, thoughts, and feelings. These memories can keep getting triggered repeatedly, preventing us from learning and healing. Meanwhile, another part of our brain holds most of the information we need to resolve these issues, but the two parts can\'t connect. That\'s where EMDR (Eye Movement Desensitization and Reprocessing) comes in. Once EMDR begins, it helps to link these parts of the brain. New information can emerge, allowing you to resolve old problems. This process is similar to what might happen naturally during REM sleep or dreams, where eye movements help process unconscious material.',
          img: AppImages.logo,
          imgHeight: 110.h),
      OnBoardingModel(
          title: 'How EMDR Helps',
          description:
              'EMDR helps by:\n• Reducing the emotional intensity of traumatic memories.\n• Enhancing emotional regulation.\n• Improving overall mental health and resilience.\n• Experience relief from anxiety, depression, and PTSD symptoms with regular sessions.',
          img: AppImages.onBoarding2,
          imgHeight: 272.h),
      OnBoardingModel(
          title: 'The science behind it',
          description:
              'The purpose of bilateral stimulation in EMDR is to activate both hemispheres of the brain, facilitating the processing and integration of distressing memories. This process is believed to help desensitise the emotional impact of the trauma and reprocess the memory in a more adaptive way, reducing the symptoms associated with post-traumatic stress disorder (PTSD) and other trauma-related conditions.',
          img: AppImages.onBoarding3,
          imgHeight: 280.h),
      OnBoardingModel(
          title: 'Personalised Sessions',
          description:
              'Our app tailors each session to your needs. Select the focus of your session (e.g. anxiety, specific traumatic events), adjust session length based on your schedule. Receive personalised tips and exercises. We would recommend that you do a guided session before using the app',
          img: AppImages.onBoarding4,
          imgHeight: 276.h),
      OnBoardingModel(
          title: 'Get Started Today',
          description:
              'You’re ready to begin your journey towards better mental health. Start your first session now and take the first step towards healing and recovery. ',
          img: AppImages.onBoarding5,
          imgHeight: 280.h),
    ];
    return onBoarding;
  }
}
