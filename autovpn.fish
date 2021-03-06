#!/usr/bin/fish
function otpVPN --description "generater OTP"
    if test -n $SERECTKEY # delare SERECTKEY in config.fish
        set -g CODE (oathtool --totp -b -d 6 $SERECTKEY)
        echo $CODE
    end
end


function configVPN --description "write USER, PASSWORD to file"
    set -x otp (otpVPN)
    set -x passVPN $otp$SUFFIXES # globalPass universal variable
    #set -x passVPN ($otp + $globalPass) # globalPass universal variable
    echo $userVPN > vpn.txt
    echo $passVPN >> vpn.txt
end

function connectVPN
    while true
        if test (nmcli con show --active | awk '/tap0/') # tap0 is name connection otpvpn
            sleep 5
        else
            notify-send "VPN connecting!!!"
            configVPN
            eval command echo $passuser | sudo -S openvpn --config vccloud-devteam.ovpn
        end
    end
end

connectVPN
