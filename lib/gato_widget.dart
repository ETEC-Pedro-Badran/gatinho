import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class GatoWidget extends StatelessWidget {
  const GatoWidget({super.key});

  @override
  Widget build(BuildContext context) {

    double deslocamento = 0;
    double ciclos = 0;
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Gato'),
        ),
        body:  Center(
          child: StatefulBuilder(builder: (context, setState) => 
           GestureDetector(
            onTap: ()  {
                
                setState((){
                   deslocamento = 5;
                   ciclos = 0;
                });
                AssetsAudioPlayer.newPlayer().open(
                    Audio("sons/miau.mp3"),
                    autoStart: true,
                    showNotification: false,);
            },
            
            child: Stack(children:[
              Container(
                height: 400,
                width: 400,
              ),
              AnimatedPositioned(
                left: deslocamento,
                duration: Duration(milliseconds: 10),
                curve: Curves.linear,
                child: gatoFade(), onEnd: () {
                  if (ciclos<10 && deslocamento!=0) {
                    setState((){
                     deslocamento = deslocamento*-1;
                     ciclos++;
                    });
                  } else {
                    setState((){
                       deslocamento = 0;
                       ciclos = 0;
                    });
                    
                  }}
                ,)]),
        ),
      )));
  }


  gatoFade(){
    return  FutureBuilder(
              future: Future.delayed(Duration(seconds: 1), () => 1.0),
              initialData: 0.0,
              builder: (context, snashot) {
                double fator = snashot.data!;
                return /*AnimatedOpacity(
                  duration: Duration(seconds: 2),
                  opacity: snashot.data!,
                  curve: Curves.ease,
                  child: Image.asset("imagens/gato.jpg"));*/
                  AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  width: 400*fator,
                  height: 400*fator,
                  curve: Curves.easeInOut,
                  child: Image.asset("imagens/gato.jpg"));
              }
            );
  }
}