package pages;

import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.FluentWait;
import utilities.Driver;
import constants.Locators;
import utilities.ReusableMethods;

import java.time.Duration;
import java.util.NoSuchElementException;

public class AddressPage {

    public void openEditAddressModal() {
        Driver.getDriver().findElement(Locators.ADDRESS_THREE_DOTS).click();
        Driver.getDriver().findElement(Locators.EDIT_BUTTON).click();
    }

    public void fillAddressForm(String city, String district, String postalCode, String addressDescription) {
        Driver.getDriver().findElement(Locators.CITY_FIELD).sendKeys(city);
        Driver.getDriver().findElement(Locators.DISTRICT_FIELD).sendKeys(district);
        Driver.getDriver().findElement(Locators.POSTAL_CODE_FIELD).sendKeys(postalCode);
        Driver.getDriver().findElement(Locators.ADDRESS_DESCRIPTION_FIELD).sendKeys(addressDescription);
    }

    public void fillAddressDescription(String addressDescription) {
        Driver.getDriver().findElement(Locators.ADDRESS_DESCRIPTION_FIELD).clear();
        Driver.getDriver().findElement(Locators.ADDRESS_DESCRIPTION_FIELD).sendKeys(addressDescription);
    }

    public void fillAddressDescriptionMaxChar(String addressDescription) {
        Driver.getDriver().findElement(Locators.ADDRESS_DESCRIPTION_FIELD).clear();
        String repeatedDescription = addressDescription.repeat(10);
        Driver.getDriver().findElement(Locators.ADDRESS_DESCRIPTION_FIELD).sendKeys(repeatedDescription);
    }

    public void saveAddress() {
        WebElement saveButton = Driver.getDriver().findElement(Locators.SAVE_BUTTON);
        ReusableMethods.waitForVisibility(saveButton, 5);
        saveButton.click();
    }

    public void cancelAddressEdit() {
        WebElement cancelButton = Driver.getDriver().findElement(Locators.CANCEL_BUTTON);
        ReusableMethods.waitForVisibility(cancelButton, 5);
        cancelButton.click();
    }

    public boolean isModalDisplayed() {
        try {
            return Driver.getDriver().findElement(Locators.MODAL).isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }
    public boolean isDescriptionWarningDisplayed() {
        try {
            return Driver.getDriver().findElement(Locators.DESCRIPTION_WARNING).isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isDescriptionTooShortWarningDisplayed() {
        try {
            return Driver.getDriver().findElement(Locators.DESCRIPTION_TOO_SHORT_WARNING).isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isCityFieldHighlighted() {
        try {
            return Driver.getDriver().findElement(Locators.CITY_FIELD).getAttribute("class").contains("error");
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isDistrictFieldHighlighted() {
        try {
            return Driver.getDriver().findElement(Locators.DISTRICT_FIELD).getAttribute("class").contains("error");
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isPostalCodeFieldHighlighted() {
        try {
            return Driver.getDriver().findElement(Locators.POSTAL_CODE_FIELD).getAttribute("class").contains("error");
        } catch (Exception e) {
            return false;
        }
    }

    public void clickAddNewAddressButton() {
        Driver.getDriver().findElement(Locators.ADD_NEW_ADDRESS_BUTTON).click();
    }

    public void selectPrimaryAddress() {
        WebElement primaryRadioButton = Driver.getDriver().findElement(Locators.PRIMARY_ADDRESS_RADIO_BUTTON);
        ReusableMethods.waitForVisibility(primaryRadioButton, 5);
        primaryRadioButton.click();
    }

    public boolean isPrimaryAddressSelected() {
        try {
            WebElement primaryRadioButton = Driver.getDriver().findElement(Locators.PRIMARY_ADDRESS_RADIO_BUTTON);
            return primaryRadioButton.isSelected();
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isSaveButtonEnabled() {
        try {
            return Driver.getDriver().findElement(Locators.SAVE_BUTTON).isEnabled();
        } catch (Exception e) {
            return false;
        }
    }

    public void confirmDeletion() {
        WebElement yesButton = Driver.getDriver().findElement(Locators.YES_BUTTON);
        ReusableMethods.waitForVisibility(yesButton, 5);
        yesButton.click();
    }

    public boolean isDeleteConfirmationPopupDisplayed() {
        try {
            return Driver.getDriver().findElement(Locators.DELETE_CONFIRMATION_POPUP).isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isAddressDeleted() {
        try {
            return !Driver.getDriver().findElement(Locators.ADDRESS_ITEM).isDisplayed();
        } catch (Exception e) {
            return true;
        }
    }

    public void cancelDeletion() {
        WebElement noButton = Driver.getDriver().findElement(Locators.NO_BUTTON);
        ReusableMethods.waitForVisibility(noButton, 5);
        noButton.click();
    }

    public boolean isMinimumAddressWarningDisplayed() {
        try {
            WebElement warningElement = new FluentWait<>(Driver.getDriver())
                    .withTimeout(Duration.ofSeconds(10))
                    .pollingEvery(Duration.ofSeconds(1))
                    .ignoring(NoSuchElementException.class)
                    .until(driver -> driver.findElement(Locators.MINIMUM_ADDRESS_WARNING));
            return warningElement.isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }

    public void confirmMinimumAddressWarning() {
        WebElement okButton = Driver.getDriver().findElement(Locators.OK_BUTTON);
        ((JavascriptExecutor) Driver.getDriver()).executeScript("arguments[0].click();", okButton);
    }
}
