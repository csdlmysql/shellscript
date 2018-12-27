#!/usr/bin/fish

function mm_notify
    set mm (string split ' ' (free -mt | grep Total | awk '{ print $4, $3}'))
    set top_info (string split \n (ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -2))
    if test (math $mm[1]) -ge 500
        set message "FBI WARRING!!!" "Memory free verry low: $mm[1]Mb \n TOP process: $top_info[2]"
        command notify-send -i /home/user/file $message
    end
    return $status
end
