import 'package:flutter/material.dart';
import 'package:git_client_app/common/git.dart';
import 'package:git_client_app/l10n/gm_localizations.dart';
import 'package:git_client_app/models/repo.dart';
import 'package:git_client_app/states/user_model.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  static const loadingTag = '##loading##'; //表尾标记
  var items = <Repo>[Repo()..name = loadingTag];
  bool hasMore = true; //是否还有数据
  int page = 1; //当前请求的是第几页
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalization.of(context).home),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      //用户未登录，显示登录按钮
      return Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('login');
            },
            child: Text(GmLocalization.of(context).login)),
      );
    } else {
      //已登录，显示项目列表
      return ListView.separated(
          itemBuilder: ((context, index) {
            //如果到了表尾
            if (items[index].name == loadingTag) {
              //不足100条，继续获取数据
              if (hasMore) {
                //获取数据
                _retriveData();
                //加载时显示loading
                return Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                );
              } else {
                //没有更多数据了
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    GmLocalization.of(context).noMoreData,
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
              }
            }
            return Text('data');
          }),
          separatorBuilder: ((context, index) {
            return const Divider(
              height: .0,
            );
          }),
          itemCount: items.length);
    }
  }

  void _retriveData() async {
    var data = await Git(context)
        .getRepos(queryParameters: {'page': page, 'page_size': 20});
    //如果返回的数据小于指定的条数，则表示没有更多数据，反之则否
    hasMore = data.isNotEmpty && data.length % 20 == 0;
    //把请求到的数据添加到items中
    setState(() {
      items.insertAll(items.length - 1, data);
      page++;
    });
  }
}
