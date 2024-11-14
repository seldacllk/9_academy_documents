package tests;

import org.junit.Test;
import pages.AddressPage;
import utilities.BaseTest;


public class DeleteCustAddressTest extends BaseTest {

    AddressPage addressPage = new AddressPage();

    @Test
    public void testDeleteCustomerAddressFR08TC01() {
        addressPage.openEditAddressModal();
        addressPage.confirmDeletion();
        assertTrue("Pop-up uyarı mesajı görüntülenmedi", addressPage.isDeleteConfirmationPopupDisplayed());
        assertTrue("Adres silinmedi", addressPage.isAddressDeleted());
    }

    @Test
    public void testCancelDeleteCustomerAddressFR08TC02() {
        addressPage.openEditAddressModal();
        addressPage.cancelDeletion();
        assertTrue("Pop-up uyarı mesajı görüntülenmedi", addressPage.isDeleteConfirmationPopupDisplayed());
        assertFalse("Adres silindi, silinmemesi gerekiyordu", addressPage.isAddressDeleted());
    }

        @Test
        public void testDeleteSingleCustomerAddressFR08TC03() {
            addressPage.openEditAddressModal();
            addressPage.confirmDeletion();
            assertTrue("Pop-up uyarı mesajı görüntülenmedi", addressPage.isDeleteConfirmationPopupDisplayed());
            assertTrue("Minimum adres uyarı mesajı görüntülenmedi", addressPage.isMinimumAddressWarningDisplayed());
            addressPage.confirmMinimumAddressWarning();
            assertFalse("Adres silindi, silinmemesi gerekiyordu", addressPage.isAddressDeleted());
        }
    }

