import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:readerscorner/utils/service_locator.dart';

class BaseView<T extends Model> extends StatefulWidget {
  final ScopedModelDescendantBuilder<T> _builder;
  final Function(T) onModelReady;
  BaseView({ScopedModelDescendantBuilder<T> builder, this.onModelReady})
      : _builder = builder;
  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends Model> extends State<BaseView<T>> {
  T _model = getIt<T>();
  Future buildLoading() {
    return Future.delayed(Duration(milliseconds: 500), () {
      return print('جاري التحميل');
    });
  }

  @override
  void didChangeDependencies() {
    if (widget.onModelReady != null) {
      widget.onModelReady(_model);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<T>(
      model: _model,
      child: Scaffold(
        body: FutureBuilder(
            future: buildLoading(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CupertinoActivityIndicator(animating: true),
                );
              }
              return ScopedModelDescendant<T>(
                builder: widget._builder,
              );
            }),
      ),
    );
    
  }
}

// FutureBuilder(
//                   future: buildLoading(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(
//                         child: CupertinoActivityIndicator(animating: true),
//                       );
//                     }
//                     return Padding(
//                       padding: model.coupon == null
//                           ? EdgeInsets.only(bottom: 120)
//                           : EdgeInsets.only(bottom: 180),
//                       child: ListView(
//                         children: _buildAddresses(context, model),
//                       ),
//                     );
//                   }),
