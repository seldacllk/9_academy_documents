package tests;

import org.junit.Assert;
import org.junit.Test;
import pages.AddressPage;
import constants.Locators;
import utilities.BaseTest;
import utilities.Driver;
import utilities.ReusableMethods;

public class AddNewCustAddressTest extends BaseTest {

    AddressPage addressPage = new AddressPage();

    @Test
    public void testAddNewAddressFR07TC01() {
        addressPage.clickAddNewAddressButton();
        addressPage.fillAddressForm("İstanbul", "Üsküdar", "34764", "Mimar Sinan Mahallesi No 15");
        addressPage.saveAddress();
        assertTrue("Ekleme pop-up mesajı görüntülenmedi", Driver.getDriver().findElement(Locators.ADDED_POPUP).isDisplayed());
        ReusableMethods.waitForVisibility(Driver.getDriver().findElement(Locators.ADDED_POPUP), 5);
    }

    @Test
    public void testCancelAddNewAddressFR07TC02() {
        addressPage.clickAddNewAddressButton();
        addressPage.fillAddressForm("İstanbul", "Üsküdar", "34764", "Mimar Sinan Mahallesi No 15");
        addressPage.cancelAddressEdit();
        assertFalse("Modal ekran kapatılmadı", addressPage.isModalDisplayed());
    }

    @Test
    public void testLeavingRequiredFieldsEmptyFR07TC03() {
        addressPage.clickAddNewAddressButton();
        addressPage.fillAddressForm("", "", "", "");

        ReusableMethods.clickOutside();
        assertFalse("Save butonu aktif olmamalıdır", addressPage.isSaveButtonEnabled());
        assertTrue("City alanı kırmızı renkle belirtilmedi", addressPage.isCityFieldHighlighted());
        assertTrue("District alanı kırmızı renkle belirtilmedi", addressPage.isDistrictFieldHighlighted());
        assertTrue("Postal code alanı kırmızı renkle belirtilmedi", addressPage.isPostalCodeFieldHighlighted());
    }
}
