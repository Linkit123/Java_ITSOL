package View;

import java.sql.SQLException;

import controller.AccountAlready;
import controller.Handler;
import model.ThongTinQuanLy;

public class Demo {

  public static void main(String[] args) {
    AccountAlready acc = new AccountAlready();
    acc.AccountAlready1();
    Handler hd = new Handler();
    hd.handler();
    }
}
