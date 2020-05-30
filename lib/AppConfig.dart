const int RECEIVE_TIMEOUT = 15000;
const String BASE_URL = "http://jd.itying.com/";

const String API_FOCUS = "api/focus"; //轮播图接口
const String API_PLIST = "api/plist"; //商品列表接口
const String API_PCATE = "api/pcate"; //商品分类接口
const String API_PCONTENT = "api/pcontent"; //商品详情接口
const String API_SENDCODE = "api/sendCode"; //发送验证码接口
const String API_REGISTER = "api/register"; //用户注册接口
const String API_DOLOGIN = "api/doLogin"; //用户登录
const String HTML_PCONTENT = "${BASE_URL}pcontent?id="; //商品详情html
const String API_ADDRESSLIST = "api/addressList"; //获取用户全部地址
const String API_ONEADDRESSLIST = "api/oneAddressList"; //用户默认地址
const String API_ADDADDRESS = "api/addAddress"; //增加用户收货地址
const String API_CHANGEDEFAULTADDRESS = "api/changeDefaultAddress"; //修改默认收货地址
const String API_EDITADDRESSS = "api/editAddress"; //修改收货地址
const String API_DELETEADDRESS = "api/deleteAddress"; //删除收货地址

const num STANDARD_WIDTH = 450;
const num STANDARD_HEIGHT = 1334;