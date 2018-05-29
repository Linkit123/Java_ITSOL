package model;

import java.util.Scanner;

public class ThongTinQuanLy {
	public static String account;
	public String firstname;
	public String lastname;
	public String email;

	public void nhap() {
		Scanner sc = new Scanner(System.in);
		System.out.println("nhap account: ");
		account = sc.nextLine();
		System.out.println("nhap firstname: ");
		firstname = sc.nextLine();
		System.out.println("nhap lastname: ");
		lastname = sc.nextLine();
		System.out.println("nhap email: ");
		email = sc.nextLine();
	}

	public static String getAccount() {
		return account;
	}

	public static void setAccount(String account) {
		ThongTinQuanLy.account = account;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
}
