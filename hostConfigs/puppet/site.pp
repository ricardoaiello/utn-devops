# Configuración específica para los nodos por defectos. En este caso no es ninguna
node default { }

node 'utn-devops-grupo1' {

include 'docker_install'
include 'jenkins'

case $::operatingsystem {
        'Debian', 'Ubuntu' : { include jenkins }
        default  : { notify {"$::operatingsystem no esta soportado":} }
    }

}
