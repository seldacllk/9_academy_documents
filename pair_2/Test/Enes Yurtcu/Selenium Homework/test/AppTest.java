package org.example;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import java.time.Duration;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class AppTest {

    FirefoxDriver firefoxDriver;
    WebDriverWait wait;
    SoftAssertions softAssertions;
    @Test
    public void testPageTitleShouldBeCorrect() {
        String expectedResult = "Swag Labs";
        firefoxDriver.get("https://www.saucedemo.com/");
        String actualResult = firefoxDriver.getTitle();
        assertEquals(expectedResult, actualResult, "Titlelar uyuşmuyor.");
    }

    @Test
    public void testLoginWithCorrectCredentials() throws InterruptedException {
        firefoxDriver.get("https://www.saucedemo.com/");
        try{
            WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("user-name")));
            softAssertions
                    .assertThat(usernameInput.isDisplayed())
                    .as("Kullanıcı adı girişi bulunamadı.");
            usernameInput.sendKeys("standard_user");

            WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("password")));
            softAssertions.assertThat(passwordInput.isDisplayed())
                    .as("Şifre girişi bulunamadı.");
            passwordInput.sendKeys("secret_sauce");

            WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("login-button")));
            softAssertions
                    .assertThat(loginBtn.isDisplayed())
                    .as("Giriş yap butonu bulunamadı.");
            loginBtn.click();

            softAssertions.assertThat(firefoxDriver.getCurrentUrl())
                    .as("Giriş yapıldıktan sonra yönlendirilen url yanlış.")
                    .isEqualTo("https://www.saucedemo.com/inventory.html");
        }finally {
            softAssertions.assertAll();
        }
    }

    @Test
    public void testLoginWithWrongUsername() throws InterruptedException {
        firefoxDriver.get("https://www.saucedemo.com/");
        try{
            WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("user-name")));
            softAssertions.assertThat(usernameInput.isDisplayed())
                    .as("Kullanıcı adı girişi bulunamadı.");
            usernameInput.sendKeys("wrong_username");

            WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("password")));
            softAssertions.assertThat(passwordInput.isDisplayed())
                    .as("Şifre girişi bulunamadı.");
            passwordInput.sendKeys("secret_sauce");

            WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("login-button")));
            softAssertions.assertThat(loginBtn.isDisplayed())
                    .as("Giriş yap butonu bulunamadı.");
            loginBtn.click();

            WebElement errorMessage = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("h3[data-test='error']")));

            String expectedErrorMessage = "Epic sadface: Username and password do not match any user in this service";
            softAssertions.assertThat(errorMessage.isDisplayed())
                    .as("Hata mesajı görüntülenmedi.")
                    .isTrue();

            softAssertions.assertThat(errorMessage.getText())
                    .as("Hata mesajı beklendiği gibi değil.")
                    .isEqualTo(expectedErrorMessage);

        }finally {
            softAssertions.assertAll();
        }
    }

    @Test
    public void testLoginWithWrongPassword() throws InterruptedException {
        firefoxDriver.get("https://www.saucedemo.com/");
        try{
            WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("user-name")));
            softAssertions.assertThat(usernameInput.isDisplayed())
                    .as("Kullanıcı adı girişi bulunamadı.");
            usernameInput.sendKeys("standard_user");

            WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("password")));
            softAssertions.assertThat(passwordInput.isDisplayed())
                    .as("Şifre girişi bulunamadı.");
            passwordInput.sendKeys("wrong_password");

            WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("login-button")));
            softAssertions.assertThat(loginBtn.isDisplayed())
                    .as("Giriş yap butonu bulunamadı.");
            loginBtn.click();

            WebElement errorMessage = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("h3[data-test='error']")));

            String expectedErrorMessage = "Epic sadface: Username and password do not match any user in this service";
            softAssertions.assertThat(errorMessage.isDisplayed())
                    .as("Hata mesajı görüntülenmedi.")
                    .isTrue();

            softAssertions.assertThat(errorMessage.getText())
                    .as("Hata mesajı beklendiği gibi değil.")
                    .isEqualTo(expectedErrorMessage);

        }finally {
            softAssertions.assertAll();
        }
    }

    @Test
    public void testLoginWithWrongUsernameAndPassword() throws InterruptedException {
        String testName = "testLoginWithWrongUsernameAndPassword";
        firefoxDriver.get("https://www.saucedemo.com/");
        try{
            WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("user-name")));
            softAssertions
                    .assertThat(usernameInput.isDisplayed())
                    .as("Kullanıcı adı girişi bulunamadı.");
            usernameInput.sendKeys("standarduser");

            WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("password")));
            softAssertions.assertThat(passwordInput.isDisplayed())
                    .as("Şifre girişi bulunamadı.");
            passwordInput.sendKeys("secretsauce");

            WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("login-button")));
            softAssertions
                    .assertThat(loginBtn.isDisplayed())
                    .as("Giriş yap butonu bulunamadı.");
            loginBtn.click();

            WebElement wrongUsernamePasswordError = wait.until((ExpectedConditions.visibilityOfElementLocated(By.cssSelector("#login_button_container > div > form > div.error-message-container.error > h3"))));
            softAssertions
                    .assertThat(wrongUsernamePasswordError.isDisplayed())
                    .as("Giriş hata mesajı bulunamadı.");

            softAssertions.assertThat(wrongUsernamePasswordError.getText())
                    .as("Kullanıcı adı şifre uyuşmuyor mesajı yanlış.")
                    .isEqualTo("Epic sadface: Username and password do not match any user in this service");

        }
        finally {
            softAssertions.assertAll();
        }

    }
    @Test
    public void testLoginWithNullUsername() throws InterruptedException {
        firefoxDriver.get("https://www.saucedemo.com/");
        try{
            WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("user-name")));
            softAssertions
                    .assertThat(usernameInput.isDisplayed())
                    .as("Kullanıcı adı girişi bulunamadı.");
            usernameInput.sendKeys("");

            WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("password")));
            softAssertions.assertThat(passwordInput.isDisplayed())
                    .as("Şifre girişi bulunamadı.");
            passwordInput.sendKeys("password");

            WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("login-button")));
            softAssertions
                    .assertThat(loginBtn.isDisplayed())
                    .as("Giriş yap butonu bulunamadı.");
            loginBtn.click();

            WebElement errorMsg = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@data-test='error']")));
            softAssertions
                    .assertThat(errorMsg.isDisplayed())
                    .as("Giriş hata mesajı bulunamadı.");

            softAssertions
                    .assertThat(errorMsg.getText())
                    .as("Giriş hata mesajı yanlış.")
                    .isEqualTo("Epic sadface: Username is required");
        }finally {
            softAssertions.assertAll();
        }
    }

    @Test
    public void testLoginWithNullPassword() throws InterruptedException {
        firefoxDriver.get("https://www.saucedemo.com/");
        try{
            WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("user-name")));
            softAssertions
                    .assertThat(usernameInput.isDisplayed())
                    .as("Kullanıcı adı girişi bulunamadı.");
            usernameInput.sendKeys("username");

            WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("password")));
            softAssertions.assertThat(passwordInput.isDisplayed())
                    .as("Şifre girişi bulunamadı.");
            passwordInput.sendKeys("");

            WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("login-button")));
            softAssertions
                    .assertThat(loginBtn.isDisplayed())
                    .as("Giriş yap butonu bulunamadı.");
            loginBtn.click();

            WebElement errorMsg = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@data-test='error']")));
            softAssertions
                    .assertThat(errorMsg.isDisplayed())
                    .as("Giriş hata mesajı bulunamadı.");

            softAssertions
                    .assertThat(errorMsg.getText())
                    .as("Giriş hata mesajı yanlış.")
                    .isEqualTo("Epic sadface: Password is required");
        }finally {
            softAssertions.assertAll();
        }
    }

    @Test
    public void testLoginWithNullUsernameAndPassword() throws InterruptedException {
        firefoxDriver.get("https://www.saucedemo.com/");
        try{
            WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("user-name")));
            softAssertions
                    .assertThat(usernameInput.isDisplayed())
                    .as("Kullanıcı adı girişi bulunamadı.");
            usernameInput.sendKeys("");

            WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("password")));
            softAssertions.assertThat(passwordInput.isDisplayed())
                    .as("Şifre girişi bulunamadı.");
            passwordInput.sendKeys("");

            WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("login-button")));
            softAssertions
                    .assertThat(loginBtn.isDisplayed())
                    .as("Giriş yap butonu bulunamadı.");
            loginBtn.click();
            WebElement errorMsg = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@data-test='error']")));
            softAssertions
                    .assertThat(errorMsg.isDisplayed())
                    .as("Giriş hata mesajı bulunamadı.");

            softAssertions
                    .assertThat(errorMsg.getText())
                    .as("Giriş hata mesajı yanlış.")
                    .isEqualTo("Epic sadface: Username is required");

        }finally {
            softAssertions.assertAll();
        }
    }

    @Test
    public void testLoginWithLockedOutUser() throws InterruptedException {

        String testName = "testLoginWithLockedOutUser";
        firefoxDriver.get("https://www.saucedemo.com/");
        try{
            WebElement usernameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("user-name")));
            softAssertions
                    .assertThat(usernameInput.isDisplayed())
                    .as("Kullanıcı adı girişi bulunamadı.");
            usernameInput.sendKeys("locked_out_user");

            WebElement passwordInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("password")));
            softAssertions.assertThat(passwordInput.isDisplayed())
                    .as("Şifre girişi bulunamadı.");
            passwordInput.sendKeys("secret_sauce");

            WebElement loginBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("login-button")));
            softAssertions
                    .assertThat(loginBtn.isDisplayed())
                    .as("Giriş yap butonu bulunamadı.");
            loginBtn.click();

            WebElement lockedOutUserError = wait.until((ExpectedConditions.visibilityOfElementLocated(By.cssSelector("#login_button_container > div > form > div.error-message-container.error > h3"))));
            softAssertions
                    .assertThat(lockedOutUserError.isDisplayed())
                    .as("Kilitli kullanıcı uyarısı görüntülenmedi.");
            softAssertions.assertThat(lockedOutUserError.getText())
                    .as("Kilitli kullanıcı uyarı metni yanlış.")
                    .isEqualTo("Epic sadface: Sorry, this user has been locked out.");
        }
        finally {
            softAssertions.assertAll();
        }
    }



    @BeforeEach // Her test öncesi çalıştırılacak ortak func.
    public void setup() {
        firefoxDriver = new FirefoxDriver();
        wait = new WebDriverWait(firefoxDriver, Duration.ofSeconds(10));
        softAssertions = new SoftAssertions();
    }

    @AfterEach
    public void cleanup(){
        firefoxDriver.quit();
    }
}
