public class InterfaceFan {
	
	int pin;
	float value;
	
	InterfaceFan(int inPin) {
		
		pin = inPin;
		
		println("Interface Fan initialized at pin " + pin);
		
	}
	
	void readValue() {

		value = arduino.analogRead(pin);
		
		if ((value > 20) && (value < 60)) {
			arduino.digitalWrite(led1Pin, arduino.LOW);
			arduino.digitalWrite(led2Pin, arduino.LOW);
			arduino.digitalWrite(led3Pin, arduino.LOW);
			arduino.digitalWrite(led4Pin, arduino.LOW);
		} else if ((value > 60) && (value < 80)) {
			arduino.digitalWrite(led1Pin, arduino.HIGH);
			arduino.digitalWrite(led2Pin, arduino.LOW);
			arduino.digitalWrite(led3Pin, arduino.LOW);
			arduino.digitalWrite(led4Pin, arduino.LOW);
		} else if ((value > 80) && (value < 120)) {
			arduino.digitalWrite(led1Pin, arduino.HIGH);
			arduino.digitalWrite(led2Pin, arduino.HIGH);
			arduino.digitalWrite(led3Pin, arduino.LOW);
			arduino.digitalWrite(led4Pin, arduino.LOW);
		}	 else if ((value > 120) && (value < 140)) {
			arduino.digitalWrite(led1Pin, arduino.HIGH);
			arduino.digitalWrite(led2Pin, arduino.HIGH);
			arduino.digitalWrite(led3Pin, arduino.HIGH);
			arduino.digitalWrite(led4Pin, arduino.LOW);
		}	 else if (value > 140) {
			arduino.digitalWrite(led1Pin, arduino.HIGH);
			arduino.digitalWrite(led2Pin, arduino.HIGH);
			arduino.digitalWrite(led3Pin, arduino.HIGH);
			arduino.digitalWrite(led4Pin, arduino.HIGH);
		}
		
	}
	
}