import 'package:radio_app/components/ai_colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Stack(
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(LinearGradient(
                  colors: [AIcolors.primaryColor1, AIcolors.primaryColor2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight))
              .make(),
             AppBar(
               title: "Radiofy".text.xl4.bold.white.make().shimmer(

               ),
               backgroundColor: Colors.transparent,
               elevation: 0.0,
               centerTitle: true ,

             ).h(100.0).p16()
        ],
      ),
    );
  }
}
