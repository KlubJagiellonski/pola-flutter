# pola_flutter
class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final controller = TextEditingController(text: "5900311000360");

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(HomeState());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
            builder: (context, state) {
              if(state is HomeLoaded){
                return Text(state.list.length.toString());
              }
              return Text("eee");
            },
          ),),

      floatingActionButton: FloatingActionButton(
        // onPressed: _checkEanCode,
        tooltip: 'Search212',
        onPressed: () {
          _homeBloc.add(GetCompanyEvent(5900311000360));
    })
    );
  }
}
