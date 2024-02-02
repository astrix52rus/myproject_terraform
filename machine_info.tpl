%{ for i, name in fqdn ~}
${i + 1}: ${name} ${ip[i]} ${password[i]}
%{ endfor ~}
