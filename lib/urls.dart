//final String SITE_URL = "http://192.168.1.2/dharan_ver2_fullset/";
//final String SITE_URL = "http://192.168.1.7/dharan/";
//final String SITE_URL = "http://192.168.1.3/online/dharan/";
final String SITE_URL = "https://demo.sigmacomputers.in/sigmaappointments/";
// final String SITE_URL = "https://www.dharanhospital.com/";
final String BASE_URL = SITE_URL +"api/api_call.php?type=";
//final String BASE_URL = SITE_URL +"api/api_calls.php?type=";
final String BASE_TWO_URL = "/api/api_call.php?type=";
final String GET_DOCTORS_LIST = BASE_URL+"consultant_list"+sCode;
final String GET_DEPARTMENT_LIST = BASE_URL+"department_list"+sCode;
final String GET_DOCTORS_DETAILS = BASE_URL+"consultant_details&consultant_id=";
final String GET_DEPARTMENT_DETAILS = BASE_URL+"department_details&department_id=";
final String POST_APPOINTMENT_DETAILS = BASE_URL+"book_appointment"+sCode;
final String ADD_APPOINTMENT = BASE_URL+"add_appointment"+sCode;
final String POST_ENQUIRY_DETAILS = BASE_URL+"add_enquiry"+sCode;
final String GET_ANNOUNCEMENT = BASE_URL+"get_announcement"+sCode;
final String GET_ADMIN_SETTING = BASE_URL+"admin_setting"+sCode;
final String HOSPITAL_LIST = BASE_URL+"hospital_list"+sCode;
final String sCode = "&SiGmA_ScoDE=KSDn^6M5/@lKf^o~*d4U7/8J!n)";
