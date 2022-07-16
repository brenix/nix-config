{ persistence, lib, ... }:
{
  security.acme = {
    defaults.email = "brenix@gmail.com";
    acceptTerms = true;
  };

  environment.persistence = lib.mkIf persistence {
    "/persist".directories = [ "/var/lib/acme" ];
  };
}
