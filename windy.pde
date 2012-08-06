import processing.serial.*;
import cc.arduino.*;

// objects
Fan newFan;
InterfaceFan interfaceFan;
DistanceSensor distanceSensor;
Record newRecord;
Smoother presenceChecker;
Arduino arduino;

// pins
int[] fanPins = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
int interfacePin = 0;
int distanceSensorPin = 1;
int led1Pin = 46;
int led2Pin = 48;
int led3Pin = 50;
int led4Pin = 52;

// array lists
ArrayList fans;

// drawing sizes
float fanSize = 50;
float interfaceFanSize = 30;
float distanceSensorSize = 30;

// flags
boolean presence;
boolean recording;
boolean playingShow;

// other variables
int mode;
int dir = 1;

// settings
boolean sound = true;
int presenceCheckLength = 500;
int interfaceFanMaxValue = 200;

void setup() {

	// setup stuff
  size(1100, 200);
	frameRate(10);
	smooth();
	noStroke();

	// the arduino object
  arduino = new Arduino(this, Arduino.list()[0], 57600);

	// create interface fan object
	interfaceFan = new InterfaceFan(interfacePin);
	
	// create distance sensor object
	distanceSensor = new DistanceSensor(distanceSensorPin);

	// set interface analog input
	arduino.pinMode(interfacePin, Arduino.INPUT);

	// the fans array list
	fans = new ArrayList();
	
	println("");
	println("***");
	println("ENGINE STARTED");
	println("***");
	println("");
	
	say("ENGINE STARTED");
	
	println("");

	// create the fan objects
	createFans();
	
	// create the presence checker
	presenceChecker = new Smoother(50);
	
	// PROGRAMS
	// 
	// 0 = silence
	// 1 = demo 1 - on/off
	// 2 = demo 2 - todo
	// 3 = demo 3 - todo
	// 4 = recording
	// 5 = play last show
	//

}

void draw() {
	
	// get interface fan value and save it
	interfaceFan.readValue();
	
	// get distance sensor value and save it
	distanceSensor.readValue();
	
	// check presence
	presenceChecker.add(distanceSensor.value);
	
	if (presenceChecker.read() > presenceCheckLength) {
		presence = true;
	} else {
		presence = false;
	}
	
	// if presence, go record that shit
	if ((presence == true) && (recording == false)) {
		
		say("Hello! Recording is about to start in. Five. Four. Three. Two. One. Recording now!");
		println("");
		println("Presence detected. Countdown running...");
		allOff();
		delay(10000);
		launchMode(4);
		
	}

	moveFans();
	
	// draw stuff
	background(#666666);
	drawStuff();

}

void createFans() {
	
	for (int i = 0; i < fanPins.length; i++) {
			
		newFan = new Fan(i + 1, fanPins[i]);
		newFan.xpos = (i + 1) * 100;
		newFan.ypos = 100;
		fans.add(newFan);
		
	}
	
}

void launchMode(int inMode) {
	
	mode = inMode;
	
	println("");
	println("Launching mode " + mode);
	// say("Launching mode " + mode);
	println("");
	
	switch (mode) {
		
		case 0:
		
			initSilence();
			
		break;
		
		case 1:
			
			initDemoOne();
			
		break;
		
		case 2:
			
			initDemoTwo();
			
		break;
		
		case 3:
			
			initDemoThree();
			
		break;
		
		case 4:
			
			initRecord();
			
		break;
		
		case 5:
			
			initLastShow();
			
		break;
		
	}
	
}

void moveFans() {
	
	// go into selected mode
	switch (mode) {
		
		case 0:
	
		  moveSilence();
		
		break;
		
		case 1:
		
		  moveDemoOne();
		
		break;
		
		case 2:
		
		  moveDemoTwo();
		
		break;
		
		case 3:
		
		  moveDemoThree();
		
		break;
		
		case 4:
		
		  moveRecord();
		
		break;
		
		case 5:
		
		  moveLastShow();
		
		break;

	}
	
}

void initSilence() {
	
  // TODO
	playingShow = false;
	
}

void moveSilence() {
	
  allOff();
	
}

void initDemoOne() {
	
	playingShow = false;

  for (int i = 0; i < fans.size(); i++) {
    
    Fan tmpFan = (Fan) fans.get(i);
    tmpFan.value = 120;
    
  }
	
}

void moveDemoOne() {
	
	float tmpValue;
	
  for (int i = 0; i < fans.size(); i++) {
  
    Fan tmpFan = (Fan) fans.get(i);

		tmpValue = tmpFan.value;

		if (tmpValue <= 120) {

			dir = 1;
		
		} else if (tmpValue >= 255) {
		
			dir = -1;
		
		}
		
		switch (dir) {
			
			case 1:
			
				tmpValue = tmpValue + 1;
				
			break;
			
			case -1:
			
				tmpValue = tmpValue - 1;
				
			break;
			
		}
		
    tmpFan.gotoValue(tmpValue);
  
  }
	
}

void initDemoTwo() {

	// TODO
	playingShow = false;
	allOff();
	
}

void moveDemoTwo() {
	
	// TODO

}

void initDemoThree() {

	// TODO
	playingShow = false;
	allOff();
	
}

void moveDemoThree() {
	
	// TODO
  
}

void initLastShow() {

	playingShow = true;
	
}

void moveLastShow() {
	
  for (int i = 0; i < fans.size(); i++) {
	
		float tmpValue = newRecord.values[i];
		tmpValue = map(tmpValue, 0, 255, 120, 180);
		
		if (tmpValue == 120) {
			tmpValue = 0;
		} else if (tmpValue > 255) {
			tmpValue = 255;
		}
		
    Fan tmpFan = (Fan) fans.get(i);
		tmpFan.gotoValue(tmpValue);
		
	}
  
}

void initRecord() {
	
	newRecord = new Record();
	recording = true;
	playingShow = false;
	
}

void moveRecord() {
	
	if (recording == true) {
		
		if (newRecord.full == false) {
			newRecord.add(interfaceFan.value);
		} else {
			recording = false;
			launchMode(5);
		}
		
	}
	
  allOff();
	
}

void allOff() {
	
  for (int i = 0; i < fans.size(); i++) {
		
    Fan tmpFan = (Fan) fans.get(i);
		tmpFan.gotoValue(0);
		
	}
	
}

void say(String text) {
	
	if (sound == true) {
		
		String[] params = {"say", "'" + text + "'"};
		exec(params);
		
	}
	
}

void keyPressed() {
	
	if ((key == '1') || (key == '2') || (key == '3') || (key == '4') || (key == '5') || (key == '0')) {
	
		mode = int(key) - 48;
		launchMode(mode);
		
	}
	
}

void drawStuff() {
	
	float tmpSize = 0;
	
	// draw the fans
  for (int i = 0; i < fans.size(); i++) {
	
    Fan tmpFan = (Fan) fans.get(i);	
	
		if (tmpFan.value == 0) {
			tmpFan.value = 120;
		}
	
		tmpSize = map(tmpFan.value, 120, 255, 0, 50);
  
		fill(#7DD48E);
    ellipse(tmpFan.xpos, tmpFan.ypos, fanSize, fanSize);
		fill(#ffffff, 175);
    ellipse(tmpFan.xpos, tmpFan.ypos, tmpSize, tmpSize);
  
  }

	// draw the interface fan graphic		
	tmpSize = map(interfaceFan.value, 0, interfaceFanMaxValue, 0, interfaceFanSize);
	
	fill(#7DD48E, 75);
	rect(50, 35, 1200, 31);

	fill(#7DD48E);
	ellipse(50, 50, interfaceFanSize, interfaceFanSize);
	fill(#ffffff, 175);
	ellipse(50, 50, tmpSize, tmpSize);
	
	// draw the distance sensor graphic
	tmpSize = map(distanceSensor.value, 0, 1024, 0, distanceSensorSize);
	
	fill(#7DD48E, 75);
	rect(50, 150, 1200, 30);
	
	fill(#7DD48E);
	rect(35, 150, distanceSensorSize, distanceSensorSize);
	fill (#ffffff, 175);
	rect(35, 150, tmpSize, distanceSensorSize);
	
}