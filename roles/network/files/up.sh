#! /bin/bash
resolve_nameservers=
resolve_search=
resolve_entry='### openvpn entry ###'
resolve_exit='### openvpn exit ###'
for opt in ${!foreign_option_*};do
        if [[ "${!opt}" == 'dhcp-option DOMAIN'* ]];then
                resolve_search="${!opt/dhcp-option DOMAIN/search}"
        elif [[ "${!opt}" == 'dhcp-option DNS'* ]];then
                resolve_nameservers+="${!opt/dhcp-option DNS/nameserver}\n"
        else
                echo "WARN: option not known: ${!opt}"
        fi
done
resolve_temp=$(mktemp /tmp/resolve.XXXXXX)
chmod go+r $resolve_temp
echo -e "${resolve_entry}\n${resolve_search}\n${resolve_nameservers}${resolve_exit}" | tee $resolve_temp
cat /etc/resolv.conf >> $resolve_temp
[ ! -e resolv.conf ] && cp /etc/resolv.conf ./
mv -f $resolve_temp /etc/resolv.conf
