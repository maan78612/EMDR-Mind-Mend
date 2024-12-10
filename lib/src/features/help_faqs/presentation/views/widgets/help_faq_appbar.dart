part of 'package:emdr_mindmend/src/features/help_faqs/presentation/views/help_faqs_library.dart';



class _HelpFaqAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final Color? bgColor;
  final void Function()? onBack;
  final bool isBackButton;

  const _HelpFaqAppBar(
      {super.key,
      required this.title,
      this.bgColor,
      this.onBack,
      this.isBackButton = true})
      : preferredSize = const Size.fromHeight(kToolbarHeight + 10.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorMode = ref.watch(colorModeProvider);
    return AppBar(
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: bgColor ?? AppColorHelper.getScaffoldColor(colorMode),
      leading: isBackButton
          ? CommonInkWell(
              onTap: onBack ??
                  () {
                    CustomNavigation().pop();
                  },
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColorHelper.getIconColor(colorMode),
              ),
            )
          : null,
      title: Text(
        title,
        style: PoppinsStyles.medium(
                color: AppColorHelper.getPrimaryTextColor(colorMode))
            .copyWith(fontSize: 18.sp),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Divider(color: AppColorHelper.dividerColor(colorMode)),
      ),
    );
  }
}
