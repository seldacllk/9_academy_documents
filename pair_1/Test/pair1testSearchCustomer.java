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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class pair1testSearchCustomer {

  FirefoxDriver firefoxDriver;
  WebDriverWait wait;
  SoftAssertions softAssertions;
  String testName;

  @BeforeEach // Her test öncesi çalıştırılacak ortak func.
  public void setup() {
    firefoxDriver = new FirefoxDriver();
    wait = new WebDriverWait(firefoxDriver, Duration.ofSeconds(10)); //eğer verilen yolu bulamazsa belirtilen saniye boyunca bekleyecek
    softAssertions = new SoftAssertions();
    login();
  }

  @AfterEach //Her test öncesi çalıştırılacak ortak func.
  public void cleanup(){
    takeScreenshotAfterTest(); //screebshot komutunu çalıltırır.
    firefoxDriver.quit();  //tarayıcıyı kapatır
  }

  public void login() {
    firefoxDriver.get("https://localhost:4301/login");

    WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Username']")));
    usernameInput.sendKeys("test@test.com"); // Doğru kullanıcı adı giriliyor

    WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='Password']")));
    passwordInput.sendKeys("12345"); // Doğru şifre giriliyor

    WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("[placeholder='login-button']")));
    loginBtn.click(); // Giriş yap butonuna tıklıyor

    // Giriş sonrası URL doğrulaması
    softAssertions.assertThat(firefoxDriver.getCurrentUrl())
            .as("Giriş yapıldıktan sonra yönlendirilen URL yanlış.")
            .isEqualTo("https://localhost:4301/customer-search");
  } //BeforeEach metodunun altında çalışması için gerekli olan login fonksiyonu

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
  public void testTableColumnHeaders() {
    login(); // Giriş yapıyoruz

    List<String> expectedHeaders = Arrays.asList("NAT ID No", "Customer ID", "First Name", "Last Name", "Phone No", "Email", "Is Active", "Created Date"); // Beklenen sütun başlıkları

    List<WebElement> columnHeaders = firefoxDriver.findElements(By.cssSelector(".table-header-class")); // Tablo başlıkları seçici
    List<String> actualHeaders = columnHeaders.stream().map(WebElement::getText).collect(Collectors.toList());

    softAssertions.assertThat(actualHeaders)
            .as("Tablo başlıkları sıralaması beklenmiyor.")
            .isEqualTo(expectedHeaders);
    softAssertions.assertAll();
  } //Tablodaki sütunların doğruluğunu kontrol etme

  @Test
  public void testSearchWithValidData() {
    login(); // Giriş yapıyoruz

    WebElement natIdInput = firefoxDriver.findElement(By.cssSelector("[placeholder='NAT ID No']"));
    natIdInput.sendKeys("123456789");

    WebElement firstNameInput = firefoxDriver.findElement(By.cssSelector("[placeholder='First Name']"));
    firstNameInput.sendKeys("John");

    WebElement searchBtn = firefoxDriver.findElement(By.cssSelector(".search-button"));
    searchBtn.click();

    WebElement firstResultNatId = firefoxDriver.findElement(By.cssSelector(".table-body-class tr:first-child .nat-id"));
    WebElement firstResultFirstName = firefoxDriver.findElement(By.cssSelector(".table-body-class tr:first-child .first-name"));

    softAssertions.assertThat(firstResultNatId.getText())
            .as("NAT ID No eşleşmiyor.")
            .isEqualTo("123456789");

    softAssertions.assertThat(firstResultFirstName.getText())
            .as("First Name eşleşmiyor.")
            .isEqualTo("John");

    softAssertions.assertAll();
  } //First Name ve Last Name alanlarını doldurduğumuzda doğru veriyi getirme

  @Test
  public void testEmptySearchReturnsAllCustomers() {
    login(); // Giriş yapıyoruz

    WebElement searchBtn = firefoxDriver.findElement(By.cssSelector(".search-button"));
    searchBtn.click();

    List<WebElement> allRows = firefoxDriver.findElements(By.cssSelector(".table-body-class tr"));
    softAssertions.assertThat(allRows.size())
            .as("Kayıt sayısı tüm müşterileri getirmiyor.")
            .isGreaterThan(0);

    softAssertions.assertAll();
  } //Boş arama yapıldığında tüm müşterilerin sıralanması

  @Test
  public void testActiveStatusFilter() {
    login(); // Giriş yapıyoruz

    WebElement isActiveDropdown = firefoxDriver.findElement(By.cssSelector("[placeholder='Is Active']"));
    isActiveDropdown.sendKeys("Active");

    WebElement searchBtn = firefoxDriver.findElement(By.cssSelector(".search-button"));
    searchBtn.click();

    List<WebElement> statusCells = firefoxDriver.findElements(By.cssSelector(".table-body-class .is-active"));
    for (WebElement cell : statusCells) {
      softAssertions.assertThat(cell.getText())
              .as("Aktif olmayan kayıt bulundu.")
              .isEqualTo("Active");
    }

    softAssertions.assertAll();
  } //Aktif Pasif durumuna göre filitreleme

  @Test
  public void testSearchByCreatedDate() {
    login(); // Giriş yapıyoruz

    WebElement createdDateFrom = firefoxDriver.findElement(By.cssSelector("[placeholder='Created Date From']"));
    createdDateFrom.sendKeys("01/01/2023");

    WebElement createdDateTo = firefoxDriver.findElement(By.cssSelector("[placeholder='Created Date To']"));
    createdDateTo.sendKeys("31/12/2023");

    WebElement searchBtn = firefoxDriver.findElement(By.cssSelector(".search-button"));
    searchBtn.click();

    List<WebElement> dateCells = firefoxDriver.findElements(By.cssSelector(".table-body-class .created-date"));
    for (WebElement dateCell : dateCells) {
      LocalDate createdDate = LocalDate.parse(dateCell.getText(), DateTimeFormatter.ofPattern("dd/MM/yyyy"));
      softAssertions.assertThat(createdDate)
              .as("Belirtilen tarih aralığında olmayan kayıt bulundu.")
              .isBetween(LocalDate.of(2023, 1, 1), LocalDate.of(2023, 12, 31));
    }

    softAssertions.assertAll();
  } //Tarihe göre filitreleme











}
