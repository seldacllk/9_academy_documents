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

import static org.junit.jupiter.api.Assertions.assertEquals;

public class realLogin {

  FirefoxDriver firefoxDriver;
  WebDriverWait wait;
  SoftAssertions softAssertions;
  String testName;

  @BeforeEach // Her test öncesi çalıştırılacak ortak func.
  public void setup() {
    firefoxDriver = new FirefoxDriver();
    wait = new WebDriverWait(firefoxDriver, Duration.ofSeconds(10)); //eğer verilen yolu bulamazsa belirtilen saniye boyunca bekleyecek
    softAssertions = new SoftAssertions();
  }

  @AfterEach //Her test öncesi çalıştırılacak ortak func.
  public void cleanup(){
    takeScreenshotAfterTest(); //screebshot komutunu çalıltırır.
    firefoxDriver.quit();  //tarayıcıyı kapatır
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
  } //AfterEach metodunun altında çalışması için gerekli olan ss fonksiyonu

  @Test
  public void testTitleShouldBeCorrect() {
    testName = "testTitleShouldBeCorrect";
    String expectedResult = "Frontend";
    firefoxDriver.get("http://localhost:4200");
    String actualResult = firefoxDriver.getTitle();
    assertEquals(expectedResult, actualResult, "Titlelar uyuşmuyor.");
    //
  } //Website title kontrolü

  @Test
  public void testLoginWithCorrectCredentials() throws InterruptedException {
    testName = "testLoginWithCorrectCredentials";
    firefoxDriver.get("http://localhost:4200");
    try{
      WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[id='email']")));
      softAssertions
              .assertThat(usernameInput.isDisplayed())
              .as("Kullanıcı adı girişi bulunamadı.");
      usernameInput.sendKeys("yusuf@test.com");// kullanıcı adı yerine "test@test.com" yazıyor.

      WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[id='password']")));
      softAssertions.assertThat(passwordInput.isDisplayed())
              .as("Şifre girişi bulunamadı.");
      passwordInput.sendKeys("yusuf"); //şifreye "12345" yazıyor

      WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[type='submit']")));
      softAssertions
              .assertThat(loginBtn.isDisplayed())
              .as("Giriş yap butonu bulunamadı.");
      loginBtn.click(); // giriş yap butonuna tıklıyor.

      softAssertions.assertThat(firefoxDriver.getCurrentUrl())
              .as("Giriş yapıldıktan sonra yönlendirilen url yanlış.")
              .isEqualTo("http://localhost:4200/customer/search-customer"); //giriş yaptıktan sonra yönlendirilen sayfayı kontrol ediyor



    }
    finally {
      softAssertions.assertAll();
    }
  } //Doğru bilgilerle giriş


}
