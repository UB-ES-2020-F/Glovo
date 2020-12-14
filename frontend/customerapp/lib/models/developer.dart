class Developer {
  String name;
  String githubUsername;
  String githubLink;
  String image;
  String roles;

  Developer(
      {this.name,
      this.githubUsername,
      this.githubLink,
      this.image,
      this.roles});
}

class DeveloperList {
  List<Developer> developers;

  @override
  DeveloperList() {
    developers = List();
    developers.add(Developer(
        name: "Gerard Ortega",
        githubUsername: "RedReservoir",
        githubLink: "https://github.com/RedReservoir",
        image: "resources/images/gerard.png",
        roles: "Product Owner / Backend Developer"));
    developers.add(Developer(
        name: "Rubén Ballester",
        githubUsername: "rballeba",
        githubLink: "https://github.com/rballeba",
        image: "resources/images/ruben.png",
        roles: "Frontend Developer / Quality Assurance"));
    developers.add(Developer(
        name: "Eudald Elias",
        githubUsername: "Eudaldz",
        githubLink: "https://github.com/Eudaldz",
        image: "https://avatars1.githubusercontent.com/u/17552638?s=460&v=4",
        roles: "Backend Developer / DevOps"));
    developers.add(Developer(
        name: "Mario Moliner",
        githubUsername: "mariomoliner",
        githubLink: "https://github.com/mariomoliner",
        image: "resources/images/mario.jpg",
        roles: "Frontend Developer / Quality Assurance"));
    developers.add(Developer(
        name: "Martí Pedemonte",
        githubUsername: "pedemonte96",
        githubLink: "https://github.com/pedemonte96",
        image: "resources/images/marti.jpg",
        roles: "Frontend Developer / Backend Developer"));
  }
}
