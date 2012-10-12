<%@ include file="/WEB-INF/template/include.jsp"%>

<openmrs:require privilege="View HL7 Inbound Queue"
                 otherwise="/login.htm" redirect="module/reprocesshl7error/hl7Reprocess.htm" />

<%@ include file="/WEB-INF/template/header.jsp"%>

<openmrs:htmlInclude file="/scripts/jquery/highlight/jquery.highlight-3.js" />
<openmrs:htmlInclude file="/scripts/jquery/dataTables/js/jquery.dataTables.min.js" />
<openmrs:htmlInclude file="/scripts/jquery/dataTables/js/jquery.dataTables.filteringDelay.js" />
<openmrs:htmlInclude file="/scripts/jquery-ui/js/jquery-ui.custom.min.js" />
<link href="<openmrs:contextPath/>/scripts/jquery-ui/css/<spring:theme code='jqueryui.theme.name' />
<jquery-ui.custom.css" type="text/css" rel="stylesheet" />
<openmrs:htmlInclude file="/scripts/jquery/dataTables/css/dataTables.css" />
<openmrs:htmlInclude file="/scripts/jquery/dataTables/css/dataTables_jui.css" />
<!-- dwr include -->
<openmrs:htmlInclude file="dwr/interface/DWRTESTService.js" />
<form method="POST" id="frmMohReportUser">
    <table border="1">
        <tr><th><tr><td>Address </td><td><input type="text" id="address"name="address"> </td></tr>
        <tr><th><tr><t>Select User</t> </td><td>
        <select name="systemusers" id="systemusers">
            <c:forEach var="listsysusers" items="${sysusers}">
                <option id="${listsysusers.userId}"
                        value="${listsysusers.userId}">
                    ${listsysusers.username}</option>
            </c:forEach>
        </select>
</td></tr>


        <tr>
            <td><b>Location:</b></td>
            <td><select name="rptdefinition"">
                <c:forEach var="listrpts" items="${listReports}" >
                    <option  value="${listReports.uuid}" >${listReports.name}</option>
                </c:forEach>
                </select>
            </td>
        </tr>


    </table></form>
<table cellpadding="5" width="100%" id="alphaNutritionAllocationdt">
    <thead>
    <tr>
    <th class="tdClass">User</th><th class="tbClass">User</th>
    <th class="tbClass">Report </th>
    <tbody>
    <c:forEach var="listUserReports" items="${listUserReports}" varStatus="encIndex" >
        <form method="POST" name="${listUserReports.uuid}">
            <tr>
                <td class="tdClass">${encIndex.index + 1}</td>
                <td class="tbClass">${listUserReports.reportDefinitionUuid}</td>
                <td class="tbClass">${listUserReports.amrsReportsUser.username}</td>

                </td>
            </tr>
        </form>
    </c:forEach>
    </tbody>
</table>