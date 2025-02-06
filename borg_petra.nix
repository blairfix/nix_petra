{ config, ... }:
{

    # borg petra
    #----------------------------------------

    systemd.user.timers."borg_petra" = {
	wantedBy = [ "timers.target" ];
	timerConfig = {
	    OnCalendar = "*-*-*  *:33:00";
	    Persistent = "true";
	    Unit = "borg_petra.service";
	};
    };

    systemd.user.services."borg_petra" = {
	serviceConfig = {
	    Type = "simple";
	    ExecStart = "/home/petra/bin/backup.sh";
	};
    };

}
