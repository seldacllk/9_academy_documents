package org.etiya;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args )
    {
        FirefoxDriver driver = new FirefoxDriver();
        driver.get("https://www.saucedemo.com");

        WebElement usernameInput= driver.findElement(By.id("user-name"));
        WebElement passwordInput= driver.findElement(By.id("password"));

        usernameInput.sendKeys("standard_user");
        passwordInput.sendKeys("secret_sauce");

        WebElement loginButton = driver.findElement(By.id("login-button"));
        loginButton.click();

        
        //Thread.sleep(5000);

        //driver.quit();

    }
}
