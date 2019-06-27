class Story {
  String title = '';
  List<int> researchYears = [];
  String text = '';
  DateTime dateWritten = DateTime.now();

  void setTitle(title) => this.title = title;
  void addToResearchYears(year) => this.researchYears.add(year);
  void setText(text) => this.text = text;
}