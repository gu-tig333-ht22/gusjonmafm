/*
List indexList(map) {
  List list = [];
  map.forEach((k, v) => list.add(k));
  return list;
}

int indexRandom(map) {
  List list = indexList(map);
  Random random = new Random();
  int x = 1001;
  while (list.contains(x) == true) {
    int x = random.nextInt(1000);
  }
  return x;
}
*/