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

public class pair1createadminOrange {

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
  public void testAddNewAdmin() throws InterruptedException {
    testName = "testAddNewAdmin";
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

      WebElement admnmenubtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("/html/body/div/div[1]/div[1]/aside/nav/div[2]/ul/li[1]/a")));
      softAssertions
              .assertThat(admnmenubtn.isDisplayed())
              .as("Admin alanına gidiş için ilgili buton bulunamadı.");
      admnmenubtn.click();

      WebElement searchUsernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("/html/body/div/div[1]/div[2]/div[2]/div/div[1]/div[2]/form/div[1]/div/div[1]/div/div[2]/input")));
      softAssertions.assertThat(searchUsernameInput.isDisplayed())
              .as("Username arama bölümü bulunamadı");
      searchUsernameInput.sendKeys("lizmezafelix");



      WebElement srcbtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[type='submit']")));
      softAssertions
              .assertThat(srcbtn.isDisplayed())
              .as("Giriş yap butonu bulunamadı.");
      srcbtn.click();


      WebElement element = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("/html/body/div/div[1]/div[2]/div[2]/div/div[2]/div[3]/div/div[2]/div/div/div[2]/div")));
      String text = element.getText();
      softAssertions.assertThat(text.contains("lizmezafelix")).as("Metin bulunamadı: 'lizmezafelix'").isTrue();
      //System.out.println("çıkan sonuç: " + text);



    /*  WebElement addBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("/html/body/div/div[1]/div[2]/div[2]/div/div[2]/div[1]/button")));
      softAssertions
              .assertThat(addBtn.isDisplayed())
              .as("'ADD' butonu bulunamadı.");
      addBtn.click();

      softAssertions.assertThat(firefoxDriver.getCurrentUrl())
              .as("Giriş yapıldıktan sonra yönlendirilen url yanlış.")
              .isEqualTo("https://opensource-demo.orangehrmlive.com/web/index.php/admin/saveSystemUser");

      /* WebElement dropdown = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[1]/div/div[1]/div/div[2]/div/div/div[2]")));
      Select select = new Select(dropdown);
      select.selectByVisibleText("Admin");
      softAssertions.assertThat(dropdown.isDisplayed()).as("Rol için açılır menü görünür değil");

// Açılır menüyü açmak için dropdown öğesini bulup tıklayın
      WebElement dropdown = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[1]/div/div[1]/div/div[2]/div/div/div[2]")));
      dropdown.click();

// Kısa bir bekleme ekleyin ve ardından 'Admin' seçeneğini bulmaya çalışın
      WebElement option = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//div[contains(@class, 'oxd-select-option') and contains(text(), 'Admin')]")));
      option.click();

// Açılır menünün görünürlüğünü kontrol edin
      softAssertions.assertThat(dropdown.isDisplayed()).as("Rol için açılır menü görünür değil.");

*/



    }
    finally {
      softAssertions.assertAll();
    }
  } //Admin search kısmındaki username isimlerinin eşleşmesi



}
