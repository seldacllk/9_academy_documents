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

public class pair1logintestOrange {

  FirefoxDriver firefoxDriver;
  WebDriverWait wait;
  SoftAssertions softAssertions;
  String testName;

  @BeforeEach // Her test öncesi çalıştırılacak ortak func.
  public void setup() {
    firefoxDriver = new FirefoxDriver();
    wait = new WebDriverWait(firefoxDriver, Duration.ofSeconds(60));
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
  public void testTitleShouldBeCorrect()
  {
    testName = "testTitleShouldBeCorrect";
    String expectedResult = "OrangeHRM";
    firefoxDriver.get("https://opensource-demo.orangehrmlive.com/web/index.php/auth/login");
    String actualResult = firefoxDriver.getTitle();
    assertEquals(expectedResult, actualResult, "Titlelar uyuşmuyor.");
  }
  @Test
  public void testLoginWithCorrectCredentials() throws InterruptedException {
    testName = "testLoginWithCorrectCredentials";
    firefoxDriver.get("https://opensource-demo.orangehrmlive.com/web/index.php/auth/login");
    try{
      WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Username']")));
      softAssertions
              .assertThat(usernameInput.isDisplayed())
              .as("Kullanıcı adı girişi bulunamadı.");
      usernameInput.sendKeys("Admin");

      WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Password']")));
      softAssertions.assertThat(passwordInput.isDisplayed())
              .as("Şifre girişi bulunamadı.");
      passwordInput.sendKeys("admin123");

      WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("/html/body/div/div[1]/div/div[1]/div/div[2]/div[2]/form/div[3]/button")));
      softAssertions
              .assertThat(loginBtn.isDisplayed())
              .as("Giriş yap butonu bulunamadı.");
      loginBtn.click();

      softAssertions.assertThat(firefoxDriver.getCurrentUrl())
              .as("Giriş yapıldıktan sonra yönlendirilen url yanlış.")
              .isEqualTo("https://opensource-demo.orangehrmlive.com/web/index.php/dashboard/index");
    }
    finally {
      softAssertions.assertAll();
    }
  }

}
