void initalizeCredits() {

  StringBuilder rolesb = new StringBuilder();

  rolesb.append("Producer\n");
  rolesb.append("Publisher\n");
  rolesb.append("Designer\n");
  rolesb.append("Artist\n");
  rolesb.append("Programmer\n");
  rolesb.append("Level Designer\n");
  rolesb.append("Tester\n");

  roles = rolesb.toString();
  StringBuilder namesb = new StringBuilder();
  namesb.append("Winston Liu\n");
  namesb.append("Winston Liu\n");
  namesb.append("Winston Liu\n");
  namesb.append("Winston Liu\n");
  namesb.append("Winston Liu\n");
  namesb.append("Winston Liu\n");
  namesb.append("Winston Liu\n");
  names = namesb.toString();
}

String names;
String roles;
