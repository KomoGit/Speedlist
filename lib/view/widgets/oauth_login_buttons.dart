import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

import '../../debug/debug_out.dart';

//oAuthWidget needs to be added.
class OAuthButton extends StatelessWidget {
  final String iconAsset;
  //final Widget oAuthWidget;
  const OAuthButton(
      {/*required this.oAuthWidget,*/ required this.iconAsset, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 64,
        child: BlurryContainer.square(
            blur: 5,
            child: GestureDetector(
                onTap: () => DebugOut.printLog("Google Login"),
                child: Image.asset(iconAsset))));
  }
}
