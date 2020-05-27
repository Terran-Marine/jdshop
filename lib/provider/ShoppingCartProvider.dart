import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/model/ProductDescModel.dart';
import 'package:jdshop/tools/LoggerTool.dart';
import 'package:provider/provider.dart';

class ShoppingCartProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<ProductDescItemModel> _productList = [];

  List<ProductDescItemModel> get productList => _productList;

  get productCount {
    int total = 0;
    for (var value in productList) {
      total += value.count;
    }
    return total;
  }

  get productTotalPrice {
    double total = 0;
    for (var value in productList) {
      total += double.parse(value.price)*value.count;
    }
    return total;
  }

  get allProductSelect{
  return !_productList.any((element) => !element.isCheck);

  }

  changeAllProductSelect(bool b){
    _productList.forEach((element) { element.isCheck=b;});
    notifyListeners();
  }

  addProduct(ProductDescItemModel productDescItemModel) {
    ProductDescItemModel curProductDescItemModel = _productList
        .firstWhere((element) => productDescItemModel.sId == element.sId,orElse: ()=>null);

    if (curProductDescItemModel == null) {
      productDescItemModel.isCheck=true;
      _productList.add(productDescItemModel);
    } else {
      curProductDescItemModel.count += productDescItemModel.count;
    }
    notifyListeners();
  }

  addProductNumber(String id){
    ProductDescItemModel curProductDescItemModel = _productList
        .firstWhere((element) => id == element.sId,orElse: ()=>null);

    if(curProductDescItemModel!=null){
     ++ curProductDescItemModel.count;
    }
    notifyListeners();
  }

  lessProductNumber(String id){
    ProductDescItemModel curProductDescItemModel = _productList
        .firstWhere((element) => id == element.sId,orElse: ()=>null);

    if(curProductDescItemModel!=null&&curProductDescItemModel.count>1){
      -- curProductDescItemModel.count;
    }
    notifyListeners();
  }

  changeProductSelectState(String id,bool b){
    ProductDescItemModel curProductDescItemModel = _productList
        .firstWhere((element) => id == element.sId,orElse: ()=>null);

    if(curProductDescItemModel!=null){
      curProductDescItemModel.isCheck=b;
      logger.info("状态改变为${b}");
    }else{
      logger.info("找不到id：${id}");
    }
    notifyListeners();
  }

}

