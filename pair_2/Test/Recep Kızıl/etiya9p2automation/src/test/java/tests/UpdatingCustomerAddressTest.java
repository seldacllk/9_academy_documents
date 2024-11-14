package tests;

import org.junit.Assert;
import org.junit.Test;
import pages.AddressPage;
import constants.Locators;
import utilities.BaseTest;
import utilities.Driver;
import utilities.ReusableMethods;


public class UpdatingCustomerAddressTest extends BaseTest {

    AddressPage addressPage = new AddressPage();

    @Test
    public void testEditAddressFR06TC01() {
        addressPage.openEditAddressModal();
        addressPage.fillAddressForm("İstanbul", "Kadıköy", "34710", "Erenköy Mahallesi, Ethem Efendi Caddesi No 15");
        addressPage.saveAddress();
        Assert.assertTrue(Driver.getDriver().findElement(Locators.UPDATED_POPUP).isDisplayed());
        ReusableMethods.waitForVisibility(Driver.getDriver().findElement(Locators.UPDATED_POPUP), 5);
    }

    @Test
    public void testCancelEditAddressFR06TC02() {
        addressPage.openEditAddressModal();
        addressPage.fillAddressForm("İstanbul", "Kadıköy", "34710", "Erenköy Mahallesi, Ethem Efendi Caddesi No 15");
        addressPage.cancelAddressEdit();
        Assert.assertFalse("Modal ekran kapatılamadı", addressPage.isModalDisplayed());
    }

    @Test
    public void testAddressDescriptionTooLongFR06TC03() {
        addressPage.openEditAddressModal();
        waitFor(3);
        addressPage.fillAddressForm("İstanbul", "Kadıköy", "34710", "");
        addressPage.fillAddressDescriptionMaxChar("Erenköy Mahallesi, Ethem Efendi Caddesi No 15");
        Assert.assertTrue("500+ karakter uyarısı görüntülenmedi", addressPage.isDescriptionWarningDisplayed());
    }

    @Test
    public void testAddressDescriptionTooShortFR06TC04() {
        addressPage.openEditAddressModal();
        addressPage.fillAddressForm("İstanbul", "Kadıköy", "34710", "");
        String shortDescription = "Erenköy";
        addressPage.fillAddressDescription(shortDescription);
        Assert.assertTrue("10 karakterden az uyarısı görüntülenmedi", addressPage.isDescriptionTooShortWarningDisplayed());
    }

    @Test
    public void testMandatoryFieldsEmptyFR06TC05() {
        addressPage.openEditAddressModal();
        addressPage.fillAddressForm("", "", "", "");
        ReusableMethods.clickOutside();
        Assert.assertTrue("City alanı kırmızı renkle belirtilmedi", addressPage.isCityFieldHighlighted());
        Assert.assertTrue("District alanı kırmızı renkle belirtilmedi", addressPage.isDistrictFieldHighlighted());
        Assert.assertTrue("Postal code alanı kırmızı renkle belirtilmedi", addressPage.isPostalCodeFieldHighlighted());
        Assert.assertTrue("Address description için uyarı görüntülenmedi", addressPage.isDescriptionTooShortWarningDisplayed());
    }

    @Test
    public void testSelectPrimaryAddressFR06TC06() {
        addressPage.openEditAddressModal();
        addressPage.fillAddressForm("İstanbul", "Kadıköy", "34710", "Göztepe Mahallesi No 25");
        addressPage.saveAddress();
        Assert.assertTrue("Güncelleme pop-up mesajı görüntülenmedi", Driver.getDriver().findElement(Locators.UPDATED_POPUP).isDisplayed());
        ReusableMethods.waitForVisibility(Driver.getDriver().findElement(Locators.UPDATED_POPUP), 5);
        addressPage.selectPrimaryAddress();
        Assert.assertTrue("Yeni eklenen adres primary olarak ayarlanamadı", addressPage.isPrimaryAddressSelected());
    }
}
