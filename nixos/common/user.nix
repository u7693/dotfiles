with builtins;
let user = fromJSON (readFile ../../user.json);
in {
  users.users.a = {
    home = "/home/" + user.username;
    name = user.username;
    createHome = true;
    description = user.name;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
