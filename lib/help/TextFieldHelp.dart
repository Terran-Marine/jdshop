import 'package:flutter/material.dart';

TextEditingController controller = TextEditingController();

Widget buildTextField(TextEditingController controller) {
  return TextField(
    //控制正在编辑的文本。通过其可以拿到输入的文本值
    //获取方式 String value=controller.text
    controller: controller,

    //给TextField设置装饰（形状等）
    decoration:  InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent)
      ),
      //输入内容距离上下左右的距离 ，可通过这个属性来控制 TextField的高度
      contentPadding: EdgeInsets.all(10.0),
      fillColor: Colors.white, filled: true,
//            labelText: 'Hello',
      // 以下属性可用来去除TextField的边框
      disabledBorder: InputBorder.none,
      enabledBorder:  InputBorder.none,
      focusedBorder:   InputBorder.none,
    ),

    //键盘类型
    keyboardType: TextInputType.text,

    //控制键盘的功能键 指enter键，比如此处设置为next时，enter键
    //显示的文字内容为 下一步
    textInputAction: TextInputAction.next,

    //键盘大小写的显示 Only supports text keyboards  但是好像不起作用？
    //characters 默认为每个字符使用大写键盘
    //sentence 默认为每个句子的第一个字母使用大写键盘
    //word 默认为每个单词的第一个字母使用大写键盘。
    //none 默认使用小写
    textCapitalization: TextCapitalization.words,

    //是否是密码
    obscureText: false,

    //文本对齐方式(即光标初始位置)
    textAlign: TextAlign.center,

    //输入文本的样式
    style: TextStyle(fontSize: 30.0, color: Colors.blue),

    //最大行数
    maxLines: 1,

    //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
    //这种情况一般是不符合我们设计的要求的，但是有需要限制其输入的位数
    // 这时候我们可以使用下方的属性来限制
    maxLength: 9,

    // 跟最大长度限制对应，如果此属性设置为false,当输入超过最大长度
    // 限制时，依然会显示输入的内容，为true不会（默认为 true）
    maxLengthEnforced: false,

    // 限制输入的 最大长度  TextField右下角没有输入数量的统计字符串
//      inputFormatters: [LengthLimitingTextInputFormatter(11)],

    //允许的输入格式 下方的模式指只允许输入数字
//      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],

    //控制此小部件是否具有键盘焦点。
    focusNode: FocusNode(),

    //是否自动更正
    autocorrect:false,

    //是否自动获得焦点
    autofocus: false,

    //是否禁用textfield:如果为false, textfield将被“禁用”
    enabled: true,

    //光标颜色
    cursorColor: Colors.red,

    //光标宽度
    cursorWidth: 5.0,

    //光标圆角弧度
    cursorRadius: Radius.circular(5.0),

    //内容改变的回调
    onChanged: (text) {
      print('change $text');
    },

    //内容提交(按回车)的回调
    onSubmitted: (text) {
      print('submit $text');
    },

    //按回车时调用
    onEditingComplete: (){
      print('onEditingComplete');
    },

  );
}