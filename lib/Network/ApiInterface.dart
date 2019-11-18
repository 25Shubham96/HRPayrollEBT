import 'dart:async';

import 'package:hrpayroll/Network/Utils.dart';
import 'package:hrpayroll/request_model/AssessmentApprovalRequest.dart';
import 'package:hrpayroll/request_model/AssetIssueRequest.dart';
import 'package:hrpayroll/request_model/AssetIssueSubformRequest.dart';
import 'package:hrpayroll/request_model/AssetReqRequest.dart';
import 'package:hrpayroll/request_model/AssetReqSubformRequest.dart';
import 'package:hrpayroll/request_model/BusinessTripRequest.dart';
import 'package:hrpayroll/request_model/CompOffRequest.dart';
import 'package:hrpayroll/request_model/ForgotPasswordRequest.dart';
import 'package:hrpayroll/request_model/IssueReturnLedgerRequest.dart';
import 'package:hrpayroll/request_model/LeaveApplicationRequest.dart';
import 'package:hrpayroll/request_model/LeaveApprovalRequest.dart';
import 'package:hrpayroll/request_model/ApproveListRequest.dart';
import 'package:hrpayroll/request_model/LeaveMasterRequest.dart';
import 'package:hrpayroll/request_model/LogOffRequest.dart';
import 'package:hrpayroll/request_model/NavigateRequest.dart';
import 'package:hrpayroll/request_model/OutOfOfficeRequest.dart';
import 'package:hrpayroll/request_model/PassportApprovalRequest.dart';
import 'package:hrpayroll/request_model/PassportRetentionRequest.dart';
import 'package:hrpayroll/request_model/PostRetentionRequest.dart';
import 'package:hrpayroll/request_model/TrainingActivityRequest.dart';
import 'package:hrpayroll/request_model/TrainingActivitySubformRequest.dart';
import 'package:hrpayroll/request_model/TrainingApprovalRequest.dart';
import 'package:hrpayroll/request_model/TrainingProviderCourseRequest.dart';
import 'package:hrpayroll/request_model/TrainingReqRequest.dart';
import 'package:hrpayroll/request_model/TrainingReqSubformRequest.dart';
import 'package:hrpayroll/request_model/UpdateObtainReleaseRequest.dart';
import 'package:hrpayroll/request_model/loginRequest.dart';
import 'package:hrpayroll/response_model/AssessmentApprovalResponse.dart';
import 'package:hrpayroll/response_model/AssetApproveListResponse.dart';
import 'package:hrpayroll/response_model/AssetIssueResponse.dart';
import 'package:hrpayroll/response_model/AssetIssueSubformResponse.dart';
import 'package:hrpayroll/response_model/AssetReqResponse.dart';
import 'package:hrpayroll/response_model/AssetReqSubformResponse.dart';
import 'package:hrpayroll/response_model/BusinessTripResponse.dart';
import 'package:hrpayroll/response_model/ClosedTrainingListResponse.dart';
import 'package:hrpayroll/response_model/CompOffResponse.dart';
import 'package:hrpayroll/response_model/EmployeeMasterResponse.dart';
import 'package:hrpayroll/response_model/FixedAssetResponse.dart';
import 'package:hrpayroll/response_model/ForgotPasswordResponse.dart';
import 'package:hrpayroll/response_model/IssueReturnLedgerResponse.dart';
import 'package:hrpayroll/response_model/LeaveApplicationResponse.dart';
import 'package:hrpayroll/response_model/LeaveApprovalResponse.dart';
import 'package:hrpayroll/response_model/LeaveApproveListResponse.dart';
import 'package:hrpayroll/response_model/LeaveMasterResponse.dart';
import 'package:hrpayroll/response_model/LookupResponse.dart';
import 'package:hrpayroll/response_model/NavigateResponseCarryFwdInfo.dart';
import 'package:hrpayroll/response_model/NavigateResponseDesigLocHistory.dart';
import 'package:hrpayroll/response_model/NavigateResponseKRA.dart';
import 'package:hrpayroll/response_model/NavigateResponseKins.dart';
import 'package:hrpayroll/response_model/NavigateResponsePayElements.dart';
import 'package:hrpayroll/response_model/NavigateResponseShift.dart';
import 'package:hrpayroll/response_model/OutOfOFficeResponse.dart';
import 'package:hrpayroll/response_model/PassportApprovalResponse.dart';
import 'package:hrpayroll/response_model/PassportApproveListResponse.dart';
import 'package:hrpayroll/response_model/PassportRetentionLedgerResponse.dart';
import 'package:hrpayroll/response_model/PassportRetentionResponse.dart';
import 'package:hrpayroll/response_model/RejectionCancellationPostResponse.dart';
import 'package:hrpayroll/response_model/RequisitionNoResponse.dart';
import 'package:hrpayroll/response_model/TrainingActivityResponse.dart';
import 'package:hrpayroll/response_model/TrainingActivitySubformResponse.dart';
import 'package:hrpayroll/response_model/TrainingApprovalResponse.dart';
import 'package:hrpayroll/response_model/TrainingApproveListResponse.dart';
import 'package:hrpayroll/response_model/TrainingCourseResponse.dart';
import 'package:hrpayroll/response_model/TrainingProviderResponse.dart';
import 'package:hrpayroll/response_model/TrainingReqResponse.dart';
import 'package:hrpayroll/response_model/TrainingReqSubformResponse.dart';
import 'package:hrpayroll/response_model/loginResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './ApiClient.dart';
import '../request_model/ActionRequest.dart';
import '../response_model/ActionResponse.dart';

class ApiInterface {
  ApiClient apiClient = ApiClient();
  static String empNo = "";

  Future<LoginResponse> checkLogin(LoginRequest data) async {
    apiClient.getClientPlain();

    var response = await apiClient.dio.post(
      "loginapi/login",
      data: loginReqToJson(data),
    );
    return loginResFromJson(response.toString());
  }

  Future<ForgotPasswordResponse> getAuthCode(
      ForgotPasswordRequest forgotPasswordRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "loginapi/getauthcode",
      data: forgotPasswordRequestToJson(forgotPasswordRequest),
    );
    return forgotPasswordResponseFromJson(response.toString());
  }

  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "loginapi/forgetpassword",
      data: forgotPasswordRequestToJson(forgotPasswordRequest),
    );
    return forgotPasswordResponseFromJson(response.toString());
  }

  Future<ForgotPasswordResponse> resetPassword(
      ForgotPasswordRequest forgotPasswordRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "loginapi/resetpassword",
      data: forgotPasswordRequestToJson(forgotPasswordRequest),
    );
    return forgotPasswordResponseFromJson(response.toString());
  }

  Future<ForgotPasswordResponse> logOff(LogOffRequest logOffRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "mobileapi/logoff",
      data: logOffRequestToJson(logOffRequest),
    );
    return forgotPasswordResponseFromJson(response.toString());
  }

  Future<EmployeeMasterResponse> getEmpData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.get(
      "employeesapi/getemployees",
    );
    return employeeMasterFromJson(response.toString());
  }

  Future<ActionResponse> assessmentSanctionResponseData(
      ActionRequest actionRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/assessmentsanction",
      data: actionReqToJson(actionRequest),
    );
    return actionResFromJson(response.toString());
  }

  Future<ActionResponse> compOffSanctionResponseData(
      ActionRequest actionRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/compsanction",
      data: actionReqToJson(actionRequest),
    );
    return actionResFromJson(response.toString());
  }

  Future<ActionResponse> businessTripSanctionResponseData(
      ActionRequest actionRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/businesssanction",
      data: actionReqToJson(actionRequest),
    );
    return actionResFromJson(response.toString());
  }

  Future<ActionResponse> outofOfficeSanctionResponseData(
      ActionRequest actionRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/outofficesanction",
      data: actionReqToJson(actionRequest),
    );
    return actionResFromJson(response.toString());
  }

  Future<ActionResponse> leaveSanctionResponseData(
      ActionRequest actionRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/leavesanction",
      data: actionReqToJson(actionRequest),
    );
    return actionResFromJson(response.toString());
  }

  Future<ActionResponse> trainingSanctionResponseData(
      ActionRequest actionRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/trainingsanction",
      data: actionReqToJson(actionRequest),
    );
    return actionResFromJson(response.toString());
  }

  Future<ActionResponse> employeeAssetSanctionResponseData(
      ActionRequest actionRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/employeeassetsanction",
      data: actionReqToJson(actionRequest),
    );
    return actionResFromJson(response.toString());
  }

  Future<ActionResponse> passportSanctionResponseData(
      ActionRequest actionRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/passportsanction",
      data: actionReqToJson(actionRequest),
    );
    return actionResFromJson(response.toString());
  }

  Future<NavigateResponseKins> kinsResponseData(
      NavigateRequest navigateRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/kins",
      data: navigateReqToJson(navigateRequest),
    );
    return navigateResponseKinsFromJson(response.toString());
  }

  Future<NavigateResponseShift> shiftResponseData(
      NavigateRequest navigateRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/shift",
      data: navigateReqToJson(navigateRequest),
    );
    return navigateResponseShiftFromJson(response.toString());
  }

  Future<NavigateResponseDesigLocHistory> designationResponseData(
      NavigateRequest navigateRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/designation",
      data: navigateReqToJson(navigateRequest),
    );
    return navigateResponseDesigLocHistoryFromJson(response.toString());
  }

  Future<NavigateResponseDesigLocHistory> locationResponseData(
      NavigateRequest navigateRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/location",
      data: navigateReqToJson(navigateRequest),
    );
    return navigateResponseDesigLocHistoryFromJson(response.toString());
  }

  Future<NavigateResponseCarryFwdInfo> carryFwdInfoResponseData(
      NavigateRequest navigateRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/carryforward",
      data: navigateReqToJson(navigateRequest),
    );
    return navigateResponseCarryFwdInfoFromJson(response.toString());
  }

  Future<NavigateResponseKRA> kraResponseData(
      NavigateRequest navigateRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/kra",
      data: navigateReqToJson(navigateRequest),
    );
    return navigateResponseKRAFromJson(response.toString());
  }

  Future<NavigateResponsePayElements> payElementResponseData(
      NavigateRequest navigateRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/payelements",
      data: navigateReqToJson(navigateRequest),
    );
    return navigateResponsePayElementsFromJson(response.toString());
  }

  Future<LeaveApprovalResponse> leaveApprovalResponseData(
      LeaveApprovalRequest leaveApprovalRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "leavemasterapi/LeaveApprove",
      data: leaveApprovalRequestToJson(leaveApprovalRequest),
    );
    return leaveApprovalResponseFromJson(response.toString());
  }

  Future<RejCanPostResponse> leaveRejCanResponseData(
      LeaveApprovalRequest leaveApprovalRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "leavemasterapi/leaveRejectCancel",
      data: leaveApprovalRequestToJson(leaveApprovalRequest),
    );
    return RejCanPostResFromJson(response.toString());
  }

  Future<TrainingApprovalResponse> trainingApprovalResponseData(
      TrainingApprovalRequest trainingApprovalRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "trainingapi/trainingapproval",
      data: trainingApprovalRequestToJson(trainingApprovalRequest),
    );
    return trainingApprovalResponseFromJson(response.toString());
  }

  Future<RejCanPostResponse> trainingRejCanResponseData(
      TrainingApprovalRequest trainingApprovalRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "trainingapi/TrainingRejectCancel",
      data: trainingApprovalRequestToJson(trainingApprovalRequest),
    );
    return RejCanPostResFromJson(response.toString());
  }

  Future<AssessmentApprovalResponse> assessmentApprovalResponseData(
      AssessmentApprovalRequest assessmentApprovalRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeeassetapi/assetapproval",
      data: assessmentApprovalRequestToJson(assessmentApprovalRequest),
    );
    return assessmentApprovalResponseFromJson(response.toString());
  }

  Future<RejCanPostResponse> assessmentRejCanResponseData(
      AssessmentApprovalRequest assessmentApprovalRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeeassetapi/AssetRejectCancel",
      data: assessmentApprovalRequestToJson(assessmentApprovalRequest),
    );
    return RejCanPostResFromJson(response.toString());
  }

  Future<PassportApprovalResponse> passportApprovalResponseData(
      PassportApprovalRequest passportApprovalRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "passportapi/PassportApproval",
      data: passportApprovalRequestToJson(passportApprovalRequest),
    );
    return passportApprovalResponseFromJson(response.toString());
  }

  Future<RejCanPostResponse> passportRejCanResponseData(
      PassportApprovalRequest passportApprovalRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "passportapi/PassportRejectCancel",
      data: passportApprovalRequestToJson(passportApprovalRequest),
    );
    return RejCanPostResFromJson(response.toString());
  }

  Future<LeaveMasterResponse> leaveMasterResponseData(
      LeaveMasterRequest leaveMasterRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "LeaveMasterApi/Master",
      data: leaveMasterRequestToJson(leaveMasterRequest),
    );
    return leaveMasterResponseFromJson(response.toString());
  }

  Future<LeaveApplicationResponse> leaveApplicationResponseData(
      LeaveApplicationRequest leaveApplicationRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "LeaveMasterApi/Application",
      data: leaveApplicationRequestToJson(leaveApplicationRequest),
    );
    return leaveApplicationResponseFromJson(response.toString());
  }

  Future<CompOffResponse> compOffResponseData(
      CompOffRequest compOffRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "LeaveMasterApi/Compensatory",
      data: compOffRequestToJson(compOffRequest),
    );
    return compOffResponseFromJson(response.toString());
  }

  Future<OutOfOfficeResponse> outOfOfficeResponseData(
      OutOfOfficeRequest outOfOfficeRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "LeaveMasterApi/OutOffice",
      data: outOfOfficeRequestToJson(outOfOfficeRequest),
    );
    return outOfOfficeResponseFromJson(response.toString());
  }

  Future<BusinessTripResponse> businessTripResponseData(
      BusinessTripRequest businessTripRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "LeaveMasterApi/Business",
      data: businessTripRequestToJson(businessTripRequest),
    );
    return businessTripResponseFromJson(response.toString());
  }

  Future<LeaveApproveListResponse> leaveApproveListResponseData(
      ApproveListRequest approveListRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "leavemasterapi/GetApprovalList",
      data: leaveApproveListRequestToJson(approveListRequest),
    );
    return leaveApproveListResponseFromJson(response.toString());
  }

  Future<AssetReqResponse> empAssetReqResponseData(
      AssetReqRequest assetReqRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeeassetapi/assetrequest",
      data: assetReqRequestToJson(assetReqRequest),
    );
    return assetReqResponseFromJson(response.toString());
  }

  Future<AssetReqSubformResponse> empAssetReqSubformResponseData(
      AssetReqSubformRequest assetReqSubformRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeeassetapi/SubAssetRequest",
      data: assetReqSubformRequestToJson(assetReqSubformRequest),
    );
    return assetReqSubformResponseFromJson(response.toString());
  }

  Future<LookupResponse> lookupResponseData(String lookupNo) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.get(
      "trainingapi/GetLookUp",
      queryParameters: {
        "lookupNo": lookupNo,
      },
    );
    return lookupResponseFromJson(response.toString());
  }

  Future<NoSeriesResponse> requisitionNoReasponseData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.get(
      "employeeassetapi/assetrequisitionno",
    );
    return noSeriesResponseFromJson(response.toString());
  }

  Future<RejCanPostResponse> assetReqRejCanResponseData(
      AssessmentApprovalRequest assessmentApprovalRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeeassetapi/AssetRejectCancel",
      data: assessmentApprovalRequestToJson(assessmentApprovalRequest),
    );
    return RejCanPostResFromJson(response.toString());
  }

  Future<IssueReturnLedgerResponse> issueReturnLedgerResponseData(
      IssueReturnLedgerRequest issueReturnLedgerRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeeassetapi/AssetIssuePost",
      data: issueReturnLedgerRequestToJson(issueReturnLedgerRequest),
    );
    return issueReturnLedgerResponseFromJson(response.toString());
  }

  Future<AssetApproveListResponse> assetApproveListResponseData(
      ApproveListRequest approveListRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeeassetapi/approvelist",
      data: leaveApproveListRequestToJson(approveListRequest),
    );
    return assetApproveListResponseFromJson(response.toString());
  }

  Future<AssetIssueResponse> assetIssueResponseData(
      AssetIssueRequest assetIssueRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeeassetapi/assetissue",
      data: assetIssueRequestToJson(assetIssueRequest),
    );
    return assetIssueResponseFromJson(response.toString());
  }

  Future<AssetIssueSubformResponse> assetIssueSubformResponseData(
      AssetIssueSubformRequest assetIssueSubformRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeeassetapi/subassetissue",
      data: assetIssueSubformRequestToJson(assetIssueSubformRequest),
    );
    return assetIssueSubformResponseFromJson(response.toString());
  }

  Future<NoSeriesResponse> issueNoReasponseData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.get(
      "employeeassetapi/createissueno",
    );
    return noSeriesResponseFromJson(response.toString());
  }

  Future<FixedAssetResponse> getAssetDetailsResponseData(
      TrainingProviderCourseRequest trainingCourseRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeeassetapi/fixedasset",
      data: trainingCourseRequestToJson(trainingCourseRequest),
    );
    return fixedAssetResponseFromJson(response.toString());
  }

  //Training Module
  Future<TrainingCourseResponse> trainingCourseResponseData(
      TrainingProviderCourseRequest trainingCourseRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "trainingapi/TrainingCourse",
      data: trainingCourseRequestToJson(trainingCourseRequest),
    );
    return trainingCourseResponseFromJson(response.toString());
  }

  Future<TrainingProviderResponse> trainingProviderResponseData(
      TrainingProviderCourseRequest trainingCourseRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "trainingapi/provider",
      data: trainingCourseRequestToJson(trainingCourseRequest),
    );
    return trainingProviderResponseFromJson(response.toString());
  }

  Future<ClosedTrainingListResponse> closedTrainingListResponseData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.get(
      "trainingapi/closed",
    );
    return closedTrainingListResponseFromJson(response.toString());
  }

  Future<TrainingApproveListResponse> trainingApproveListResponseData(
      ApproveListRequest approveListRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "trainingapi/approvelist",
      data: leaveApproveListRequestToJson(approveListRequest),
    );
    return trainingApproveListResponseFromJson(response.toString());
  }

  Future<TrainingReqResponse> trainingRequestResponseData(
      TrainingReqRequest trainingReqRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "trainingapi/TrainingRequest",
      data: trainingReqRequestToJson(trainingReqRequest),
    );
    return trainingReqResponseFromJson(response.toString());
  }

  Future<NoSeriesResponse> requestNoReasponseData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "trainingapi/CreateRequestNo",
    );
    return noSeriesResponseFromJson(response.toString());
  }

  Future<NoSeriesResponse> activityNoReasponseData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.get(
      "trainingapi/createactivityNumber",
    );
    return noSeriesResponseFromJson(response.toString());
  }

  Future<TrainingReqSubformResponse> trainingReqSubformResponseData(
      TrainingReqSubformRequest trainingReqSubformRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "trainingapi/TrainingReqSubForm",
      data: trainingReqSubformRequestToJson(trainingReqSubformRequest),
    );
    return trainingReqSubformResponseFromJson(response.toString());
  }

  Future<TrainingActivityResponse> trainingActivityResponseData(
      TrainingActivityRequest trainingActivityRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "trainingapi/Activity",
      data: trainingActivityRequestToJson(trainingActivityRequest),
    );
    return trainingActivityResponseFromJson(response.toString());
  }

  Future<TrainingActivitySubformResponse> trainingActivitySubformResponseData(
      TrainingActivitySubformRequest trainingActivitySubformRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "trainingapi/SubActivity",
      data:
          trainingActivitySubformRequestToJson(trainingActivitySubformRequest),
    );
    return trainingActivitySubformResponseFromJson(response.toString());
  }

  //Passport Module
  Future<PassportRetentionResponse> passportRetentionResponseData(
      PassportRetentionRequest passportRetentionRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "passportapi/passportretention",
      data: passportRetentionRequestToJson(passportRetentionRequest),
    );
    return passportRetentionResponseFromJson(response.toString());
  }

  Future<PassportRetentionLedgerResponse>
      passportRetentionLedgerResponseData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.get(
      "passportapi/RetentionLedger",
    );
    return passportRetentionLedgerResponseFromJson(response.toString());
  }

  Future<PassportApproveListResponse> passportApproveListResponseData(
      ApproveListRequest approveListRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "passportapi/approvelist",
      data: leaveApproveListRequestToJson(approveListRequest),
    );
    return passportApproveListResponseFromJson(response.toString());
  }

  Future<NoSeriesResponse> transactionIdReasponseData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.get(
      "passportapi/createtransactionnumber",
    );
    return noSeriesResponseFromJson(response.toString());
  }

  Future<RejCanPostResponse> postRetentionResponseData(
      PostRetentionRequest postRetentionRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "passportapi/PostRetention",
      data: postRetentionRequestToJson(postRetentionRequest),
    );
    return RejCanPostResFromJson(response.toString());
  }

  Future<RejCanPostResponse> updateObtainReleaseResponseData(
      UpdateObtainReleaseRequest updateObtainReleaseRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient.getClient(sharedPreferences.get(Util.sessionId));

    var response = await apiClient.dio.post(
      "employeesapi/UpdatePassport",
      data: updateObtainReleaseRequestToJson(updateObtainReleaseRequest),
    );
    return RejCanPostResFromJson(response.toString());
  }
}
