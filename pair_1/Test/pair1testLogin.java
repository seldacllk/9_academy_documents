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

public class pair1testLogin {

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
    String expectedResult = "Etiya9 Pair1 CRM";
    firefoxDriver.get("https://localhost:4301/login");
    String actualResult = firefoxDriver.getTitle();
    assertEquals(expectedResult, actualResult, "Titlelar uyuşmuyor.");
    //
  } //Website title kontrolü

  @Test
  public void testLoginWithCorrectCredentials() throws InterruptedException {
    testName = "testLoginWithCorrectCredentials";
    firefoxDriver.get("https://localhost:4301/login");
    try{
      WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Username']")));
      softAssertions
              .assertThat(usernameInput.isDisplayed())
              .as("Kullanıcı adı girişi bulunamadı.");
      usernameInput.sendKeys("test@test.com");// kullanıcı adı yerine "test@test.com" yazıyor.

      WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Password']")));
      softAssertions.assertThat(passwordInput.isDisplayed())
              .as("Şifre girişi bulunamadı.");
      passwordInput.sendKeys("12345"); //şifreye "12345" yazıyor

      WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='login-button']")));
      softAssertions
              .assertThat(loginBtn.isDisplayed())
              .as("Giriş yap butonu bulunamadı.");
      loginBtn.click(); // giriş yap butonuna tıklıyor.

      softAssertions.assertThat(firefoxDriver.getCurrentUrl())
              .as("Giriş yapıldıktan sonra yönlendirilen url yanlış.")
              .isEqualTo("https://localhost:4301/customer-search"); //giriş yaptıktan sonra yönlendirilen sayfayı kontrol ediyor



    }
    finally {
      softAssertions.assertAll();
    }
  } //Doğru bilgilerle giriş

  @Test
  public void testLoginWithIncorrectCredentials() throws InterruptedException {
    testName = "testLoginWithIncorrectCredentials";
    firefoxDriver.get("https://localhost:4301/login");
    try {
      WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Username']")));
      softAssertions
              .assertThat(usernameInput.isDisplayed())
              .as("Kullanıcı adı girişi bulunamadı.");
      usernameInput.sendKeys("wronguser@test.com"); // yanlış kullanıcı adı giriyor

      WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Password']")));
      softAssertions.assertThat(passwordInput.isDisplayed())
              .as("Şifre girişi bulunamadı.");
      passwordInput.sendKeys("wrongpassword"); // yanlış şifre giriyor

      WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='login-button']")));
      softAssertions
              .assertThat(loginBtn.isDisplayed())
              .as("Giriş yap butonu bulunamadı.");
      loginBtn.click(); // giriş yap butonuna tıklıyor.

      // Başarısız giriş sonrası hata mesajını kontrol ediyor
      WebElement errorMessage = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='error-message-wrong']")));
      softAssertions
              .assertThat(errorMessage.isDisplayed())
              .as("Hata mesajı görünmüyor.")
              .isTrue();
      softAssertions.assertThat(errorMessage.getText())
              .as("Hata mesajı içeriği beklenmiyor.")
              .isEqualTo("Geçersiz kullanıcı adı veya şifre."); // Beklenen hata mesajını kontrol ediyor

    } finally {
      softAssertions.assertAll();
    }
  } //Yanlış bilgilerle giriş

  @Test
  public void testLoginWithEmptyPassword() throws InterruptedException {
    testName = "testLoginWithEmptyPassword";
    firefoxDriver.get("https://localhost:4301/login");
    try {
      WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Username']")));
      softAssertions
              .assertThat(usernameInput.isDisplayed())
              .as("Kullanıcı adı girişi bulunamadı.");
      usernameInput.sendKeys("test@test.com"); // Kullanıcı adını giriyor

      WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Password']")));
      softAssertions.assertThat(passwordInput.isDisplayed())
              .as("Şifre girişi bulunamadı.");
      passwordInput.sendKeys(""); // Şifreyi boş bırakıyor

      WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='login-button']")));
      softAssertions
              .assertThat(loginBtn.isDisplayed())
              .as("Giriş yap butonu bulunamadı.");
      loginBtn.click(); // Giriş yap butonuna tıklıyor

      // Boş şifreyle giriş sonrası hata mesajını kontrol ediyor
      WebElement errorMessage = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".error-message")));
      softAssertions
              .assertThat(errorMessage.isDisplayed())
              .as("Hata mesajı görünmüyor.")
              .isTrue();
      softAssertions.assertThat(errorMessage.getText())
              .as("Hata mesajı içeriği beklenmiyor.")
              .isEqualTo("Şifre alanı boş bırakılamaz."); // Beklenen hata mesajını kontrol ediyor

    } finally {
      softAssertions.assertAll();
    }
  } //Boş şifre ile giriş

  @Test
  public void testLoginButtonDisabledWithEmptyUsernameAndPassword() throws InterruptedException {
    testName = "testLoginButtonDisabledWithEmptyUsernameAndPassword";
    firefoxDriver.get("https://localhost:4301/login");
    try {
      // Kullanıcı adı giriş alanını bulur ve herhangi bir değer girmeden kontrol eder
      WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Username']")));
      softAssertions
              .assertThat(usernameInput.isDisplayed())
              .as("Kullanıcı adı girişi bulunamadı.");

      // Şifre giriş alanını bulur ve herhangi bir değer girmeden kontrol eder
      WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Password']")));
      softAssertions.assertThat(passwordInput.isDisplayed())
              .as("Şifre girişi bulunamadı.");

      // Giriş yap butonunun etkin olup olmadığını kontrol eder
      WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='login-button']")));
      softAssertions
              .assertThat(loginBtn.isDisplayed())
              .as("Giriş yap butonu bulunamadı.");

      softAssertions.assertThat(loginBtn.isEnabled())
              .as("Kullanıcı adı ve şifre alanları boşken giriş yap butonu aktif.")
              .isFalse(); // Butonun aktif olmaması gerektiğini doğrular

    } finally {
      softAssertions.assertAll();
    }
  } //Kullanıcı adı ve şifre alanları boşken giriş

  @Test
  public void testAccountLockedAfterFiveFailedLoginAttempts() throws InterruptedException {
    testName = "testAccountLockedAfterFiveFailedLoginAttempts";
    firefoxDriver.get("https://localhost:4301/login");

    // İlk olarak 5 kez yanlış şifre ile giriş denemesi yap
    for (int i = 1; i <= 5; i++) {
      try {
        WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Username']")));
        softAssertions.assertThat(usernameInput.isDisplayed())
                .as("Kullanıcı adı girişi bulunamadı.");
        usernameInput.clear();
        usernameInput.sendKeys("test@test.com"); // Doğru kullanıcı adı giriliyor

        WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Password']")));
        softAssertions.assertThat(passwordInput.isDisplayed())
                .as("Şifre girişi bulunamadı.");
        passwordInput.clear();
        passwordInput.sendKeys("wrongpassword"); // Yanlış şifre giriliyor

        WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='login-button']")));
        softAssertions.assertThat(loginBtn.isDisplayed())
                .as("Giriş yap butonu bulunamadı.");
        loginBtn.click(); // Giriş yap butonuna tıklıyor

        // Başarısız giriş sonrası hata mesajını kontrol ediyor
        WebElement errorMessage = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".error-message")));
        softAssertions.assertThat(errorMessage.isDisplayed())
                .as("Hata mesajı görünmüyor.")
                .isTrue();

        if (i == 5) { // 5. denemede kilitlenme mesajını kontrol et
          softAssertions.assertThat(errorMessage.getText())
                  .as("Kilitlenme mesajı beklenmiyor.")
                  .isEqualTo("Hesabınız kilitlendi. Lütfen admin'e mail atın."); // Beklenen kilitlenme mesajı
        }

      } finally {
        softAssertions.assertAll();
      }
    }

    // 5 denemeden sonra doğru şifre ile giriş yapmayı dene
    try {
      WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Username']")));
      softAssertions.assertThat(usernameInput.isDisplayed())
              .as("Kullanıcı adı girişi bulunamadı.");
      usernameInput.clear();
      usernameInput.sendKeys("test@test.com"); // Doğru kullanıcı adı giriliyor

      WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Password']")));
      softAssertions.assertThat(passwordInput.isDisplayed())
              .as("Şifre girişi bulunamadı.");
      passwordInput.clear();
      passwordInput.sendKeys("12345"); // Doğru şifre giriliyor

      WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='login-button']")));
      softAssertions.assertThat(loginBtn.isDisplayed())
              .as("Giriş yap butonu bulunamadı.");
      loginBtn.click(); // Giriş yap butonuna tıklıyor

      // Girişin başarısız olduğunu doğrula
      WebElement errorMessage = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".error-message")));
      softAssertions.assertThat(errorMessage.isDisplayed())
              .as("Kilitlenmiş hesap için hata mesajı görünmüyor.")
              .isTrue();
      softAssertions.assertThat(errorMessage.getText())
              .as("Kilitlenmiş hesap mesajı beklenmiyor.")
              .isEqualTo("Hesabınız kilitlendi. Lütfen admin'e mail atın."); // Hala kilitlenmiş olduğu mesajı

    } finally {
      softAssertions.assertAll();
    }
  } //3 yanlış giriş sonrası kilitlenme mesajı ve giriş denemesi





}
