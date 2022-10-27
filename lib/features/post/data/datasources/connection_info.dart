class ConnectionInfo {
  bool connectionState = true;
  bool connectionAccess() {
    return connectionState = true;
  }
  bool connectionFailure() {
    return connectionState = false;
  }
}