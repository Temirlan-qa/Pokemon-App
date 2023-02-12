import 'package:flutter/material.dart';
import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:pokemon_app/presentation/onboarding/widgets/build_dot_widget.dart';
import 'package:pokemon_app/presentation/onboarding/widgets/transformer_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    indexController = IndexController();
    _duration = const Duration(milliseconds: 600);
    super.initState();
  }

  IndexController? indexController;
  Duration? _duration;
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    List<Map<String, dynamic>> splashData = [
      {
        "text": 'Todos os Pokémons em\n um só Lugar',
        'subtext':
            'Acesse uma vasta lista de Pokémon de\n todas as gerações já feitas pela Nintendo',
        "image": "assets/img/onboarding_1.png",
        "btn_text" : "Continuar"
      },
      {
        "text": 'Mantenha sua\n Pokédex atualizada',
        'subtext':
            'Cadastre-se e mantenha seu perfil,\n pokémon favoritos, configurações e muito\n mais, salvos no aplicativo, mesmo sem\n conexão com a internet.',
        "image": "assets/img/onboarding_2.png",
        "btn_text" : "Vamos começar!"
      },
      {
        "text": 'Está pronto para essa\n aventura?',
        "image": "assets/img/onboarding_3.png",
        'subtext':
            'Basta criar uma conta e começar a explorar\n o mundo dos Pokémon hoje!',
        "btn_text" : "Criar conta"
      },
    ];
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              TransformerPageView(
                duration: _duration!,
                controller: indexController!,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value!;
                  });
                },
                transformer: CustomTransformer(),
                itemCount: splashData.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight / 2,
                              child: Image.asset(
                                splashData[index]['image'],
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              Positioned(
                bottom: 0,
                child: Column(
                  children: <Widget>[
                    IgnorePointer(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            splashData[currentPage]['text'],
                            style: const TextStyle(
                              fontSize: 26,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    IgnorePointer(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width-18,
                        child: Text(
                          splashData[currentPage]['subtext'],
                          style: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            color: Color(0xFF666666),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: 2 > currentPage,
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 12,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                splashData.length-1,
                                (index) => buildDot(index: index, currentPage:currentPage),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 32,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          if (currentPage == 0) {
                            setState(() {
                              indexController?.move(1);
                            });
                          } else if (currentPage == 1) {
                            setState(() {
                              indexController?.move(2);
                            });
                          } else if (currentPage == 2) {
                            setState(
                              () {
                                //indexController?.move(3);
                              },
                            );
                          } else {
                            //onBoarding.put('show', true);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) => const VerifyScreen(),
                            //     ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(343, 48),
                          backgroundColor: const Color(0xFF173EA5),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(50), // <-- Radius
                          ),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return FadeTransition(
                              opacity: animation.drive(
                                Tween<double>(begin: 0.0, end: 1.0).chain(
                                  CurveTween(
                                    curve: const Interval(0.0, 0.5,
                                        curve: Curves.easeIn),
                                  ),
                                ),
                              ),
                              child: FadeTransition(
                                opacity: animation.drive(
                                  Tween<double>(begin: 0.0, end: 1.0).chain(
                                    CurveTween(
                                      curve: const Interval(0.5, 1.0,
                                          curve: Curves.easeIn),
                                    ),
                                  ),
                                ),
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            currentPage == 0 ? splashData[0]['btn_text']: currentPage == 1 ? splashData[1]['btn_text'] : splashData[2]['btn_text'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: currentPage ==2,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(16.0),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {},
                          child: const Text(
                              'Ja tenho uma conta',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              color: Color(0xFF173EA5)
                            ),
                          ),
                        ),
                    ),
                    const SafeArea(
                      bottom: false,
                      top: false,
                      child: SizedBox(
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: currentPage == 2,
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    child: const Text(
                      'Pular >',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      //onBoarding.put('show', true);
                      // Navigator.push(
                      //   context,
                      //
                      //   MaterialPageRoute(builder: (context) => const VerifyScreen(),),
                      // );
                    },
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
