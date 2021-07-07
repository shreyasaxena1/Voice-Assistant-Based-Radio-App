import 'package:audioplayers/audioplayers.dart';
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
  MyRadio _selectedRadio;
  Color _selectedColor;
  bool _isPlaying = false;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRadio();
    _audioPlayer.onPlayerStateChanged.listen((event) {
    });
  }

  fetchRadio() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    print(radios);
    setState(() {});
  }

  _playMusic(String url) {
    _audioPlayer.play(url);
    _selectedRadio = radios.firstWhere((element) => element.url == url);
    print(_selectedRadio.name);
    //refresh UI
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

                return VxBox(
                        child: ZStack(
                  [
                    Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: VxBox(
                          child: rad.category.text.white.make().px16(),
                        )
                            .height(40)
                            .black
                            .alignCenter
                            .withRounded(value: 6)
                            .make()),
                    Align(
                      //for radio name
                      alignment: Alignment.bottomCenter,
                      child: VStack(
                        [
                          rad.name.text.xl3.white.bold.make(),
                          5.heightBox,
                          rad.tagline.text.sm.white.semiBold.make(),
                        ],
                        crossAlignment: CrossAxisAlignment.center,
                      ),
                    ),
                    Align(
                      child: VStack(
                        [
                          Icon(
                            CupertinoIcons.play_circle,
                            color: Colors.white,
                          ),
                          5.heightBox,
                          "Double Tap to play".text.gray300.make(),
                        ],
                        crossAlignment: CrossAxisAlignment.center,
                      ),
                    ),
                  ],
                ))
                    .clip(Clip.antiAlias)
                    .bgImage(DecorationImage(
                        image: NetworkImage(rad.image),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.darken)))
                    .border(color: Colors.black, width: 4.0)
                    .withRounded(value: 60.0)
                    .make()
                    .onInkDoubleTap(() {})
                    .p16();
              }).centered(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Icon(
              CupertinoIcons.stop_circle,
              color: Colors.white,
              size: 50.0,
            ),
          ).pOnly(bottom: context.percentHeight * 12)
        ],
        fit: StackFit.expand,
      ),
    );
  }
}
