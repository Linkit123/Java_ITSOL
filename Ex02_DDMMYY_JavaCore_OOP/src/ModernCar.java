
public class ModernCar extends Car {
	String have_positioning_device;
	
	public String getHave_positioning_device() {
		return have_positioning_device;
	}

	public void setHave_positioning_device(String have_positioning_device) {
		this.have_positioning_device = have_positioning_device;
	}

	public void showCarInfo() {
		super.showCarInfo();
		System.out.printf("%s",have_positioning_device);
	}
}