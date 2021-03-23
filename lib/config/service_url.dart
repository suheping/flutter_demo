const baseUrl = 'https://open.aiosign.com/api';
const noteUrl = 'http://192.168.2.111:8000/api';
const servicePath = {
  'getToken': baseUrl + '/v1/oauth/token',
  'queryPUserInfo': baseUrl + '/v1/user/personal/userinfo',
  'group': noteUrl + '/v1/group/',
  'note': noteUrl + '/v1/note/'
};
