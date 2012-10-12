
package org.openmrs.module.amrsreport.web.controller;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Location;
import org.openmrs.api.AdministrationService;
import org.openmrs.api.UserService;
import org.openmrs.api.context.Context;
import org.openmrs.module.reporting.report.definition.ReportDefinition;
import org.openmrs.module.reporting.report.definition.service.ReportDefinitionService;
import org.openmrs.util.OpenmrsUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.openmrs.User;
import org.openmrs.module.amrsreport.UserReport;
import org.openmrs.module.amrsreport.service.MohCoreService;
import org.openmrs.api.LocationService;

@Controller
public class MohReportUserController {


    private static final Log log = LogFactory.getLog(MohReportUserController.class);

    @RequestMapping(method = RequestMethod.GET, value = "module/amrsreport/mohReportUser.form")
    public void preparePage(ModelMap map, @RequestParam(required = false, value = "includeRetired") Boolean includeRetired) {

        MohCoreService service=Context.getService(MohCoreService.class) ;
        AdministrationService adminService=Context.getAdministrationService();
        List<Location> locationList = Context.getLocationService().getAllLocations();
        map.addAttribute("location", locationList);
        UserService uservice=Context.getService(UserService.class);
        List<User>  listUsers=uservice.getAllUsers();
        map.addAttribute("sysusers",listUsers) ;
        List<UserReport>listOfUserReports =service.getAllUserReports();
        map.addAttribute("listUserReports",listOfUserReports) ;
        ReportDefinitionService rds = Context.getService(ReportDefinitionService.class);
        List<ReportDefinition> rptDefinitions = rds.getAllDefinitions(false);

        map.addAttribute("listReports",rptDefinitions) ;

    }

    @RequestMapping(method = RequestMethod.POST, value = "module/amrsreport/mohRender.form")
    public void processForm(ModelMap map, HttpServletRequest request,
                            @RequestParam(required = false, value = "rptdefinition ") String rptdefinitionuuid,
                            @RequestParam(required = true, value = "systemusers") String sytemUseId) {
        ReportDefinitionService rds = Context.getService(ReportDefinitionService.class);
        List<ReportDefinition> rptDefinitions = rds.getAllDefinitions(false);

    }


    }
