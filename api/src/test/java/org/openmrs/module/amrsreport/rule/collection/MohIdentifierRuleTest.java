package org.openmrs.module.amrsreport.rule.collection;

import org.junit.Test;
import org.junit.Assert;
import org.openmrs.module.amrsreport.rule.collection.MohIdentifierRule;
import org.openmrs.test.BaseModuleContextSensitiveTest;
import org.openmrs.PatientIdentifier;
import org.openmrs.PatientIdentifierType;
import org.openmrs.api.AdministrationService;
import org.openmrs.module.amrsreport.cache.MohCacheUtils;
import org.openmrs.Location;
import org.openmrs.api.LocationService;
import org.openmrs.GlobalProperty;
import org.openmrs.Patient;
import org.openmrs.api.PatientService;
import org.openmrs.logic.result.Result;
import org.openmrs.api.context.Context;
import java.util.List;
import java.lang.Integer;

/**
 * Test class for MohNamesRule class
 */
public class MohIdentifierRuleTest extends BaseModuleContextSensitiveTest {

    /**
     * @verifies return patient's Ampath Identifier for a patient with one identifier
     * @see MohIdentifierRule#evaluate(org.openmrs.logic.LogicContext, Integer, java.util.Map)
     */
    @Test
    public void evaluate_shouldReturnPatientsAmpathIdentifierForAPatientWithOneIdentifier() throws Exception {

        MohIdentifierRule mohIdentifierRule = new MohIdentifierRule();
        PatientService  patientService = Context.getPatientService();

        Patient patient = patientService.getPatient(7);

        Assert.assertNotNull("A null patient was returned",patient);


        Result result = mohIdentifierRule.evaluate(null, patient.getId(), null);

        Result  expectedResult = new Result("6TS-4");
        Assert.assertEquals("The patient has no Ampath Identifier",expectedResult,result);

    }

    /**
     * @verifies return patient's Ampath Identifier from a list of Identifiers
     * @see MohIdentifierRule#evaluate(org.openmrs.logic.LogicContext, Integer, java.util.Map)
     */
    @Test
    public void evaluate_shouldReturnPatientsAmpathIdentifierFromAListOfIdentifiers() throws Exception {

        MohIdentifierRule mohIdentifierRule = new MohIdentifierRule();
        PatientService  patientService = Context.getPatientService();
        /*Create a patient and assign a CCC Number*/

        Patient patient1 = patientService.getPatient(6);

        AdministrationService ams = Context.getAdministrationService();

        PatientIdentifierType cccnotype = new PatientIdentifierType();
        cccnotype.setName("CCC Number");
        cccnotype.setDescription("A unique number generated by clinics");
        patientService.savePatientIdentifierType(cccnotype);


        GlobalProperty globalProperty = new GlobalProperty();
        globalProperty.setProperty("cccgenerator.CCC");
        globalProperty.setDescription("A unique patient Number generated by Clinics");
        globalProperty.setPropertyValue("CCC Number");
        ams.saveGlobalProperty(globalProperty);

        PatientIdentifierType pit = MohCacheUtils.getPatientIdentifierType(ams.getGlobalProperty("cccgenerator.CCC"));

        Location location = Context.getLocationService().getLocation(1);

        PatientIdentifier pi = new PatientIdentifier("11740-00001", pit, location);
        patient1.addIdentifier(pi);

        patientService.savePatient(patient1);
        Context.flushSession();
        /*"12345K"*/
        Result result1 = mohIdentifierRule.evaluate(null, patient1.getId(), null);
        Result  expectedResult1 = new Result("12345K");
        Assert.assertEquals("The two identifiers are not equal",expectedResult1.toString(),result1.toString());

    }
}
