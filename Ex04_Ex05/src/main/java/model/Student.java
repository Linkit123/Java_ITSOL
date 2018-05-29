package model;

import java.util.Scanner;

public class Student {
	public String account;
	public int id;
	public String hoten;
	public String email;
	public int sdt;
	public String lop;
	public String ghichu;
	public void nhap() {
		Scanner sc = new Scanner(System.in);
	    System.out.println("nhap id: ");
	    id = sc.nextInt();
	    sc.nextLine();
	    System.out.println("nhap hoten: ");
	    hoten = sc.nextLine();
	    System.out.println("nhap email: ");
	    email = sc.nextLine();
	    System.out.println("nhap sdt: ");
	    sdt = sc.nextInt();
	    sc.nextLine();
	    System.out.println("nhap lop: ");
	    lop = sc.nextLine();
	    System.out.println("nhap ghichu: ");
	    ghichu = sc.nextLine();
	}
	
	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getHoten() {
		return hoten;
	}
	public void setHoten(String hoten) {
		this.hoten = hoten;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getSdt() {
		return sdt;
	}
	public void setSdt(int sdt) {
		this.sdt = sdt;
	}
	public String getLop() {
		return lop;
	}
	public void setLop(String lop) {
		this.lop = lop;
	}
	public String getGhichu() {
		return ghichu;
	}
	public void setGhichu(String ghichu) {
		this.ghichu = ghichu;
	}
	
}
