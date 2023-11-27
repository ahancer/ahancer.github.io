
//Get EaseMultiplier
import 'dart:math';

int getEaseMultipler (int score){
  var random = Random();
  double minValue = 0.95;
  double maxValue = 1.05;
  double fuzzFactor = minValue + (random.nextDouble() * (maxValue - minValue));

  if (score == 0) {
    return (10);
  } else if (score == 1) {
    return (6*60*fuzzFactor).toInt(); //Adding Fuzz Factor since 1x
  } else if (score == 2) {
    return (1*1440*fuzzFactor).toInt(); //=1 Day
  } else if (score == 3) {
    return (7*1440*fuzzFactor).toInt(); 
  } else if (score == 4) {
    return (16*1440*fuzzFactor).toInt();
  } else if (score == 5) {
    return (35*1440*fuzzFactor).toInt();
  } else {
    return (74*1440*fuzzFactor).toInt(); // In case more than 5x
  }
}

String getEaseText (int score){
  if (score == 0) {
    return ('10m');
  } else if (score == 1) {
    return ('6hr');
  } else if (score == 2) {
    return ('1d'); //=1 Day
  } else if (score == 3) {
    return ('7d'); 
  } else if (score == 4) {
    return ('16d');
  } else if (score == 5) {
    return ('35d');
  } else {
    return ('74d'); // In case more than 5x
  }
}


int getExpCap (int level){
  if (level <= 3){
    return (level*50) - 25;
  } else if (level <=6){
    return (level*75) + 25;
  } else if (level <=9){
    return (level*100) + 75;
  } else if (level <=12){
    return (level*125) + 125;
  } else {
    return (level*150) + 175;
  }
}