class ServerCalls {
final String User = 'User/';
final String Client = 'Client/';
final String Invoice = 'Invoice/';
final String Endorsement = 'Endorsement/';

//End Points
static final  String Authenticate = 'User/Authenticate';
static final String RegisterNewUser = 'User/RegisterNewUser';
final String ChangeAddressRequest = 'ChangeAddressRequest';
static final String GetUserProfile = 'User/getUserProfile';
final String GetDocumentType = 'GetDocumentType';
static  String GetDashboardByClientId = 'Client/getDashboardByClientId';
static   String GetPolicyByClientId = 'Client/getPolicyByClientId';
static String GetAllInvoices = 'Invoice/getAllInvoices';
static String GetClientDeviceNotifications = 'Client/GetClientDeviceNotifications';
static String GetVehicleByPolicyAndClientId = 'Client/getVehicleByPolicyAndClientId';
static String GetDriverByPolicyAndVehicleId = 'Client/getDriverByPolicyAndVehicleId';

static String GetRecentPayment = 'Invoice/getRecentPayment';
static String AddEndorsement = 'Endorsement/AddEndorsement';
static String deleteAccount = 'delete-user';

}
