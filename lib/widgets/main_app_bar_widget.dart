import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/app_theme.dart';
import 'package:pcare/constants/dimensions.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget leading;
  final bool isColor;
  final String title;
  final List<Widget> actions;
  final String animatedTitle;
  // final Widget childWidget;

  MainAppBarWidget({
    this.leading,
    this.isColor = true,
    this.title,
    this.actions,
    this.animatedTitle,
  });

  @override
  Widget build(BuildContext context) {
    double appBarHeight = Scaffold.of(context).appBarMaxHeight;

    return Material(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          // alignment: Alignment.topLeft,
          // constraints: BoxConstraints.expand(),
          // margin: EdgeInsets.only(top: 20, bottom: 20),
          padding: EdgeInsets.only(top: Dimensions.appbarTopPadding),
          height: 80,
          // alignment: Alignment.centerLeft,
          decoration: isColor
              ? BoxDecoration(gradient: UniversalColors.primaryGradient)
              : BoxDecoration(color: Colors.transparent),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    leading != null
                        ? Container(
                            margin: EdgeInsets.only(
                                left: Dimensions.appbarLeftMargin,
                                right: Dimensions.appbarRightMargin),
                            alignment: Alignment.centerLeft,
                            child: leading != null ? leading : null,
                          )
                        : Container(),
                    animatedTitle != null
                        ? Expanded(
                            child: AnimatedContainer(
                              duration: Duration(seconds: 3),
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 18),
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 800),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return SlideTransition(
                                    child: child,
                                    position: Tween<Offset>(
                                            begin: Offset(0.0, -1.5),
                                            end: Offset(0.0, 0.0))
                                        .animate(animation),
                                  );
                                },
                                child: Text(
                                  animatedTitle != null ? animatedTitle : '',
                                  key: ValueKey<String>(animatedTitle),
                                  style: appTheme.textTheme.headline1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: AnimatedContainer(
                              duration: Duration(seconds: 2),
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 18),
                              child: Text(
                                title != null ? title : '',
                                style: appTheme.textTheme.headline1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(
                            left: Dimensions.appbarLeftMargin,
                            right: Dimensions.appbarRightMargin),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            actions != null ? actions : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0, 56.0);
}

// class MainAppBarWidget extends StatefulWidget {
//   final Widget leading;
//   final bool isColor;
//   final String title;
//   final List<Widget> actions;
//   final Widget childWidget;

//   MainAppBarWidget(
//       {this.leading,
//       this.isColor = true,
//       this.title,
//       this.actions,
//       this.childWidget});
//   @override
//   _MainAppBarWidgetState createState() => _MainAppBarWidgetState(
//       leading: leading, isColor: isColor, title: title, actions: actions);
// }

// class _MainAppBarWidgetState extends State<MainAppBarWidget> {
//   final Widget leading;
//   final bool isColor;
//   final String title;
//   final List<Widget> actions;

//   _MainAppBarWidgetState(
//       {this.leading, this.isColor, this.title, this.actions});
//   @override
//   Widget build(BuildContext context) {
//     double appBarHeight = kToolbarHeight;

//     return Material(
//       child: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).requestFocus(new FocusNode());
//         },
//         child: Container(
//           // alignment: Alignment.topLeft,
//           // constraints: BoxConstraints.expand(),
//           height: appBarHeight,
//           decoration: isColor
//               ? BoxDecoration(gradient: UniversalColors.primaryGradient)
//               : BoxDecoration(color: Colors.transparent),
//           child: Stack(
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         leading != null
//                             ? Container(
//                                 margin: EdgeInsets.only(
//                                     left: Dimensions.appbarLeftMargin,
//                                     right: Dimensions.appbarRightMargin),
//                                 alignment: Alignment.centerLeft,
//                                 child: leading != null ? leading : null,
//                               )
//                             : Container(),
//                         Expanded(
//                           child: Container(
//                             alignment: Alignment.centerRight,
//                             child: Text(
//                               title != null ? title : '',
//                               style: appTheme.textTheme.headline1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             alignment: Alignment.centerRight,
//                             margin: EdgeInsets.only(
//                                 left: Dimensions.appbarLeftMargin,
//                                 right: Dimensions.appbarRightMargin),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 actions != null ? actions : Container(),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Container(
//                 constraints: BoxConstraints.expand(),
//                 margin: EdgeInsets.only(top: appBarHeight + 50),
//                 child: widget.childWidget != null
//                     ? widget.childWidget
//                     : Container(),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
