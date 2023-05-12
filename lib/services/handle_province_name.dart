String getShortProvinceName(String? name) {
  if (name == null) {
    return '';
  }

  if (name.contains("Thành phố")) {
    return name.replaceAll("Thành phố ", '');
  }

  if (name.contains("Tỉnh")) {
    return name.replaceAll("Tỉnh ", '');
  }

  return name;
}
