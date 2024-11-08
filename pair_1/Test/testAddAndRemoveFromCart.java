package org.etiya;

import org.apache.commons.io.FileUtils;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.io.File;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.Date;

public class testAddAndRemoveFromCart {

  FirefoxDriver firefoxDriver;
  WebDriverWait wait;
  SoftAssertions softAssertions;
  String testName;

  @BeforeEach // Her test öncesi çalıştırılacak ortak func.
  public void setup() {
    firefoxDriver = new FirefoxDriver();
    wait = new WebDriverWait(firefoxDriver, Duration.ofSeconds(10));
    softAssertions = new SoftAssertions();
  }

  @AfterEach
  public void cleanup(){
    takeScreenshotAfterTest();
    firefoxDriver.quit();
  }

  private void takeScreenshotAfterTest() {
    // Ekran görüntüsü al
    File screenshot = firefoxDriver.getScreenshotAs(OutputType.FILE);

    // Mevcut tarih formatı Gün-Ay-Yıl
    String currentDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date());

    // Klasör yolunu oluştur
    String folderPath = "C:\\Users\\yusuf.korukcu\\Downloads\\etiya9.selenium-main (6)\\etiya9.selenium-main\\test-ss" + currentDate;

    // Test adıyla birlikte dosya yolu
    String filePath = folderPath + "\\" + testName + ".png";

    try {
      // Klasör yoksa oluştur
      File directory = new File(folderPath);
      if (!directory.exists()) {
        directory.mkdirs(); // Klasör ve alt klasörleri oluştur
      }

      // Ekran görüntüsünü kaydet
      FileUtils.copyFile(screenshot, new File(filePath));
    } catch (Exception e) {
      e.printStackTrace();
      System.out.println("SS alınamadı.");
    }
  }

  @Test
  public void testAddAndRemoveFromCart() throws InterruptedException {
    testName = "testAddAndRemoveFromCart";
    firefoxDriver.get("https://www.saucedemo.com/");
    try {
      // Kullanıcı adı ve şifre ile giriş yap
      WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("user-name")));
      softAssertions.assertThat(usernameInput.isDisplayed())
              .as("Kullanıcı adı girişi bulunamadı.");
      usernameInput.sendKeys("standard_user");

      WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("password")));
      softAssertions.assertThat(passwordInput.isDisplayed())
              .as("Şifre girişi bulunamadı.");
      passwordInput.sendKeys("secret_sauce");

      WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("login-button")));
      softAssertions.assertThat(loginBtn.isDisplayed())
              .as("Giriş yap butonu bulunamadı.");
      loginBtn.click();

      // "Add to Cart" butonuna tıklama
      WebElement addToCartButton = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("add-to-cart-sauce-labs-backpack")));
      softAssertions.assertThat(addToCartButton.isDisplayed())
              .as("Add to Cart butonu bulunamadı.");
      addToCartButton.click();

      // Sepet ikonunda "1" yazısını doğrulama
      WebElement cartBadge = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[data-test='shopping-cart-badge']")));
      softAssertions.assertThat(cartBadge.isDisplayed())
              .as("Sepet ikonu üstünde herhangi bir sayı çıkmadı.");
      softAssertions.assertThat(cartBadge.getText())
              .as("Sepet sayısı 1 değil.")
              .isEqualTo("1");

      // "Remove" butonunun göründüğünü doğrulama
      WebElement removeButton = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("remove-sauce-labs-backpack")));
      softAssertions.assertThat(removeButton.isDisplayed())
              .as("Remove butonu bulunamadı.");
      softAssertions.assertThat(removeButton.isEnabled())
              .as("Remove butonu tıklanabilir değil.");

      // "Remove" butonuna tıklama
      removeButton.click();

      // Sepet ikonundan "1" yazısının kaybolduğunu doğrulama
      boolean isCartBadgeVisible = firefoxDriver.findElements(By.cssSelector("[data-test='shopping-cart-badge']")).isEmpty();
      softAssertions.assertThat(isCartBadgeVisible)
              .as("Remove işleminden sonra sepet ikonu üstündeki 1 sayısı kaybolmadı.")
              .isTrue();
    } finally {
      softAssertions.assertAll();
    }
  }

  @Test
  public void testAddAndRemoveFromCartWithProblemUser() throws InterruptedException {
    testName = "testAddAndRemoveFromCartWithProblemUser";
    firefoxDriver.get("https://www.saucedemo.com/");
    try {
      // Kullanıcı adı ve şifre ile giriş yap
      WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("user-name")));
      softAssertions.assertThat(usernameInput.isDisplayed())
              .as("Kullanıcı adı girişi bulunamadı.");
      usernameInput.sendKeys("problem_user");

      WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("password")));
      softAssertions.assertThat(passwordInput.isDisplayed())
              .as("Şifre girişi bulunamadı.");
      passwordInput.sendKeys("secret_sauce");

      WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("login-button")));
      softAssertions.assertThat(loginBtn.isDisplayed())
              .as("Giriş yap butonu bulunamadı.");
      loginBtn.click();

      // "Add to Cart" butonuna tıklama
      WebElement addToCartButton = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("add-to-cart-sauce-labs-backpack")));
      softAssertions.assertThat(addToCartButton.isDisplayed())
              .as("Add to Cart butonu bulunamadı.");
      addToCartButton.click();

      // Sepet ikonunda "1" yazısını doğrulama
      WebElement cartBadge = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[data-test='shopping-cart-badge']")));
      softAssertions.assertThat(cartBadge.isDisplayed())
              .as("Sepet ikonu üstünde 1 yazısı çıkmadı.");
      softAssertions.assertThat(cartBadge.getText())
              .as("Sepet sayısı 1 değil.")
              .isEqualTo("1");

      // "Remove" butonunun göründüğünü doğrulama
      WebElement removeButton = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("remove-sauce-labs-backpack")));
      softAssertions.assertThat(removeButton.isDisplayed())
              .as("Remove butonu bulunamadı.");
      softAssertions.assertThat(removeButton.isEnabled())
              .as("Remove butonu tıklanabilir değil.");

      // "Remove" butonuna tıklama
      removeButton.click();

      // Sepet ikonundan "1" yazısının kaybolduğunu doğrulama
      boolean isCartBadgeVisible = firefoxDriver.findElements(By.cssSelector("[data-test='shopping-cart-badge']")).isEmpty();
      softAssertions.assertThat(isCartBadgeVisible)
              .as("Remove işleminden sonra sepet ikonu üstündeki 1 yazısı kaybolmadı.")
              .isTrue();

      // "Remove" butonunun kaybolduğunu doğrulama
      boolean isRemoveButtonVisible = firefoxDriver.findElements(By.id("remove-sauce-labs-backpack")).isEmpty();
      softAssertions.assertThat(isRemoveButtonVisible)
              .as("Remove butonu kaybolmadı.")
              .isTrue();

      // "Add to Cart" butonunun tekrar göründüğünü doğrulama
      WebElement addToCartButtonAfterRemove = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("add-to-cart-sauce-labs-backpack")));
      softAssertions.assertThat(addToCartButtonAfterRemove.isDisplayed())
              .as("Add to Cart butonu tekrar görünmedi.");


    } finally {
      softAssertions.assertAll();
    }
  }


}
