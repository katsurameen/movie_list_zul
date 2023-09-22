import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_list_zul/app/data/config/App_colors.dart';
import 'package:movie_list_zul/app/modules/home/views/home_view.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../controllers/first_screen_controller.dart';

class FirstScreenView extends GetView<FirstScreenController> {
  const FirstScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.modalBg,
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 60, 0, 20),
              width: 200, // Set the desired width
              height: 200, // Set the desired height
              child: Image.asset(
                'assets/picture/movielist.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "Welcome to My App!",
                      textStyle: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      speed: const Duration(
                        milliseconds: 200,
                      ),
                    ),
                  ],
                  totalRepeatCount: controller.userInputDetected
                      ? 1
                      : 255, // Play the animation once
                ),
                SizedBox(height: 10),
                Container(
                  width: 200,
                  child: TextFormField(
                    controller: controller.nameController,
                    onChanged: (value) {
                      if (value.length >= 3) {
                        controller.isNameFilled.value = true;
                        controller.userInputDetected = true;
                      } else {
                        controller.isNameFilled.value = false;
                        controller.userInputDetected = false;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Your name',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Obx(
                  () => controller.isNameFilled.value
                      ? SizedBox(
                          width: 200, // Set the desired width
                          child: Material(
                            // Wrap with Material
                            elevation: 8, // Add elevation (shadow)
                            shadowColor: Colors.black, // Set shadow color
                            borderRadius: BorderRadius.circular(16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                String name = controller.nameController.text;
                                Get.to(() => HomeView(), arguments: name)
                                    ?.then((value) {
                                  controller.clearTextField();
                                  controller.isNameFilled.value = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(12),
                              ),
                              child: Text(
                                'EXPLORE',
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                // Background gradient animation wave
                Container(
                  constraints: BoxConstraints.expand(),
                  child: WaveWidget(
                    config: CustomConfig(
                      gradients: [
                        [Colors.blue, Colors.blue],
                        [Colors.blue.shade200, Colors.blue.shade400],
                        [Colors.blue.shade300, Colors.blue.shade500],
                        [Colors.blue.shade400, Colors.blue.shade600],
                      ],
                      durations: [35000, 19440, 10800, 6000],
                      heightPercentages: [0.20, 0.21, 0.23, 0.28],
                      gradientBegin: Alignment.bottomLeft,
                      gradientEnd: Alignment.topRight,
                    ),
                    waveAmplitude: 0,
                    size: Size(
                      double.infinity,
                      double.infinity,
                    ),
                  ),
                ),

                // Centered image overlay on top of the wave with medium size and top margin
              ],
            ),
          ),
        ],
      ),
    );
  }
}
