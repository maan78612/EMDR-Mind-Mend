
part of 'package:emdr_mindmend/src/features/help_faqs/presentation/views/help_faqs_library.dart';
class _FaqTile extends ConsumerStatefulWidget {
  final FaqItem faqItem;

  const _FaqTile({super.key, required this.faqItem});

  @override
  ConsumerState<_FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends ConsumerState<_FaqTile>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorMode = ref.watch(colorModeProvider);
    return GestureDetector(
      onTap: _toggleExpand,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 16.h),
        color: AppColorHelper.cardColor(colorMode),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.faqItem.question,
                      style: PoppinsStyles.medium(
                              color:
                                  AppColorHelper.getPrimaryTextColor(colorMode))
                          .copyWith(fontSize: 16.sp),
                    ),
                  ),
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              SizeTransition(
                sizeFactor: _expandAnimation,
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Text(
                    widget.faqItem.answer,
                    style: PoppinsStyles.regular(
                            color:
                                AppColorHelper.getSecondaryTextColor(colorMode))
                        .copyWith(fontSize: 14.sp, height: 1.2.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
