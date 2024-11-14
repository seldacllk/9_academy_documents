package utilities;

import org.junit.After;
import org.junit.Before;

public abstract class BaseTest extends ReusableMethods {

    @Before
    public void setUp() {
        Driver.getDriver().get(ConfigReader.getProperty("url"));
    }

    @After
    public void tearDown() {
        Driver.closeDriver();
    }
}

