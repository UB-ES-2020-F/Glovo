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
        image:
            "https://avatars1.githubusercontent.com/u/25274368?s=460&u=431866a78aa79e1f4b03de0b97817ea44fe3ffd4&v=4",
        roles: "PO / Backend Developer"));
    developers.add(Developer(
        name: "Rubén Ballester",
        githubUsername: "rballeba",
        githubLink: "https://github.com/rballeba",
        image:
            "https://avatars3.githubusercontent.com/u/8425343?s=460&u=aa612031d45a06bfe5066402dc1083ab5026321d&v=4",
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
        image: "https://avatars1.githubusercontent.com/u/7798562?s=460&v=4",
        roles: "Frontend Developer / Quality Assurance"));
    developers.add(Developer(
        name: "Martí Pedemonte",
        githubUsername: "pedemonte96",
        githubLink: "https://github.com/pedemonte96",
        image:
            "https://avatars1.githubusercontent.com/u/32159046?s=460&u=e89903a729c9e86b446fd68fa18aa460f6cbe097&v=4",
        roles: "Frontend Developer / Backend Developer"));
  }
}
