
package com.huongdanjava.log4j;
import org.apache.log4j.Logger;

public class Example {
 
    private static Logger logger = Logger.getLogger(Example.class);
 
    public static void main(String[] args) {
        logger.info("Welcome to Log4j!");
    }
}