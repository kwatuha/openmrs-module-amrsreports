    <%@ include file="/WEB-INF/template/include.jsp"%>
        <%@ include file="/WEB-INF/template/header.jsp"%>

        <%@ include file="localHeader.jsp"%>

        <openmrs:htmlInclude file="/dwr/util.js"/>
        <openmrs:htmlInclude file="/scripts/jquery/dataTables/css/dataTables.css" />
        <openmrs:htmlInclude file="/moduleResources/amrsreport/jquery.dataTables.min.js" />
        <openmrs:htmlInclude file="/moduleResources/amrsreport/jquery.tools.min.js" />
        <openmrs:htmlInclude file="/moduleResources/amrsreport/css/dataTables_jui.css" />

        <openmrs:htmlInclude file="/dwr/interface/DWRAmrsReportService.js"/>


        <script type="text/javascript">
        var selectedRpts=[];
        $j(document).ready(function(){
        var oTable = $j("#rptuserreportdt").dataTable();
       });
        </script>

        <script type="text/javascript">
        var userReports=new Array();
        var checkifselected='';
        $j(document).ready(function(){

        $j("#revokePrivSelBtn").click(function(){

        DWRAmrsReportService.revokeUserPrivileges(userReports,callbackfuncArr );
        });


        $j("#saverptuser").click(function(){
        var  userid=$j("#systemusers").val();
        var reportuuid=$j("#rptDefitionctl").val();
           if((userid>0) && (reportuuid>0)){
        DWRAmrsReportService.saveUserReports(reportuuid,userid,callbackfunc);
        }


        });

        function callbackfunc(data){
        alert(data);
        }

        function callbackfuncArr(data){
            $j.each( data, function(index, value) {
            alert(index + ': ' + value);
            });
        }
        });

        function showMyItem(myitem,ischecked){

        if(ischecked==true) {
        userReports.push(myitem);

        }else{
        userReports= $j.grep(userReports, function(value) {
        return value != myitem;
        });
        }
        }
       </script>
        <b class="boxHeader">Assign Reports Users</b>
        <div class="box" style=" width:99%; height:auto;  overflow-x: auto;">
        <table>
        <tr>
        <td>Report</td>
        <td>
        <select id="rptDefitionctl" name="definition">
        <option  value="0">Select Report Definition</option>
        <c:forEach var="rptdefinition" items="${reportDefinitions}">
        <option  value="${rptdefinition.uuid}" >${rptdefinition.name}</option>
        </c:forEach>
        </select>
        </td>

        </tr>
        <tr>
        <td>Select User</td>
        <td>
        <select name="systemusers" id="systemusers">
        <option  value="0">Select Report User</option>
        <c:forEach var="listsysusers" items="${sysusers}">
        <option id="${listsysusers.userId}"
        value="${listsysusers.userId}">
        ${listsysusers.username}</option>
        </c:forEach>
        </select>
        </td>

        </tr>
        <tr>

        <td>
        &nbsp;

        </td>
        <td>
        <input type="submit" value="Save" id="saverptuser">

        </td>
        </tr>
        </table>
        </div>

         <p></p>
        <b class="boxHeader">Assigned Report Privileges</b>
        <div class="box" style=" width:95%; height:auto;  overflow-x: auto;">
        <input id="revokePrivSelBtn" type="button" value="Revoke privileges" />
        <table id="rptuserreportdt" align="left" width="95%">
        <thead>
        <tr>

        <th>Report</th>
        <th>User</th>

        <th>&nbsp;</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="listreports" items="${listUserReports}">
        <tr>
        <td><input type="checkbox" value="${listreports.id}"  onClick="showMyItem(this.value,this.checked)"></td>
        <td>${listreports.reportDefinitionUuid} &nbsp-> ${listreports.reportDefinitionName} </td>
        <td>${listreports.amrsReportsUser.username}</td>
        </tr>

        </c:forEach>
        </tbody>
        </table>

        </div>



