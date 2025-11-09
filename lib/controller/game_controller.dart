import 'package:flip_card/flip_card_controller.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GameController extends GetxController {
  List<String> gameImages = [];
  List<int> selectedCards = [];
  List<bool> cardsMatched = [];
  List<FlipCardController> cardControllers = [];
  bool ischeckingMatch = false;
  List<bool> isFront = [];

  void shuffleImages() {
    final List<String> images = [
      "assests/images/ace.jpg",
      "assests/images/Asta.jpeg",
      "assests/images/mo.jpeg",
      "assests/images/cute.jpeg",
      "assests/images/ip.jpeg",
      "assests/images/sword.jpeg",
      "assests/images/tom.jpeg",
      "assests/images/logo.jpg",
      "assests/images/peppa.jpeg",
      "assests/images/pick.jpeg",
    ];

    images.shuffle();
    int pairs = 10;
    final List<String> selectedImages = images.take(pairs).toList();
    gameImages = (selectedImages + selectedImages)..shuffle();

    cardsMatched = List<bool>.filled(gameImages.length, false);
    cardControllers =
        List.generate(gameImages.length, (_) => FlipCardController());
    isFront = List<bool>.filled(gameImages.length, true);

    update();
  }

  void Cards(int index) {
    if (selectedCards.length < 2 && !ischeckingMatch) {
      selectedCards.add(index);
      cardControllers[index].toggleCard();
      isFront[index] = false;
      update();

      if (selectedCards.length == 2) {
        ischeckingMatch = true;
        matchcheck();
      }
    }
  }

  void matchcheck() {
    if (gameImages[selectedCards[0]] == gameImages[selectedCards[1]]) {
      cardsMatched[selectedCards[0]] = true;
      cardsMatched[selectedCards[1]] = true;
      selectedCards.clear();
      ischeckingMatch = false;
      update();
    } else {
      Future.delayed(Duration(milliseconds: 800), () {
        for (int index in selectedCards) {
          cardControllers[index].toggleCard(); // flip back
          isFront[index] = true;
        }
        selectedCards.clear();
        ischeckingMatch = false;
        update();
      });
    }
  }

  void resetGame() {
    selectedCards.clear();
    ischeckingMatch = false;

    for (int i = 0; i < cardControllers.length; i++) {
      if (!isFront[i]) {
        cardControllers[i].toggleCard();
        isFront[i] = true;
      }
    }

    shuffleImages();
    update();
  }
}
