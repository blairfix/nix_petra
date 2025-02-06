{ config, ... }:
{

    # borg petra
    #----------------------------------------

    systemd.timers."borg_petra" = {
	wantedBy = [ "timers.target" ];
	timerConfig = {
	    OnCalendar = "*-*-*  *:43:00";
	    Persistent = "true";
	    Unit = "borg_petra.service";
	};
    };

    systemd.services."borg_petra" = {
	serviceConfig = {
	    Type = "simple";
	    User = "root";
	    ExecStart = "/home/petra/bin/backup.sh";
	};
    };

}
