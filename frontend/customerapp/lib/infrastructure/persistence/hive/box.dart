import 'package:hive/hive.dart';
import 'package:mutex/mutex.dart';


const key = "key";


class PersistentBox<P> {
  TypeAdapter<P> adapter;
  String boxName;
  Box<P> hiveBoxForAdapter;
  final Mutex operationsLock = Mutex();
  PersistentBox(this.adapter, this.boxName);

  void initBox() async {
    Hive.registerAdapter(adapter);
    hiveBoxForAdapter = await Hive.openBox<P>(this.boxName);
  }

  void persistElement(P element) async {
    if(!Hive.isBoxOpen(boxName)) 
      hiveBoxForAdapter = await( Hive.openBox<P>(this.boxName));
    operationsLock.acquire();
    hiveBoxForAdapter.put(key, element);
    operationsLock.release();
  }

  Future<P> getElement() async {
    if(!Hive.isBoxOpen(boxName)) 
      hiveBoxForAdapter = await( Hive.openBox<P>(this.boxName));
    operationsLock.acquire();
    P toReturn = hiveBoxForAdapter.get(key);
    operationsLock.release();
    return toReturn;
  }

}