import 'package:emdr_mindmend/src/features/drawer/presentation/views/help_faq_screen/widgets/faq_item.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/help_faq_screen/widgets/faq_tile.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/widgets/drawer_widgets_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';

class HelpFaqPage extends StatelessWidget {
  final List<FaqItem> faqItems = [
    FaqItem(
      question: "How do I reset my password?",
      answer:
          "To reset your password, go to the forget password on login screen, then 'Enter email and submit Reset will be on your provided email ",
    ),
    FaqItem(
      question: "How do I contact support?",
      answer:
          "You can contact support by navigating to the 'Contact Us' page and filling out the form. Our support team will get back to you within 24 hours.",
    ),
    FaqItem(
      question: "How do I update my profile information?",
      answer:
          "To update your profile information, go to your profile page and select 'Edit Profile'. Make the necessary changes and save.",
    ),
    FaqItem(
      question: "How do I change my email address?",
      answer:
          "To change your email address, go to the settings page, select 'Account', and then 'Change Email'. Follow the instructions provided.",
    ),
  ];

  HelpFaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const DrawerAppBar(title: "Help & FAQ"),
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
