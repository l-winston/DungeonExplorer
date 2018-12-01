void showColumn(float x, float y) {
  pushMatrix();
  pushStyle();

  translate(x, y);
  image(columns[COLUMN_BASE], 0, tileh, tilew, tileh);
  image(columns[COLUMN_MID], 0, 0, tilew, tileh);
  image(columns[COLUMN_TOP], 0, -tileh, tilew, tileh);

  popStyle();
  popMatrix();
}
