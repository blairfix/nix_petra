{ config, ... }:
{

    # borg petra
    #----------------------------------------

    systemd.timers."borg_petra" = {
	wantedBy = [ "timers.target" ];
	timerConfig = {
	    OnCalendar = "*-*-*  *:19:00";
	    Persistent = "true";
	    Unit = "borg_petra.service";
	};
    };

    systemd.services."borg_petra" = {
	serviceConfig = {
	    Type = "simple";
	    User = "petra";
	};
	path = with pkgs; [ bash ];
	script = ''
	    bash /home/petra/bin/backup.sh
	    '';
    };

}
