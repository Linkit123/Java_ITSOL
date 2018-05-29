
public class MediumCar extends Car {
	String have_power_steering;

	public String gethave_power_steering() {
		return have_power_steering;
	}

	public void sethave_power_steering(String have_power_steering) {
		have_power_steering = have_power_steering;
	}
	
	
	public void showCarInfo() {
		super.showCarInfo();
		System.out.printf("%s",have_power_steering);
	}
}
