const baseURL = 'http://192.168.1.172:8000';
// const baseURL ='http://192.168.1.37:8000/api';

const api = "/api/auth-client-dechet";
const loginURL = '$baseURL$api/login';

const sommeURL = '$baseURL/api/auth-client-dechet/somme-total-dechet-reschool';

const loginQrURL = '$baseURL/api/qrlogin'; //mzel

const updateUserURL = '$baseURL$api/modifier-profile-client-dechet';

const updatePasswordURL = '$baseURL$api/modifier-client-dechet-password';

const forgetPasswordURL = '$baseURL/api/client/forgotPassword'; //mzel

const profileURL = '$baseURL$api/profile';

const logoutURL = '$baseURL$api/logout';

//conversation

const getConversationsURL = "$baseURL$api/getConversations";

const addConversationURL = "$baseURL$api/conversation";

const sendMessageURL = "$baseURL$api/message";

const makeConversationReadURL = "$baseURL$api/conversation/read";

// Dechets

const dechetsURL = '$baseURL/api/dechets';

const commanderURL = '$baseURL$api/panier';

const afficherDechetsClientURL = '$baseURL$api/afficherDechetsClient';

const afficherDetailsDechetURL = '$baseURL$api/afficherDetailsDechet';
