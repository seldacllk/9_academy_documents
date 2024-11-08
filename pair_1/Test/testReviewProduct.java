package org.etiya;

import org.apache.commons.io.FileUtils;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.io.File;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.Date;

public class testReviewProduct {

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

      // "Product Link" Ürün ismine tıklama
      WebElement productLink = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("/html/body/div/div/div/div[2]/div/div/div/div[1]/div[2]/div[1]/a/div")));
      softAssertions.assertThat(productLink.isDisplayed())
              .as("Tıklanabilir Ürün İsmi bulunamadı");
      String getHomePageProductName = productLink.getText();
      productLink.click();
      //System.out.println(getHomePageProductName);


      String expectedUrl = "https://www.saucedemo.com/inventory-item.html?id=4";
      String actualUrl = firefoxDriver.getCurrentUrl();
      softAssertions.assertThat(actualUrl)
              .as("Ürün Sayfasına Yönlendirmedi veya Doğru Ürün Sayfasına Yönlendirilmedi")
              .isEqualTo(expectedUrl);
      //System.out.println(expectedUrl);



      WebElement productPageProductName = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[data-test='inventory-item-name']")));
      String getProductPageProductName = productPageProductName.getText();

      softAssertions.assertThat(getHomePageProductName)
              .as("Ürün Adları Eşleşmiyor.")
              .isEqualTo(getProductPageProductName);


    } finally {
      softAssertions.assertAll();
    }

  }


}
