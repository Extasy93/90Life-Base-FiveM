#!/bin/bash

# Couleurs
    NORMAL="\033[0;39m"
    ROUGE="\033[1;31m"
    VERT="\033[1;32m"
    ORANGE="\033[1;33m"
	
# Messages customs
    MSG_180="Une tempête approche, dans 3 minutes la ville sera rasé !"
    MSG_60="Une tempête est aux portes de la ville, fuyez pauvres fous !"
    MSG_30="Mon dieu !! Dans 30 secondes vous serez tous morts si vous ne fuyez pas !"
	
# Path
    FIVEM_PATH=/home/UmbrellaV2

# Screen
    SCREEN="server"

cd $FIVEM_PATH	
running(){
    if ! screen -list | grep -q "$SCREEN"
    then
        return 1
    else
        return 0
    fi
}	

case "$1" in
    # -----------------[ Start ]----------------- #
    start)
	if ( running )
	then
	    echo -e "$ROUGE Le serveur [$SCREEN] est deja démarrer !$NORMAL"
	else
        echo -e "$ORANGE Le serveur [$SCREEN] va démarrer.$NORMAL"
		screen -dm -S $SCREEN
		sleep 2
		screen -x $SCREEN -X stuff "./run.sh +exec server.cfg +set onesync_enableInfinity 1 +set sv_enforceGameBuild 2189
		"
		echo -e "$VERT Session Start ! $NORMAL"
	fi
    ;;
    # -----------------[ Stop ]------------------ #
    stop)
	if ( running )
	then
		echo -e "$VERT Le serveur va être stoppé dans 10s. $NORMAL"
        screen -S $SCREEN -p 0 -X stuff "`printf "say $MSG_30\r"`"; sleep 30
		screen -S $SCREEN -X quit
        echo -e "$ROUGE Le serveur [$SCREEN] a été stopper.$NORMAL"
		sleep 5
		echo -e "$VERT Serveur [$SCREEN] eteint. $NORMAL"
		rm -R $FIVEM_PATH/server-data/cache/
		echo -e "$VERT Nettoyage du cache. $NORMAL"

	else
	    echo -e "Le serveur [$SCREEN] n'est pas démarrer."
	fi
    ;;
    # ----------------[ Restart ]---------------- #
	restart)
	if ( running )
	then
	    echo -e "$ROUGE Le serveur [$SCREEN] fonctionne déja ! $NORMAL"
	else
	    echo -e "$VERT Le serveur [$SCREEN] est eteint. $NORMAL"
	fi
	    echo -e "$ROUGE Le serveur va redémarrer... $NORMAL"
		screen -S $SCREEN -X quit
		echo -e "$VERT Serveur eteint $NORMAL"
		rm -R $FIVEM_PATH/cache/
		echo -e "$VERT Nettoyage du cache. $NORMAL"
		sleep 2
		echo -e "$ORANGE Redémarrage en cours ... $NORMAL"
		sleep 3
        echo -e "$ORANGE Le serveur [$SCREEN] va démarrer.$NORMAL"
		screen -dm -S $SCREEN
		sleep 2
		screen -x $SCREEN -X stuff "./run.sh +exec server.cfg +set onesync_enableInfinity 1 +set sv_enforceGameBuild 2189
		"
		echo -e "$ORANGE Restart des sessions.$NORMAL"
		sleep 1
		echo -e "$VERT Serveur [$SCREEN] démarrer ! $NORMAL"
	;;	
    # -----------------[ Status ]---------------- #
	status)
	if ( running )
	then
	    echo -e "$VERT [$SCREEN] démarrer. $NORMAL"
	else
	    echo -e "$ROUGE [$SCREEN]éteint. $NORMAL"
	fi
	;;
    # -----------------[ Screen ]---------------- #
    screen)
        echo -e "$VERT Screen du serveur [$SCREEN]. $NORMAL"
        screen -R $SCREEN
    ;;
	*)
    echo -e "$ORANGE Utilisation :$NORMAL ./manage.sh {start|stop|status|screen|restart}"
    exit 1
    ;;
esac

exit 0
