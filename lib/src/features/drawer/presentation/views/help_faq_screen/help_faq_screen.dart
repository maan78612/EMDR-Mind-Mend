import 'package:emdr_mindmend/src/features/drawer/presentation/views/help_faq_screen/widgets/faq_item.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/help_faq_screen/widgets/faq_tile.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/widgets/drawer_widgets_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';

class HelpFaqPage extends StatelessWidget {
  final List<FaqItem> faqItems = [
    FaqItem(
      question: "What is EMDR therapy and how does it work",
      answer:
          "EMDR (Eye Movement Desensitisation and Reprocessing) is a psychotherapy treatment designed to alleviate distress associated with traumatic memories. It involves using bilateral stimulation, such as eye movements, sounds, or taps, to help the brain process and integrate these memories more effectively.",
    ),
    FaqItem(
      question: "How does this app assist with EMDR therapy?",
      answer:
          "Our app provides visual and auditory stimuli that mimic the bilateral stimulation used in EMDR therapy. This allows users to engage in EMDR techniques at home or on-the-go, under the guidance of their therapist.",
    ),
    FaqItem(
      question: "Can this app replace my therapy sessions?",
      answer:
          "No, the app is not a replacement for professional therapy. It is a supplementary tool designed to support your therapy sessions. Always use the app under the supervision of a licensed EMDR therapist.",
    ),
    FaqItem(
        question: "Is this app suitable for everyone?",
        answer:
            "The app is intended for individuals undergoing EMDR therapy or those who have been recommended it by a licensed therapist. It is not suitable for individuals who have not been assessed by a professional for EMDR therapy."),
    FaqItem(
        question: "How do I use the app for EMDR therapy?",
        answer:
            "The app guides you through sessions of visual and auditory stimuli. Follow the instructions provided by the app and your therapist. Make sure to find a quiet and comfortable space for your sessions."),
    FaqItem(
        question:
            "What should I do if I feel distressed or overwhelmed during a session?",
        answer:
            "If you feel distressed, stop the session immediately and use the grounding techniques recommended by your therapist. Contact your therapist for further guidance."),
    FaqItem(
        question: "Can I customise the visual and auditory stimuli in the app?",
        answer:
            "Yes, the app allows you to customise the type, speed, and intensity of the visual and auditory stimuli to best suit your needs and preferences, as recommended by your therapist."),
    FaqItem(
        question: "Is my data secure on this app?",
        answer:
            "Yes, your data is encrypted and stored securely. We adhere to strict privacy policies to ensure your personal information and session data are protected."),
    FaqItem(
        question: "Can I use the app without an internet connection?",
        answer:
            "Yes, once you have downloaded the necessary resources, you can use the app offline. This allows you to conduct sessions even without an internet connection."),
    FaqItem(
        question: "How often should I use the app for optimal results?",
        answer:
            "The frequency of use should be determined by your therapist. Typically, sessions are conducted once or twice a week, but your therapist will provide specific recommendations based on your individual needs."),
  ];

  HelpFaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const DrawerAppBar(title: "Help & FAQs"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: ListView.builder(
          itemCount: faqItems.length,
          itemBuilder: (context, index) {
            return FaqTile(faqItem: faqItems[index]);
          },
        ),
      ),
    );
  }
}
