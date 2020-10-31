import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AnimationRoute<T> extends MaterialPageRoute<T> {
  AnimationRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            builder: builder,
            maintainState: maintainState,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeThroughTransition(
      child: FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      ),
      animation: animation,
      secondaryAnimation: secondaryAnimation,
    );
  }
}
