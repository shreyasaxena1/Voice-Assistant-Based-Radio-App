import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:radio_app/components/ai_colors.dart';
import 'package:flutter/material.dart';
import 'package:radio_app/model/radio.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyRadio> radios;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRadio();
  }

  fetchRadio() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    print(radios);
    setState(() {});
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
            title: "Radiofy".text.xl4.bold.white.make().shimmer(),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
          ).h(100.0).p16(),
          VxSwiper.builder(
              itemCount: radios.length,
              aspectRatio: 1.0,
              enlargeCenterPage: true,
              itemBuilder: (context, index) {
                final rad = radios[index];

                return VxBox(child: ZStack([]))
                    .bgImage(DecorationImage(
                        image: NetworkImage(rad.image),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.darken)))
                    .border(color: Colors.black, width: 4.0)
                    .withRounded(value: 60.0)
                    .make()
                    .p16()
                    .centered();
              })
        ],
        fit: StackFit.expand,
      ),
    );
  }
}
