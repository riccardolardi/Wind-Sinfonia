public class DistanceSensor {
	
	int pin;
	float value;
	
	DistanceSensor(int inPin) {
		
		pin = inPin;
		
		println("Distance sensor initialized at pin " + pin);
		
	}
	
	void readValue() {

		value = arduino.analogRead(pin);
		
	}
	
}